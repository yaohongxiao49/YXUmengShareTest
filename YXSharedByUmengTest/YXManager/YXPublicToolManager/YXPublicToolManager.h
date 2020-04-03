//
//  YXPublicToolManager.h
//  YXSharedByUmengTest
//
//  Created by ios on 2020/4/3.
//  Copyright © 2020 August. All rights reserved.
//

#import <Foundation/Foundation.h>

//打印的宏定义
#if DEBUG
#define NSLog(...) NSLog(@"%s %d %@", __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#define FxLog(...) NSLog(@"%s %d %@", __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#define FxLog(...)
#endif

NS_ASSUME_NONNULL_BEGIN

/** 第三方平台枚举 */
typedef NS_ENUM(NSUInteger, YXPlatformType) {
    /** 微信 */
    YXPlatformTypeWechat,
    /** 新浪微博 */
    YXPlatformTypeSina,
};

@interface YXPublicToolManager : NSObject

+ (YXPublicToolManager *)instanceManager;

/**
 * 判断第三方平台是否存在
 * @param platformType 第三方平台枚举
 */
- (BOOL)judgePlatformAlreadyInstall:(YXPlatformType)platformType;

@end

NS_ASSUME_NONNULL_END
