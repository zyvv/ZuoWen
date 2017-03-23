//
//  ProfileViewController.m
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/22.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserCenter.h"
#import "LoginViewController.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([UserCenter shareUserCenter].name) {
        self.userNameLabel.text = [UserCenter shareUserCenter].name;
        self.loginButton.backgroundColor = [UIColor greenColor];
        [self.loginButton setTitle:@"退出登录" forState:UIControlStateNormal];
    } else {
        self.userNameLabel.text = @"作文帮";
        [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)saveButtonAction:(UIButton *)sender {
}


- (IBAction)loginButtonAction:(UIButton *)sender {
    if ([UserCenter shareUserCenter].name) {
        [[UserCenter shareUserCenter] loginOut];
    } else {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *nav = [main instantiateViewControllerWithIdentifier:@"LoginViewControllerNavi"];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
    }
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
