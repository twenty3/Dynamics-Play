//
//  DynamicButton.m
//  Dynamics Play
//
//  Created by 23 on 8/25/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import "Dynamicbutton.h"

#import <QuartzCore/QuartzCore.h>


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
    self.dynamicItemBehavior.angularResistance = 0.5;
}


#pragma mark - UIView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = floor(self.bounds.size.height / 2.0);
}

@end
