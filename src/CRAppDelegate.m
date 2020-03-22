//
//  CRAppDelegate.m
//  Combo Recovery
//
//  Created by srich on 11/7/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import "CRAppDelegate.h"

@implementation CRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *names = @[@"My Lock"];
    NSArray *locations = @[@"Work Locker"];
    NSArray *combos = @[@"10 - 20 - 30"];
    NSArray *obj = @[names,locations,combos,@YES];
    NSArray *keys = @[@"nameArray",@"locationArray",@"comboArray",@"firstLaunch"];
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjects:obj forKeys:keys];
    [defaults registerDefaults:dictionary];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
