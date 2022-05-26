//
//  AppDelegate.m
//  SobotOrderDemo
//
//  Created by lizh on 2022/5/26.
//

#import "AppDelegate.h"
#import <SobotOrderSDK/SobotOrderApi.h>
#import <SobotCommon/SobotCacheEntity.h>
#import "RootDemoController.h"
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)switchRootViewController
{
    // 版本号相同：这次打开和上次打开的是同一个版本
    
    if (![SobotOrderClient isLogin]) {
        LoginViewController * login = [[LoginViewController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:login];
        nav.navigationBarHidden=YES;
        self.window.backgroundColor = UIColor.whiteColor;
        self.window.rootViewController=nav;
    } else {
        [self goHome];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    SobotCacheEntity *config = [[SobotCacheEntity alloc] init];
    config.bundleName = @"SobotOrder";
    config.languageTableName = @"SobotLocal";
    config.languagePathInBundle = @"Localizable";
    config.colorTableName = @"SobotColor";
    config.absoluetelanguage = @"zh-Hans";
    SobotKitConfig *kitInfo = [[SobotKitConfig alloc]init];
    kitInfo.isShowExitAlterView = YES;
    [SobotOrderApi initWithHost:@"" config:config kitInfo:kitInfo result:^(NSInteger code, id  _Nullable obj, NSString * _Nullable msg) {

    }];
    
    [self switchRootViewController];
    return YES;
}

-(void)goHome{
//    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.window.backgroundColor = UIColor.whiteColor;
//    RootDemoController * tabBarController = [[RootDemoController alloc]init];
//    self.window.rootViewController = tabBarController;
////    self.window.rootViewController = viewController;
//    [self.window makeKeyWindow];
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window.rootViewController=[stryBoard instantiateInitialViewController];
}


#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
