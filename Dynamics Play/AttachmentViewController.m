//
//  AttachmentViewController.m
//  Dynamics Play
//
//  Created by 23 on 9/2/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import "AttachmentViewController.h"

#import "DynamicButton.h"

@interface AttachmentViewController ()

@property (nonatomic, retain) DynamicButton* button1;
@property (nonatomic, retain) DynamicButton* button2;
@property (nonatomic, retain) UIDynamicAnimator* animator;
@property (nonatomic, retain) UIPanGestureRecognizer* panRecognizer;
@property (nonatomic, retain) UIAttachmentBehavior* dragAttachment;

@end

@implementation AttachmentViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    CGSize parentSize = self.view.frame.size;
    
    const CGFloat radius = 50.0;
    const CGPoint origin = {(parentSize.width - radius) / 2.0, (parentSize.height - radius) / 2.0};
    
    self.button1 = [[DynamicButton alloc] initWithFrame:(CGRect){origin, {radius, radius}}];
    [self.button1 setTitle:@"1" forState:UIControlStateNormal];
    [self.button1 addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button1];

    [self.animator addBehavior:self.button1.dynamicItemBehavior];
    [self.animator addBehavior:self.button1.pushBehavior];
    
    CGPoint origin2 = {origin.x + radius * 2.0, origin.y - radius * 1.6};
    self.button2 = [[DynamicButton alloc] initWithFrame:(CGRect){origin2, {radius, radius}}];
    [self.button2 setTitle:@"2" forState:UIControlStateNormal];
    [self.button2 addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button2];
    
    [self.animator addBehavior:self.button2.dynamicItemBehavior];
    [self.animator addBehavior:self.button2.pushBehavior];
    
    // order of the adding the attachments changes the behavior
    // the behaviors are applied by traversing the tree
    // and the 'winner' for conflicting values changes depending on order
    // try swapping these and see how the drag attachment can override item/item attachment
    
    // add an attachment to drag button 1
    self.dragAttachment = [[UIAttachmentBehavior alloc] initWithItem:self.button1 attachedToAnchor:self.button1.center];
    // a completely rigid attachment will create some issues at boundary collisions
    self.dragAttachment.frequency = -1.0;
    self.dragAttachment.damping = 0.1;
    //[self.animator addBehavior:self.dragAttachment];
    // only want to add when we are actually dragging
    
    // attach buttons to each other
    UIAttachmentBehavior* attachment = [[UIAttachmentBehavior alloc] initWithItem:self.button1 attachedToItem:self.button2];
    attachment.frequency = 10.0;
    attachment.damping = 1.0;
    [self.animator addBehavior:attachment];
    
    // add some gravity
    UIGravityBehavior* gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.button1, self.button2]];
    [self.animator addBehavior:gravityBehavior];
    
    // add collisions with a boundary at the top of the tab bar
    UITabBar* tabBar = self.tabBarController.tabBar;
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.button1, self.button2]];
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [collisionBehavior setTranslatesReferenceBoundsIntoBoundaryWithInsets:(UIEdgeInsets){0.0, 0.0, tabBar.frame.size.height, 0.0}];
    [self.animator addBehavior:collisionBehavior];
    
    // Add a pan recognizer to drag button 1
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPan:)];
    [self.button1 addGestureRecognizer:self.panRecognizer];
    
}

#pragma mark - Actions

-(void) buttonWasTapped:(id)sender
{
    DynamicButton* tappedButton = (DynamicButton*)sender;
    tappedButton.pushBehavior.active = YES;
}

-(void) didPan:(UIPanGestureRecognizer*)panRecognizer
{
    // We'll only add the attachment for dragging, when a drag starts
    // otherwise the attachment will hold the item in place even
    // when we are not moving it.
    if ( panRecognizer.state == UIGestureRecognizerStateBegan )
    {
        self.dragAttachment.anchorPoint = self.button1.center;
        [self.animator addBehavior:self.dragAttachment];
    }
    else if ( panRecognizer.state == UIGestureRecognizerStateEnded )
    {
        [self.animator removeBehavior:self.dragAttachment];
        // apply the velocity of the pan so we can 'fling' the item
        CGPoint velocity = [panRecognizer velocityInView:self.view];
        [self.button1.dynamicItemBehavior addLinearVelocity:velocity forItem:self.button1];
    }
    else if ( panRecognizer.state == UIGestureRecognizerStateChanged )
    {
        //CGPoint delta = [panRecognizer translationInView:self.view];
        //CGPoint anchorPoint = self.dragAttachment.anchorPoint;
        
        //NSLog(@"delta: %@  anchor: %@", NSStringFromCGPoint(delta), NSStringFromCGPoint(anchorPoint));
        
        //anchorPoint.x += delta.x;
        //anchorPoint.y += delta.y;
        //self.dragAttachment.anchorPoint = anchorPoint;
        
        [self.dragAttachment setAnchorPoint:[panRecognizer locationInView:self.view]];

    }
}



@end
