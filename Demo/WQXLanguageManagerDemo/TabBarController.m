//
//  TabBarController.m
//  WQXLanguageManagerDemo
//
//  Created by 温群香 on 2021/1/29.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UIViewController *vc0 = [[NSClassFromString(@"ViewController0") alloc] init];
    vc0.tabBarItem.title = @"item0";
    UIViewController *vc1 = [[NSClassFromString(@"ViewController1") alloc] init];
    vc1.tabBarItem.title = @"item1";
    [self addChildViewController:vc0];
    [self addChildViewController:vc1];
}

@end
