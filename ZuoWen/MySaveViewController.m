//
//  MySaveViewController.m
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/25.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import "MySaveViewController.h"
#import "UserCenter.h"
#import "ZuoWenCell.h"
#import "ZuoWenViewController.h"

@interface MySaveViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation MySaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ZuoWenCell" bundle:nil] forCellReuseIdentifier:@"ZuoWenCell"];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataArray = [[UserCenter shareUserCenter] getLoveList];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZuoWenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZuoWenCell"];
    cell.zuowen = _dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZuoWenViewController *vc = [main instantiateViewControllerWithIdentifier:@"ZuoWenViewController"];
    vc.zuowen = _dataArray[indexPath.row];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
