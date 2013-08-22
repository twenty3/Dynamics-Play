//
//  ViewController.m
//  Dynamics Play
//
//  Created by 23 on 8/22/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import "ViewController.h"

#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (nonatomic, retain) UILabel* label;
@property (nonatomic, retain) UIDynamicAnimator* animator;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGSize parentSize = self.view.frame.size;
    
    const CGFloat radius = 100.0;
    const CGPoint origin = {(parentSize.width - radius) / 2.0, (parentSize.height - radius) / 2.0};
    self.label = [[UILabel alloc] initWithFrame:(CGRect){origin, {radius, radius}}];
    self.label.text = @"1";
    self.label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:48.0];
    self.label.textColor = [UIColor whiteColor];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor purpleColor];
    self.label.layer.cornerRadius = radius / 2;
    
    [self.view addSubview:self.label];
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    UIPushBehavior* pushBehavior = [[UIPushBehavior alloc] initWithItems:@[self.label] mode:UIPushBehaviorModeInstantaneous];
    [pushBehavior setAngle:0.0 magnitude:1.0];
    
    
    [self.animator addBehavior:pushBehavior];
}


@end
