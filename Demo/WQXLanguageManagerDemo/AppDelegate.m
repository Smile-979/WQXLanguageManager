//
//  AppDelegate.m
//  WQXLanguageManagerDemo
//
//  Created by 温群香 on 2021/1/30.
//

#import "AppDelegate.h"

#import "WQXLanguageManager.h"
#import "TabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    // 第一步，先设置支持的语言
    [WQXLanguageManager wqx_setSupportedLanguages:@[@"zh-Hans", @"en", @"ja", @"fr"]];
    // 第二步，设置当前语言，如果不设置，那么会跟随系统语言，如果第一步设置支持的语言不包含当前的系统语言，那么默认会使用英语
    [WQXLanguageManager wqx_setCurrentAppLanguageWithKey:@"zh-Hans"];

    TabBarController *rootViewController = [[TabBarController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];

    return YES;
}


@end
