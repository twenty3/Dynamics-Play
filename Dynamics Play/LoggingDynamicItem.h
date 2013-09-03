//
//  LoggingDynamicItem.h
//  Dynamics Play
//
//  Created by 23 on 9/1/13.
//  Copyright (c) 2013 Aged and Distilled. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoggingDynamicItem : NSObject<UIDynamicItem>

@property (nonatomic, copy) NSString* identity;
    // identity, if set, will be used when this dynamic item logs

+ (LoggingDynamicItem*) loggingDynamicItemWithIdentity:(NSString*)identity;


@end
