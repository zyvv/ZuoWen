//
//  LoginViewController.m
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/23.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import "LoginViewController.h"
#import <Toast/UIView+Toast.h>
#import "UserCenter.h"
#import "RegisterViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonAction:(UIButton *)sender {
    if (!_usernameTextField.text.length || !_passwordTextField.text.length) {
        [self.view makeToast:@"用户名或密码不能为空！"];
        return;
    }
    BOOL login = [[UserCenter shareUserCenter] loginWithUserName:_usernameTextField.text password:_passwordTextField.text];
    if (login) {
        __weak LoginViewController *weakSelf = self;
        [self.view makeToast:@"登录成功" duration:.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
    } else {
        [self.view makeToast:@"登录失败"];
    }
}
- (IBAction)registerButtonAction:(UIButton *)sender {
//    RegisterViewController *vc = [[RegisterViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)closeAction:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
