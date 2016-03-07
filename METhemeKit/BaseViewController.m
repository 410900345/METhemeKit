//
//  BaseViewController.m
//  METhemeKit
//
//  Created by Yasin on 16/3/7.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseNavViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 修改导航栏背景图片
    [self changeNavBarBackgroundWithType];
}

-(void)changeNavBarBackgroundWithType{
    /**
     *  手势返回的时候滑动一半不返回，这里做导航条的背景颜色更改，主要针对导航条背景颜色不一致的页面
     */
    if (self.navigationController.viewControllers.lastObject == self) {
        if ([self.navigationController isKindOfClass:[BaseNavViewController class]]) {
            BaseNavViewController *baseNav = (BaseNavViewController *)self.navigationController;
            [baseNav changeNavBarType:NavBarLevel1];
        }
    }
}

@end
