//
//  YXHomeListCell.m
//  YXSharedByUmengTest
//
//  Created by ios on 2020/4/2.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXHomeListCell.h"

@implementation YXHomeListCell

+ (instancetype)initTableView:(UITableView *)tableView {
    
    YXHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YXHomeListCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)reloadDataWithIndexPath:(NSIndexPath *)indexPath arr:(NSMutableArray *)arr {
    
    self.titleLab.text = [arr[indexPath.row] objForKey:@"title"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
