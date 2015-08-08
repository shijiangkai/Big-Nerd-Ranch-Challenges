//
//  BNRAppDelegate.m
//  Hypnosister
//
//  Created by 史江凯 on 15/4/19.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

#import "BNRAppDelegate.h"
#import "BNRHypnosisView.h"
@interface BNRAppDelegate() <UIScrollViewDelegate>
@property (strong,nonatomic) BNRHypnosisView *thirdHview;
@end
@implementation BNRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    CGRect firstFrame = self.window.frame;
////    CGRect tFrame = self.window.frame;
//    
//    BNRHypnosisView *firstView = [[BNRHypnosisView alloc] initWithFrame:firstFrame];
////    BNRHypnosisView *tView  = [[BNRHypnosisView alloc] initWithFrame:tFrame];
//    [self.window addSubview:firstView];
//    [tView addSubview:firstView];
    CGRect screenRect = self.window.bounds;
    CGRect bigRect = screenRect;
    bigRect.size.width *= 2.0;
//    bigRect.size.height *= 2.0;
    
    UIScrollView *scrollView= [[UIScrollView alloc] initWithFrame:screenRect];
    scrollView.delegate = self;
    [self.window addSubview:scrollView];
    
    BNRHypnosisView *hypnosisView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    [scrollView addSubview:hypnosisView];
    
//    screenRect.origin.x += screenRect.size.width;
//    BNRHypnosisView *anotherView = [[BNRHypnosisView alloc] initWithFrame:screenRect];
//    [scrollView setPagingEnabled:YES];
//    [scrollView addSubview:anotherView];
    
    screenRect.origin.x += screenRect.size.width;
    _thirdHview = [[BNRHypnosisView alloc] initWithFrame:screenRect];
    [scrollView setPagingEnabled:NO];
    [scrollView addSubview:_thirdHview];
    
    scrollView.minimumZoomScale = 1.0;
    scrollView.maximumZoomScale = 2.0;
    
    CGRect scrollRect = bigRect;
    scrollRect.size.width *= 4;
    scrollView.contentSize = scrollRect.size;
    
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _thirdHview;
}
@end
