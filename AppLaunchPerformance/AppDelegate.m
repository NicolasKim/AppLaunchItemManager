//
//  AppDelegate.m
//  AppLaunchPerformance
//
//  Created by 金秋成 on 2019/8/16.
//  Copyright © 2019 金秋成. All rights reserved.
//

#import "AppDelegate.h"
//#import <mach-o/loader.h>
#import "DTLauchItemManager.h"


@interface DTLauchItemManagerLog : NSObject<DTLauchItemManagerLogger>

@end

@implementation DTLauchItemManagerLog

-(void)willLaunchForKey:(NSString *)key{
    NSLog(@"%s key => %@",__func__,key);
}

-(void)didLaunchedForKey:(NSString *)key{
    NSLog(@"%s key => %@",__func__,key);
    NSLog(@"=========================");
}

-(void)willExcuteFunction:(NSString *)name forLaunchKey:(NSString *)key{
    NSLog(@"%s key => %@ name => %@",__func__,key,name);
}

-(void)didExcutedFunction:(NSString *)name forLaunchKey:(NSString *)key{
    NSLog(@"%s key => %@ name => %@",__func__,key,name);
}

@end

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[DTLauchItemManager sharedInstance] setLoger: [[DTLauchItemManagerLog alloc] init]];
    [[DTLauchItemManager sharedInstance] launchForKey:@"StgA"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[DTLauchItemManager sharedInstance] launchForKey:@"StgB"];
    });
    
    
    
    return YES;
}

#pragma mark - UISceneSession lifecycle

- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
