//
//  AppDelegate.m
//  3DTouchDemo
//
//  Created by shangkunwu on 15/11/4.
//  Copyright © 2015年 j1. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "FloatingViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *userInfoDict = @{@"url1":@"https://github.com/"
                                   ,@"url2":@"http://baidu.com"
                                   ,@"url3":@"http://blog.csdn.net/code/newest.html"};
    
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc]initWithType:@"type1" localizedTitle:@"养生堂" localizedSubtitle:@"中华老字号" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeShare] userInfo:userInfoDict];
    
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc]initWithType:@"type2" localizedTitle:@"雅诗兰黛" localizedSubtitle:@"奢牌尖货" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch] userInfo:userInfoDict];
    
    UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc]initWithType:@"type3" localizedTitle:@"东阿阿胶" localizedSubtitle:@"华润出品" icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCompose] userInfo:userInfoDict];

    [UIApplication sharedApplication].shortcutItems = @[item1,item2,item3];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    MainViewController *mainCtrl = [[MainViewController alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainCtrl];
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    
    //判断launchOptions字典内的UIApplicationLaunchOptionsShortcutItemKey是否为空
    if ([launchOptions objectForKey:UIApplicationLaunchOptionsShortcutItemKey])
    {
        NSLog(@"从UIApplicationShortcutItem启动到程序的");
        //当不为空时,application:didFinishLaunchWithOptions方法返回false，否则返回true
        return false;
    }else{
        return true;
    }

    
    return YES;
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
{
    if ([shortcutItem.type isEqualToString:@"type1"] ) {
         NSLog(@"******  点击了养生堂!  *******");
        
        
       
        
        //UINavigationController *ctrl =  self.window.rootViewController;
        
//        FloatingViewController *floatCtrl = [[FloatingViewController alloc]init];
//        floatCtrl.urlStr = (NSString *)[shortcutItem.userInfo objectForKey:@"url1"];
//        
//     
//        [ctrl pushViewController: animated:<#(BOOL)#>];
        
       
        completionHandler(YES);
        
     
        
    }
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
