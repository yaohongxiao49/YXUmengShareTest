//
//  YXHomeListVC.m
//  YXSharedByUmengTest
//
//  Created by ios on 2020/4/2.
//  Copyright © 2020 August. All rights reserved.
//

#import "YXHomeListVC.h"
#import "YXHomeListCell.h"
#import "YXHomeListSecHeaderView.h"

@interface YXHomeListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *secArr;
@property (nonatomic, strong) NSMutableArray *cellArr;
@property (nonatomic, assign) NSInteger nowOpenIndex;

@end

@implementation YXHomeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[YXPublicShareManager instanceManager] initSharePlatform:(NSMutableDictionary *)@{@"wechat":@{@"appKey":@"xxx", @"appSecret":@"xxx", @"redirectURL":@""}, @"qq":@{@"appKey":@"xxx", @"appSecret":@"xxx", @"redirectURL":@""}, @"sina":@{@"appKey":@"xxx", @"appSecret":@"xxx", @"redirectURL":@""}, @"alipay":@{@"appKey":@"xxx", @"appSecret":@"", @"redirectURL":@"http://www.0086media.com/"}} umengKey:@"5c9dadcb3fc195d077000808"];
    
    self.navigationItem.title = @"分享列表";
    [self initView];
}

#pragma mark - 修改数组数据
- (void)changeToolArrayForSetDic:(NSInteger)key keyTitle:(NSString *)keyTitle keyValue:(id)keyValue {
    
    [self.secArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([[obj objForKey:@"type"] integerValue] == key) {
            [obj setObject:keyValue forKey:keyTitle];
            *stop = YES;
        }
    }];
}

#pragma mark - 分享到三方平台
- (void)shareToPlatformByShareType:(YXShareContentType)shareType type:(UMSocialPlatformType)type {
    
    BOOL boolWechat = type == UMSocialPlatformType_WechatSession ? YES : type == UMSocialPlatformType_WechatTimeLine ? YES : NO;
    BOOL boolSina = type == UMSocialPlatformType_Sina ? YES : NO;
    if ((boolWechat && ![[YXPublicToolManager instanceManager] judgePlatformAlreadyInstall:YXPlatformTypeWechat]) || (boolSina && ![[YXPublicToolManager instanceManager] judgePlatformAlreadyInstall:YXPlatformTypeSina])) {
        return;
    }
    
    switch (shareType) {
        case YXShareContentTypeWord: {
            [[YXPublicShareManager instanceManager] shareTextByPlatformType:type title:@"标题" text:@"内容" shareUrl:@"www.baidu.com" selfVC:self successBlock:^(id  _Nonnull success) {
                
            } failBlock:^(id  _Nonnull fail) {
                
            }];
            break;
        }
        case YXShareContentTypeImg: {
            [[YXPublicShareManager instanceManager] shareImgByPlatformType:type img:@"" selfVC:self successBlock:^(id  _Nonnull success) {
                
            } failBlock:^(id  _Nonnull fail) {
                
            }];
            break;
        }
        case YXShareContentTypeWeb: {
            [[YXPublicShareManager instanceManager] shareTextByPlatformType:type title:@"标题" text:@"内容" shareUrl:@"www.baidu.com" selfVC:self successBlock:^(id  _Nonnull success) {
                
            } failBlock:^(id  _Nonnull fail) {
                
            }];
            break;
        }
        case YXShareContentTypeMusic: {
            [[YXPublicShareManager instanceManager] shareMusicByPlatformType:type title:@"标题" text:@"内容" iconImg:@"YXDownArrowImg" musicUrl:@"www.baidu.com" selfVC:self successBlock:^(id  _Nonnull success) {
                
            } failBlock:^(id  _Nonnull fail) {
                
            }];
            break;
        }
        case YXShareContentTypeVideo: {
            [[YXPublicShareManager instanceManager] shareVideoByPlatformType:type title:@"标题" text:@"内容" iconImg:@"YXDownArrowImg" videoUrl:@"www.baidu.com" selfVC:self successBlock:^(id  _Nonnull success) {
                
            } failBlock:^(id  _Nonnull fail) {
                
            }];
            break;
        }
        case YXShareContentTypeMiniProgram: {
            NSData *imgData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"YXDownArrowImg" ofType:@"png"]];
            [[YXPublicShareManager instanceManager] shareMiniProgramByPlatformType:type title:@"标题" text:@"内容" iconImg:@"YXDownArrowImg" webpageUrl:@"www.baidu.com" miniProgramName:@"小程序名" miniProgramPath:@"pages/page10007/page10007" miniProgramImgData:imgData miniProgramType:UShareWXMiniProgramTypeTest selfVC:self successBlock:^(id  _Nonnull success) {
                
            } failBlock:^(id  _Nonnull fail) {
                
            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.secArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.secArr[section] objForKey:@"cellArr"] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXHomeListCell *cell = [YXHomeListCell initTableView:tableView];
    [cell reloadDataWithIndexPath:indexPath arr:[self.secArr[indexPath.section] objForKey:@"cellArr"]];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger shareType = [[self.secArr[indexPath.section] objForKey:@"type"] integerValue];
    NSInteger platformType = [[[self.secArr[indexPath.section] objForKey:@"cellArr"][indexPath.row] objForKey:@"type"] integerValue];
    [self shareToPlatformByShareType:shareType type:platformType];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    __weak typeof(self) weakSelf = self;
    YXHomeListSecHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([YXHomeListSecHeaderView class])];
    view.dic = self.secArr[section];
    view.yxHomeListSecHVBlock = ^{

        [weakSelf.secArr enumerateObjectsUsingBlock:^(NSMutableDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

            if ([[obj objForKey:@"type"] integerValue] == [[weakSelf.secArr[section] objForKey:@"type"] integerValue]) {
                if ([[weakSelf.secArr[section] objForKey:@"type"] integerValue] == YXShareContentTypeDefault) {
                    [[YXPublicShareManager instanceManager] showUmengShareViewByPlatformArr:@[@(UMSocialPlatformType_Sina), @(UMSocialPlatformType_QQ), @(UMSocialPlatformType_WechatSession)] finishedBlock:^(UMSocialPlatformType platformType) {
                       
                        [weakSelf shareToPlatformByShareType:YXShareContentTypeWeb type:platformType];
                    }];
                }
                else {
                    weakSelf.nowOpenIndex = idx;
                    BOOL boolOpen = [[obj objForKey:@"boolOpen"] boolValue];
                    boolOpen =! boolOpen;
                    [weakSelf changeToolArrayForSetDic:[[obj objForKey:@"type"] integerValue] keyTitle:@"boolOpen" keyValue:@(boolOpen)];
                }
            }
            else {
                [weakSelf changeToolArrayForSetDic:[[obj objForKey:@"type"] integerValue] keyTitle:@"boolOpen" keyValue:@(NO)];
            }
        }];
        [weakSelf.tableView reloadData];
    };
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [[self.secArr[indexPath.section] objForKey:@"boolOpen"] boolValue] ? UITableViewAutomaticDimension : 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

#pragma mark - 初始化视图
- (void)initView {

    [self.tableView reloadData];
}

#pragma mark - 懒加载
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 300;
        _tableView.estimatedSectionHeaderHeight = 10;
        _tableView.estimatedSectionFooterHeight = 0;
        [self.view addSubview:_tableView];
        
        [_tableView registerNib:[UINib nibWithNibName:[YXHomeListCell.class description] bundle:nil] forCellReuseIdentifier:NSStringFromClass([YXHomeListCell class])];
        [_tableView registerNib:[UINib nibWithNibName:[YXHomeListSecHeaderView.class description] bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass([YXHomeListSecHeaderView class])];
    }
    return _tableView;
}
- (NSMutableArray *)secArr {
    
    if (!_secArr) {
        _secArr = [[NSMutableArray alloc] init];
        NSMutableDictionary *dic;
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"友盟分享视图", @"type":@(YXShareContentTypeDefault), @"boolOpen":@(NO), @"cellArr":@[]}];
        [_secArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"文字", @"type":@(YXShareContentTypeWord), @"boolOpen":@(NO), @"cellArr":self.cellArr}];
        [_secArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"图片", @"type":@(YXShareContentTypeImg), @"boolOpen":@(NO), @"cellArr":self.cellArr}];
        [_secArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"网页", @"type":@(YXShareContentTypeWeb), @"boolOpen":@(NO), @"cellArr":self.cellArr}];
        [_secArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"音乐", @"type":@(YXShareContentTypeMusic), @"boolOpen":@(NO), @"cellArr":self.cellArr}];
        [_secArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"视频", @"type":@(YXShareContentTypeVideo), @"boolOpen":@(NO), @"cellArr":self.cellArr}];
        [_secArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"程序", @"type":@(YXShareContentTypeMiniProgram), @"boolOpen":@(NO), @"cellArr":self.cellArr}];
        [_secArr addObject:dic];
    }
    return _secArr;
}
- (NSMutableArray *)cellArr {
    
    if (!_cellArr) {
        _cellArr = [[NSMutableArray alloc] init];
        NSMutableDictionary *dic;
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"新浪微博", @"type":@(UMSocialPlatformType_Sina)}];
        [_cellArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"微信聊天", @"type":@(UMSocialPlatformType_WechatSession)}];
        [_cellArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"微信朋友圈", @"type":@(UMSocialPlatformType_WechatTimeLine)}];
        [_cellArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"QQ聊天页面", @"type":@(UMSocialPlatformType_QQ)}];
        [_cellArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"qq空间", @"type":@(UMSocialPlatformType_Qzone)}];
        [_cellArr addObject:dic];
        
        dic = [[NSMutableDictionary alloc] initWithDictionary:@{@"title":@"腾讯微博", @"type":@(UMSocialPlatformType_TencentWb)}];
        [_cellArr addObject:dic];
    }
    return _cellArr;
}

@end
