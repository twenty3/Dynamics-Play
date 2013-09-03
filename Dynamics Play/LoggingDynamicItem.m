//
//  LoggingDynamicItem.m
//  Dynamics Play
//
//  Created by 23 on 9/1/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import "LoggingDynamicItem.h"

@implementation LoggingDynamicItem

+ (LoggingDynamicItem*) loggingDynamicItemWithIdentity:(NSString*)identity
{
    LoggingDynamicItem* item = [LoggingDynamicItem new];
    item.identity = identity;
    return item;
}

#pragma mark - UIDynamicItem

- (CGRect)bounds
{
    return (CGRect){0.0, 0.0, 100.0, 100.0};
}

- (CGPoint)center
{
    return (CGPoint){50.0, 50.0};
}

- (CGAffineTransform)transform
{
    return CGAffineTransformIdentity;
}

- (void)setCenter:(CGPoint)center
{
    NSString* idString = (self.identity == nil) ? @"" : [NSString stringWithFormat:@"%@ - ", self.identity];
    NSLog(@"%@Center: %@", idString, NSStringFromCGPoint(center));
}

- (void)setTransform:(CGAffineTransform)transform
{
    NSString* idString = (self.identity == nil) ? @"" : [NSString stringWithFormat:@"%@ - ", self.identity];
    NSLog(@"%@Transform: %@", idString, NSStringFromCGAffineTransform(transform));
}

@end
