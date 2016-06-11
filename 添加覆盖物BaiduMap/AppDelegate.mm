//
//  AppDelegate.m
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-3-21.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "AppDelegate.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "ViewController.h"

@interface AppDelegate () <BMKGeneralDelegate>
/** 地图管理对象 */
@property (nonatomic,strong) BMKMapManager *mapManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc] init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [self.mapManager start:@"nlgQnMq9CrhgyLeKFMqwXbKgl7spxVLl"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    // Add the navigation controller's view to the window and display.
    //    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end
