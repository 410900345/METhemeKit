//
//  BaseNavViewController.m
//  METhemeKit
//
//  Created by Yasin on 16/3/7.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "BaseNavViewController.h"
#import "FirstViewController.h"

@interface BaseNavViewController ()<UINavigationControllerDelegate>

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    __weak typeof(self) weakSelf = self;

    self.delegate = weakSelf;
}
-(void)changeNavBarType:(NavBarType)navBarType{
    [self.navigationBar me_setBackgroundImageForBarMetrics:UIBarMetricsDefault WithType:navBarType];
    if (navBarType == NavBarLevel1) {
        self.navigationBar.shadowImage = [UIImage imageNamed:@"navigationBarShadowImage"];
    } else {
        self.navigationBar.shadowImage = [UIImage new];
    }
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

//    NSLog(@" willShowViewController %@ ; viewControlers %@",viewController,navigationController.viewControllers);
    
    if ([viewController isKindOfClass:[FirstViewController class]]) {
        [self changeNavBarType:NavBarDefault];  // 修改导航栏 背景颜色
        
    } else {
        [self changeNavBarType:NavBarLevel1]; // 修改导航栏 背景颜色
    }
}

@end
