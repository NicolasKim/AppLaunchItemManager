//
//  ViewController.m
//  AppLaunchPerformance
//
//  Created by 金秋成 on 2019/8/16.
//  Copyright © 2019 金秋成. All rights reserved.
//

#import "ViewController.h"
#import "DTLauchItemManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

DT_FUNCTION_EXPORT(StgA,WEIBO)(){
    NSLog(@"初始化微博");
}


DT_FUNCTION_EXPORT(StgB,WriteCookie)(){
    NSLog(@"写入cookie");
}

@end
