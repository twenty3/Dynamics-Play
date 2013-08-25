//
//  DynamicButton.h
//  Dynamics Play
//
//  Created by 23 on 8/25/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicButton : UIButton

@property (readonly, nonatomic) UIPushBehavior* pushBehavior;
@property (readonly, nonatomic) UIDynamicItemBehavior* dynamicItemBehavior;
@property (readonly, nonatomic) UICollisionBehavior* collisionBehavior;

@end