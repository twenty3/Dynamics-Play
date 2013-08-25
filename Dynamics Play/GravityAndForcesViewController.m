//
//  ViewController.m
//  Dynamics Play
//
//  Created by 23 on 8/22/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import "GravityAndForcesViewController.h"

#import "DynamicButton.h"

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
