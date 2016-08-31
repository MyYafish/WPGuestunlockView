//
//  AppDelegate.m
//  WPGestureunlockViewController
//
//  Created by 吴鹏 on 16/8/26.
//  Copyright © 2016年 wupeng. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController * vc = [[ViewController alloc]init];
    
    UINavigationController * na = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = na;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
