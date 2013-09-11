//
//  AngularViewController.m
//  Dynamics Play
//
//  Created by 23 on 8/25/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import "AngularViewController.h"

#import "DynamicButton.h"
#import "LoggingDynamicItem.h"


@interface AngularViewController ()

@property (nonatomic, strong) DynamicButton* button;
@property (nonatomic, strong) UIDynamicAnimator* animator;

@property (nonatomic, strong) UIAttachmentBehavior* dragAttachment;
@property (nonatomic, strong) UIPanGestureRecognizer* panRecognizer;

@property (nonatomic, strong) LoggingDynamicItem* loggingItem;

@end


@implementation AngularViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize parentSize = self.view.frame.size;
    
    const CGFloat diameter = 160.0;
    const CGPoint origin = {(parentSize.width - diameter) / 2.0, (parentSize.height - diameter) / 2.0};
    
    self.button = [[DynamicButton alloc] initWithFrame:(CGRect){origin, {diameter, diameter}}];
    [self.button setTitle:@"Spin" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.button];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    [self.animator addBehavior:self.button.dynamicItemBehavior];
    [self.animator addBehavior:self.button.pushBehavior];
    
    // attach the button to its current location (like the center of a pinwheel)
    UIAttachmentBehavior* pinAttachment = [[UIAttachmentBehavior alloc] initWithItem:self.button attachedToAnchor:self.button.center];
    [self.animator addBehavior:pinAttachment];
    
    // Add a pan recognizer
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.button addGestureRecognizer:self.panRecognizer];
    
    // Add a logging item
    self.loggingItem = [LoggingDynamicItem loggingDynamicItemWithIdentity:nil];
    [self.button.dynamicItemBehavior addItem:self.loggingItem];
    [self.button.pushBehavior addItem:self.loggingItem];
}

- (void) buttonWasTapped:(id)sender
{
    DynamicButton* tappedButton = (DynamicButton*)sender;
    [tappedButton.dynamicItemBehavior addAngularVelocity:5.0 forItem:tappedButton];
    // add the same angular velocity to our logging item so we can see the effect
    [tappedButton.dynamicItemBehavior addAngularVelocity:5.0 forItem:self.loggingItem];
}


-(void) didPan:(UIPanGestureRecognizer*)panRecognizer
{
    if ( panRecognizer.state == UIGestureRecognizerStateBegan )
    {
        //CGPoint buttonLocation = [panRecognizer locationInView:self.button];
        CGPoint referenceLocation = [panRecognizer locationInView:self.animator.referenceView];

        UIOffset centerOffset = {0.0, -80.0};
        
        self.dragAttachment = [[UIAttachmentBehavior alloc] initWithItem:self.button offsetFromCenter:centerOffset attachedToAnchor:referenceLocation];
        [self.animator addBehavior:self.dragAttachment];
    }
    else if ( panRecognizer.state == UIGestureRecognizerStateEnded )
    {
        [self.animator removeBehavior:self.dragAttachment];
        self.dragAttachment = nil;
        
        CGPoint velocity = [panRecognizer velocityInView:self.view];
        
        
        // project the velocity vector onto the coordinate system oriented with the tangent line and normal
        // of the contact point.
        // only use the component of the velocity that is tangental to convert to angular velocity
        
        // As a cheat, I'm going to juts convert the linear velocity to
        // an angluar velocity by using the magnitude of the linear velocity
        // the direction of the angular force is fixed the therefor probably wrong most of the time
        
        CGFloat angularVelocity = sqrtf( (velocity.x * velocity.x) + (velocity.y * velocity.y) );
        angularVelocity *= 0.01;
        [self.button.dynamicItemBehavior addAngularVelocity:angularVelocity forItem:self.button];
    }
    else if ( panRecognizer.state == UIGestureRecognizerStateChanged )
    {
        CGPoint location = [panRecognizer locationInView:self.animator.referenceView];
        self.dragAttachment.anchorPoint = location;
    }
}
@end
