//
//  NSDictionary+YXDictionary.m
//  YXSharedByUmengTest
//
//  Created by ios on 2020/4/2.
//  Copyright © 2020 August. All rights reserved.
//

#import "NSDictionary+YXDictionary.h"

@implementation NSDictionary (YXDictionary)

#pragma mark - 检查获取的value值
- (id)objForKey:(id<NSCopying>)key {
    
    id obj = [self objectForKey:key];
    
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    else if ([obj isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", obj];
    }
    
    return obj;
}

@end

@implementation NSMutableDictionary (YXDictionary)

#pragma mark - 检查设置的value值
- (void)setObj:(id)obj forKey:(id<NSCopying>)key {
    
    if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
        obj = @"";
    }
    
    [self setObject:obj forKey:key];
}

@end
