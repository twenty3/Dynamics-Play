//
//  AngularViewController.m
//  Dynamics Play
//
//  Created by 23 on 8/25/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import "AngularViewController.h"
#import "DynamicButton.h"

@interface AngularViewController ()

@property (nonatomic, strong) DynamicButton* button;
@property (nonatomic, retain) UIDynamicAnimator* animator;


@end


@implementation AngularViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGSize parentSize = self.view.frame.size;
    
    const CGFloat radius = 160.0;
    const CGPoint origin = {(parentSize.width - radius) / 2.0, (parentSize.height - radius) / 2.0};
    
    self.button = [[DynamicButton alloc] initWithFrame:(CGRect){origin, {radius, radius}}];
    [self.button setTitle:@"Spin" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.button];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    [self.animator addBehavior:self.button.dynamicItemBehavior];
    [self.animator addBehavior:self.button.pushBehavior];
}


- (void) buttonWasTapped:(id)sender
{
    DynamicButton* tappedButton = (DynamicButton*)sender;
    [tappedButton.dynamicItemBehavior addAngularVelocity:5.0 forItem:tappedButton];
}


@end
