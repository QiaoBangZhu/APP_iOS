//
//  TestViewController.m
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "TestViewController.h"
#import "DKWebViewController.h"
#import "YYPhotoGroupView.h"
#import "DKNetAPIClient.h"

@interface TestViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableArray *classNames;

@end

@implementation TestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    
    [self setLeftBarButtonWithTitle:@"Left" withBlock:^(NSInteger tag) {
        NSLog(@"heloo");

        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"我是来测😄😄😄😄😄😄😄😄试的，哈哈哈哈哈哈哈哈😄"];
        text.font = [UIFont systemFontOfSize:14];

        
        YYTextContainer *textContainer = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, CGFLOAT_MAX)];
        YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:textContainer text:text];

        NSLog(@"heloo");

    }];

    [self setRightBarButtonWithTitle:@"Right" withBlock:^(NSInteger tag) {
        NSLog(@"heloo");
    }];
    
    self.title = @"CC Example";
    
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = self.view.bounds;
//    _tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
//    _tableView.scrollIndicatorInsets = _tableView.contentInset;
//    _tableView.backgroundColor = [UIColor clearColor];
//    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    self.titles = @[].mutableCopy;
    self.classNames = @[].mutableCopy;
    [self addCell:@"CCWebViewController" class:@"CCWebViewController"];
    [self addCell:@"YYPhotoGroupView" class:@"YYPhotoGroupView"];
    [self.tableView reloadData];
    
    
//    [self.tableView addLegendHeaderWithRefreshingBlock:^{
//        weakSelf.offset = 0;
//        [weakSelf TableListRequst];
//        if (weakSelf.haveBanner) {
//            [weakSelf bannerImgRequest];
//        }
//    }];
//    [self.tableView addLegendFooterWithRefreshingBlock:^{
//        [weakSelf TableListRequst];
//    }];
//    self.tableView.footer.stateHidden = YES;
//    self.tableView.header.updatedTimeHidden = YES;
//    self.tableView.tableFooterView = [UIView new];
    
//    [LHttpRequest postHttpRequest:@"mc.news.list" parameters:self.requestDic success:^(NSDictionary *responseDic) {
//        NewsListRetDataModel *newsListModel = [NewsListRetDataModel objectWithKeyValues:responseDic];
//        NSArray *list = newsListModel.retData.newsList;
//        
//        if (self.offset == 0) {
//            [self.dataSource removeAllObjects];
//        }
//        [self.dataSource addObjectsFromArray:list];
//        [self.tableView reloadData];
//        
//        if (self.tableView.header.isRefreshing) {
//            [self.tableView.header endRefreshing];
//        }
//        if (self.tableView.footer.isRefreshing) {
//            [self.tableView.footer endRefreshing];
//        }
//        
//        if (newsListModel.retData.lastPage.intValue == 1) {
//            self.tableView.footer.hidden = YES;
//        }
//        else {
//            self.offset += self.max;
//            self.tableView.footer.hidden = NO;
//        }
//        if (!_firstedDataTimeLoaded) {
//            _firstedDataTimeLoaded = YES;
//        }
//    } failure:^(NSString *descript) {
//        [SVProgressHUD showErrorWithStatus:descript];
//        if (self.tableView.header.isRefreshing) {
//            [self.tableView.header endRefreshing];
//        }
//        if (self.tableView.footer.isRefreshing) {
//            [self.tableView.footer endRefreshing];
//        }
//    }];

}

- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CC"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CC"];
    }
    cell.textLabel.text = _titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *className = self.classNames[indexPath.row];
    if ([className isEqualToString:@"DKWebViewController"]) {
        DKWebViewController *ctrl = [[DKWebViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.cnblogs.com/lingyunhu/p/3855906.html"]];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    else if ([className isEqualToString:@"YYPhotoGroupView"]) {
        YYPhotoGroupItem *info = [YYPhotoGroupItem new];
        info.largeImageURL = [NSURL URLWithString:@"http://img1.imgtn.bdimg.com/it/u=2342588350,1264122285&fm=21&gp=0.jpg"];
        
        YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:@[info]];
        [v presentFromImageView:nil toContainer:self.navigationController.view animated:YES completion:nil];
    }

    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
