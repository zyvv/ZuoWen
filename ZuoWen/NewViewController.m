//
//  NewViewController.m
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/22.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import "NewViewController.h"
#import "Model.h"
#import <YYKit/YYKit.h>
#import "UserCenter.h"

@interface NewViewController ()
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeSelf:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)publicAction:(id)sender {
    if (!_contentTextView.text.length) {
        return;
    }
    if (!_titleTextField.text.length) {
        return;
    }
    ZuoWen *zuowen = [ZuoWen new];
    zuowen.zid = [NSString stringWithUUID];
    zuowen.content = _contentTextView.text;
    zuowen.title = _titleTextField.text;
    [[UserCenter shareUserCenter] addZuowen:zuowen];
    [self closeSelf:nil];
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
