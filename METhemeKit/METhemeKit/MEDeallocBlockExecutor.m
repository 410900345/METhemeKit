//
//  MEDeallocBlockExecutor.m
//  METhemeKit
//
//  Created by Yasin on 16/3/7.
//  Copyright © 2016年 Yasin. All rights reserved.
//

#import "MEDeallocBlockExecutor.h"

@implementation MEDeallocBlockExecutor
- (instancetype)initWith:(DeallocBlock)deallocBlock{
    self = [super init];
    if (self) {
        _deallocBlock = [deallocBlock copy];
    }
    return self;
}
-(void)dealloc{
    if (self.deallocBlock) {
        self.deallocBlock();
    }
}
@end
