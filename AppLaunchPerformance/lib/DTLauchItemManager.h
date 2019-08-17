//
//  DTLauchManager.h
//  AppLaunchPerformance
//
//  Created by 金秋成 on 2019/8/16.
//  Copyright © 2019 金秋成. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DTLaunchItem.h"


@protocol DTLauchItemManagerLogger <NSObject>

-(void)willLaunchForKey:(NSString *)key;

-(void)didLaunchedForKey:(NSString *)key;

-(void)willExcuteFunction:(NSString *)name forLaunchKey:(NSString *)key;

-(void)didExcutedFunction:(NSString *)name forLaunchKey:(NSString *)key;

-(void)occurError:(NSError *)error;

@end


NS_ASSUME_NONNULL_BEGIN

@interface DTLauchItemManager : NSObject

+(instancetype)sharedInstance;

-(void)setLoger:(id<DTLauchItemManagerLogger>)logger;

-(void)launchForKey:(NSString * _Nonnull)key;

@end

NS_ASSUME_NONNULL_END
