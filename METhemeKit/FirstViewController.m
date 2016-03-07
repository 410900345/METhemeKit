//
//  FirstViewController.m
//  METhemeKit
//
//  Created by Yasin on 16/3/4.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "METhemeKit.h"
@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *themeImageView;
@property (weak, nonatomic) IBOutlet UIButton *themeSureButton;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 70, 90, 30);
    [button me_setTitleColor:[UIColor me_colorPickerForMode:ThemeColorMode_Default] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithRed:0.5397 green:0.9142 blue:0.5158 alpha:1.0]];
    [button addTarget:self action:@selector(changeTheme) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"切换主题" forState:UIControlStateNormal];
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [window addSubview:button];
    
    
    self.themeLabel.me_textColor = [UIColor me_colorPickerForMode:ThemeColorMode_Default];
    
    self.themeImageView.me_image = [UIImage me_imageNamed:@"avatar"];
    
    self.themeSureButton.me_configKey = ThemeMode_Button_NoBackgroundImage_SureButton;
    
}
- (void)changeTheme{
    ThemeType type = [METhemeManager sharedThemeManager].themeType;
    if (type == ThemeDefault) {
        [METhemeManager sharedThemeManager].themeType = ThemeYear;
    } else {
        [METhemeManager sharedThemeManager].themeType = ThemeDefault;
    }
}
- (IBAction)next:(id)sender {
    SecondViewController *view = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:view animated:YES];
}
- (IBAction)changeTemeNotification:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kThemeChangeNotification" object:nil];
}
- (IBAction)removeImageTheme:(id)sender {
    [self.themeImageView removePickerForSEL:@selector(setImage:)];
}


@end
