//
//  ZuoWenViewController.m
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/22.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import "ZuoWenViewController.h"

@interface ZuoWenViewController ()
@property (weak, nonatomic) IBOutlet UITextView *zuowenTextView;

@end

@implementation ZuoWenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
}
- (IBAction)saveAction:(UIBarButtonItem *)sender {
}
- (IBAction)shareAction:(UIBarButtonItem *)sender {
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
