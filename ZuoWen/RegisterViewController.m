//
//  RegisterViewController.m
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/23.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import "RegisterViewController.h"
#import <Toast/UIView+Toast.h>
#import "UserCenter.h"

@interface RegisterViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    _confirmPasswordTextField.delegate = self;
    _userNameTextField.delegate = self;
    _passwordTextField.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)registerButtonAction:(UIButton *)sender {
    if (!_passwordTextField.text.length || !_userNameTextField.text.length || !_confirmPasswordTextField.text.length) {
        [self.view makeToast:@"用户名或密码不能为空！" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    if (![_confirmPasswordTextField.text isEqualToString:_passwordTextField.text]) {
        [self.view makeToast:@"两次输入的密码不一致！" duration:0.5 position:CSToastPositionCenter];
        return;
    }
    BOOL registerSuccess = [[UserCenter shareUserCenter] registerWithUserName:_userNameTextField.text password:_passwordTextField.text];
    if (registerSuccess) {
        __weak RegisterViewController *weakSelf = self;
        [self.view makeToast:@"注册成功" duration:0.5 position:CSToastPositionCenter title:nil image:nil style:nil completion:^(BOOL didTap) {
            [[UserCenter shareUserCenter] loginWithUserName:_userNameTextField.text password:_passwordTextField.text];
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
    } else {
        [self.view makeToast:@"注册失败" duration:0.5 position:CSToastPositionCenter];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
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
