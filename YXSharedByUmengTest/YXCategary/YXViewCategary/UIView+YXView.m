//
//  UIView+YXView.m
//  YXSharedByUmengTest
//
//  Created by ios on 2020/4/3.
//  Copyright © 2020 August. All rights reserved.
//

#import "UIView+YXView.h"
#import <objc/runtime.h>

static const char *YXTapGestureBlock;

@implementation UIView (YXView)

#pragma mark - 添加点击手势
- (void)addTapGestureWithBlock:(void(^)(UIView *view))block {
    
    if (block) {
        self.tapGestureBlock = block;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tapGesture];
    }
}

- (void)setTapGestureBlock:(void (^)(UIView *))tapGestureBlock {
    
    objc_setAssociatedObject(self, &YXTapGestureBlock, tapGestureBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void(^)(UIView *))tapGestureBlock {
    
    return objc_getAssociatedObject(self, &YXTapGestureBlock);
}

- (void)tapAction {
    
    id block = objc_getAssociatedObject(self, &YXTapGestureBlock);
    if (block == nil) {
        return;
    }
    
    void(^tapGestureBlock)(UIView *) = block;
    tapGestureBlock(self);
}

@end
