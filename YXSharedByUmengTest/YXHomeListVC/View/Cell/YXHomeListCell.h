//
//  YXHomeListCell.h
//  YXSharedByUmengTest
//
//  Created by ios on 2020/4/2.
//  Copyright © 2020 August. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXHomeListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;

+ (instancetype)initTableView:(UITableView *)tableView;
- (void)reloadDataWithIndexPath:(NSIndexPath *)indexPath arr:(NSMutableArray *)arr;

@end

NS_ASSUME_NONNULL_END
