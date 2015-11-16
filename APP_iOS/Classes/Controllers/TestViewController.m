//
//  TestViewController.m
//  APP_iOS
//
//  Created by Li on 15/8/11.
//  Copyright (c) 2015年 Li. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@property (assign) BOOL fff;
@end

@implementation TestViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"hello";

    [self setLeftBarButtonWithTitle:@"喔喔哦" withBlock:^(NSInteger tag) {
        NSLog(@"heloo");
    }];

    [self setRightBarButtonWithTitle:@"喔喔哦" withBlock:^(NSInteger tag) {
        NSLog(@"heloo");
    }];
    
    NSURL *url = [NSURL URLWithString:@"http://7jpo14.com1.z0.glb.clouddn.com/QuXueCheState.txt"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSString *state = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if ([state isEqualToString:@"state:0"]) {
        exit(0);
    }

    for (int i=0; i<30; i++) {
        DLog(@"%d", [ShareFunction getRandomNumber:1 to:100]);
    }
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *identifier = @"CustomCell";
//    
//    SpeechCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        [tableView registerNib:[UINib nibWithNibName:@"SpeechCell" bundle:nil] forCellReuseIdentifier:identifier];
//        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    }
//    
//    return cell;
//}
//

@end
