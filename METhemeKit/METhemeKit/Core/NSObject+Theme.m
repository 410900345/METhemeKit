//
//  NSObject+Theme.m
//  ThemeDemo
//
//  Created by ss on 16/1/12.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "NSObject+Theme.h"
#import "ThemeProperties.h"
#import "NSObject+DeallocBlock.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@implementation NSObject (Theme)
- (void)removePickerForSEL:(SEL)selector{
    NSString *key = NSStringFromSelector(selector);
    [self.pickers removeObjectForKey:key];
}
-(void)setPickers:(NSMutableDictionary<NSString *,MEPicker> *)pickers{
    objc_setAssociatedObject(self, @selector(pickers), pickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (pickers == nil) {
        //如果pickers为空就移除通知
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }
}
-(NSMutableDictionary<NSString *,MEPicker> *)pickers{
    NSMutableDictionary<NSString *,MEPicker> *pickers = objc_getAssociatedObject(self, @selector(pickers));
    if (!pickers) {
        
        if (self.deallocHelperExecutor == nil) {
            __weak typeof(self) weakSelf;
            MEDeallocBlockExecutor *deallocHelper = [[MEDeallocBlockExecutor alloc]initWith:^{
                [[NSNotificationCenter defaultCenter] removeObserver:weakSelf];
            }];
            self.deallocHelperExecutor = deallocHelper;
        }
        
        
        pickers = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, @selector(pickers), pickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //初始化的时候添加通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTheme) name:kMEThemeChangeNotification object:nil];
    }
    return pickers;
}
- (void)changeTheme {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, MEPicker  _Nonnull obj, BOOL * _Nonnull stop) {
        SEL sel = NSSelectorFromString(key);
        id result = obj();
        [UIView animateWithDuration:METhemeAnimationDuration animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            if ([self respondsToSelector:sel]) {
                [self performSelector:sel withObject:result];
            }
#pragma clang diagnostic pop
        }];
        
    }];
}
@end
