//
//  NSDictionary+YXDictionary.h
//  YXSharedByUmengTest
//
//  Created by ios on 2020/4/2.
//  Copyright © 2020 August. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (YXDictionary)

/** 检查获取的value值 */
- (id)objForKey:(id<NSCopying>)key;

@end

@interface NSMutableDictionary (YXDictionary)

/** 检查设置的value值 */
- (void)setObj:(id)obj forKey:(id<NSCopying>)key;

@end

NS_ASSUME_NONNULL_END
