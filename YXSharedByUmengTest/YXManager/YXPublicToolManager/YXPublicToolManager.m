//
//  YXPublicToolManager.m
//  YXSharedByUmengTest
//
//  Created by ios on 2020/4/3.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXPublicToolManager.h"

@implementation YXPublicToolManager

+ (YXPublicToolManager *)instanceManager {
    
    static YXPublicToolManager *yxPublicToolManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        yxPublicToolManager = [YXPublicToolManager new];
    });
    return yxPublicToolManager;
}

#pragma mark - 判断第三方平台是否存在
- (BOOL)judgePlatformAlreadyInstall:(YXPlatformType)platformType {
    
    NSString *platform = [[NSString alloc] init];
    switch (platformType) {
        case YXPlatformTypeWechat:
            platform = @"weixin://";
            break;
        case YXPlatformTypeSina:
            platform = @"sinaweibo://";
            break;
        default:
            break;
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:platform]]) {
        return YES;
    }
    return NO;
}

@end
