//
//  YXHomeListSecHeaderView.h
//  YXSharedByUmengTest
//
//  Created by ios on 2020/4/3.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YXHomeListSecHVBlock)(void);

@interface YXHomeListSecHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIImageView *rightArrowImg;

@property (nonatomic, strong) NSMutableDictionary *dic;
@property (nonatomic, copy) YXHomeListSecHVBlock yxHomeListSecHVBlock;

@end

NS_ASSUME_NONNULL_END
