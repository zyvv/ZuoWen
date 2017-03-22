//
//  ZuoWenCell.m
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/22.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import "ZuoWenCell.h"

@implementation ZuoWenCell
{
    __weak IBOutlet UILabel *_titleLabel;
    __weak IBOutlet UILabel *_contentLabel;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setZuowen:(ZuoWen *)zuowen {
    if (_zuowen != zuowen) {
        _zuowen = zuowen;
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _contentLabel.text = _zuowen.content;
    _titleLabel.text = _zuowen.title;
    
}

@end
