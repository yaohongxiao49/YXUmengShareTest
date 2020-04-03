//
//  YXHomeListSecHeaderView.m
//  YXSharedByUmengTest
//
//  Created by ios on 2020/4/3.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXHomeListSecHeaderView.h"

@implementation YXHomeListSecHeaderView

- (void)setDic:(NSMutableDictionary *)dic {
    
    _dic = dic;
    self.titleLab.text = [_dic objForKey:@"title"];
    self.rightArrowImg.transform = CGAffineTransformIdentity;
    if ([[_dic objForKey:@"boolOpen"] boolValue]) {
        self.rightArrowImg.transform = CGAffineTransformRotate(self.rightArrowImg.transform, M_PI);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    __weak typeof(self) weakSelf = self;
    [self.contentView addTapGestureWithBlock:^(UIView * _Nonnull view) {
        
        if (weakSelf.yxHomeListSecHVBlock) {
            weakSelf.yxHomeListSecHVBlock();
        }
    }];
}

@end
