//
//  ZuoWenViewController.m
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/22.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import "ZuoWenViewController.h"
#import "UIImage+Text.h"
#import "UserCenter.h"
#import <YYKit/YYKit.h>

@interface ZuoWenViewController ()
@property (weak, nonatomic) IBOutlet UITextView *zuowenTextView;
@property (strong, nonatomic) UIButton *saveButton;
@property (nonatomic, strong) UIBarButtonItem *navItem;

@end

@implementation ZuoWenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kScreenHeight - 44 - 64, kScreenWidth, 44)];
    tool.backgroundColor = [UIColor whiteColor];
    tool.translucent = NO;
    [self.view addSubview:tool];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    self.saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.saveButton.frame = CGRectMake(0, 0, 44, 44);
    [self.saveButton setImage:[UIImage imageNamed:@"unStar"] forState:UIControlStateNormal];
    [self.saveButton setImage:[UIImage imageNamed:@"Star"] forState:UIControlStateSelected];
    [self.saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithCustomView:self.saveButton];
    
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareAction:)];
    [tool setItems:@[item, saveItem, item, shareItem]];
    
    self.navItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteItemAction:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setZuowen:(ZuoWen *)zuowen {
    if (_zuowen != zuowen) {
        _zuowen = zuowen;
    }
    self.title = _zuowen.title;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _zuowenTextView.text = _zuowen.content;
    if ([[UserCenter shareUserCenter] isLoved:_zuowen.zid]) {
        self.saveButton.selected = YES;
    } else {
        self.saveButton.selected = NO;
    }
    if ([UserCenter shareUserCenter].name && _zuowen.author && [[UserCenter shareUserCenter].name isEqualToString:_zuowen.author]) {
        self.navigationItem.rightBarButtonItem = self.navItem;
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
}

- (void)deleteItemAction:(UIBarButtonItem *)item {
    [[UserCenter shareUserCenter] deleteZuoWen:_zuowen.zid];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveAction:(UIButton *)sender {
    if (![UserCenter shareUserCenter].name) {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *nav = [main instantiateViewControllerWithIdentifier:@"LoginViewControllerNavi"];
        [self.navigationController presentViewController:nav animated:YES completion:nil];
        return;
    }
    if (![[UserCenter shareUserCenter] isLoved:_zuowen.zid]) {
        [[UserCenter shareUserCenter] loveZuoWen:_zuowen.zid];
        self.saveButton.selected = YES;
    } else {
        [[UserCenter shareUserCenter] deleteLoveZuoWen:_zuowen.zid];
        self.saveButton.selected = NO;
    }
    
}

- (void)shareAction:(UIBarButtonItem *)sender {
    UIImage *image = [UIImage new];
    image = [image imageFromText:@[self.zuowen.title, self.zuowen.content] withFont:12];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[image] applicationActivities:nil];
    [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
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
