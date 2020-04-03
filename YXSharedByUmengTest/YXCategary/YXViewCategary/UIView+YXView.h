//
//  UIView+YXView.h
//  YXSharedByUmengTest
//
//  Created by ios on 2020/4/3.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (YXView)

/** 添加点击手势 */
- (void)addTapGestureWithBlock:(void(^)(UIView *view))block;

@end

NS_ASSUME_NONNULL_END
