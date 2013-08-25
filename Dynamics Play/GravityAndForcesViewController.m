//
//  ViewController.m
//  Dynamics Play
//
//  Created by 23 on 8/22/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import "GravityAndForcesViewController.h"

#import <QuartzCore/QuartzCore.h>
@interface DynamicButton : UIButton

@property (readonly, nonatomic) UIPushBehavior* pushBehavior;
@property (readonly, nonatomic) UIDynamicItemBehavior* dynamicItemBehavior;
@property (readonly, nonatomic) UICollisionBehavior* collisionBehavior;

@end

@interface DynamicButton ()

@property (readwrite, nonatomic) UIPushBehavior* pushBehavior;
@property (readwrite, nonatomic) UIDynamicItemBehavior* dynamicItemBehavior;
@property (readwrite, nonatomic) UICollisionBehavior* collisionBehavior;

@end


@implementation DynamicButton

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if ( self )
    {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        [self commonInit];
    }
    return self;
}

- (void) commonInit
{
    // Style
    
    self.backgroundColor = [UIColor purpleColor];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:36.0];
    
    // Behaviors
    
    self.pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self] mode:UIPushBehaviorModeInstantaneous];
    [self.pushBehavior setAngle:-M_PI_2 magnitude:20.0];
    self.pushBehavior.active = NO;
    
    self.dynamicItemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self]];
    self.dynamicItemBehavior.elasticity = 0.5;
    self.dynamicItemBehavior.resistance = 0.1;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = floor(self.bounds.size.height / 2.0);
}

@end

@interface GravityAndForcesViewController ()

@property (nonatomic, retain) DynamicButton* button;
@property (nonatomic, retain) UIDynamicAnimator* animator;

@end

@implementation GravityAndForcesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize parentSize = self.view.frame.size;
    
    const CGFloat radius = 100.0;
    const CGPoint origin = {(parentSize.width - radius) / 2.0, (parentSize.height - radius) / 2.0};
    
    self.button = [[DynamicButton alloc] initWithFrame:(CGRect){origin, {radius, radius}}];
    [self.button setTitle:@"Tap" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.button];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    UIGravityBehavior* gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self.button]];
    
    UICollisionBehavior* collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[self.button]];
    collisionBehavior.collisionMode = UICollisionBehaviorModeBoundaries;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    [self.animator addBehavior:collisionBehavior];
    [self.animator addBehavior:gravityBehavior];
    
    [self.animator addBehavior:self.button.dynamicItemBehavior];
    [self.animator addBehavior:self.button.pushBehavior];
}


- (void) buttonWasTapped:(id)sender
{
    DynamicButton* tappedButton = (DynamicButton*)sender;
    tappedButton.pushBehavior.active = YES;
}

@end
