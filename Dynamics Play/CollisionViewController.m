//
//  CollisionViewController.m
//  Dynamics Play
//
//  Created by 23 on 8/25/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import "CollisionViewController.h"

#import "DynamicButton.h"

const NSString* tabBarBoundaryIdentifier = @"tabBarBoundaryIdentifier";

@interface CollisionViewController ()

@property (nonatomic, retain) NSArray* buttons;
@property (nonatomic, retain) UIDynamicAnimator* animator;
@property (nonatomic, retain) UICollisionBehavior* collisionBehavior;

@end

@implementation CollisionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];

    CGSize parentSize = self.view.frame.size;
    
    const CGFloat radius = 75.0;
    const CGPoint origin = {floor((parentSize.width - radius) / 2.0), floor((parentSize.height - radius) / 2.0)};
    CGRect frame = (CGRect){origin, {radius, radius}};
    
    const NSUInteger buttonCount = 8;
    NSMutableArray* buttons = [NSMutableArray arrayWithCapacity:buttonCount];

    for (int buttonIndex = 0; buttonIndex < buttonCount; buttonIndex++)
    {
        int x = arc4random_uniform(200);
        int y = (int)arc4random_uniform(200);
        
        CGFloat dx = 100 - x;
        CGFloat dy = 100 - y;
        CGRect buttonFrame = CGRectOffset(frame, dx, dy);
        
        NSLog(@"Frame:%@", NSStringFromCGRect(buttonFrame));
        
        DynamicButton* button = [[DynamicButton alloc] initWithFrame:buttonFrame];

        [button setTitle:@"Tap" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonWasTapped:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:button];

        [self.animator addBehavior:button.dynamicItemBehavior];
        [self.animator addBehavior:button.pushBehavior];

        [buttons addObject:button];
    }
    
    self.buttons = buttons;

    UIGravityBehavior* gravityBehavior = [[UIGravityBehavior alloc] initWithItems:self.buttons];
    
    self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:self.buttons];
    self.collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    [self.animator addBehavior:self.collisionBehavior];
    [self.animator addBehavior:gravityBehavior];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    UITabBar* tabBar = self.tabBarController.tabBar;
    CGRect tabBarFrame = [tabBar convertRect:tabBar.bounds toView:self.view];
    
    CGFloat y = CGRectGetMinY(tabBarFrame);
    CGFloat minX = CGRectGetMinX(self.view.frame);
    CGFloat maxX = CGRectGetMaxX(self.view.frame);
    
    CGPoint startPoint = {minX, y};
    CGPoint endPoint = {maxX, y};
    
    [self.collisionBehavior removeBoundaryWithIdentifier:tabBarBoundaryIdentifier];
    [self.collisionBehavior addBoundaryWithIdentifier:tabBarBoundaryIdentifier fromPoint:startPoint toPoint:endPoint];
}

- (void) buttonWasTapped:(id)sender
{
    DynamicButton* tappedButton = (DynamicButton*)sender;
    tappedButton.pushBehavior.active = YES;
}

@end
