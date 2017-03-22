//
//  Model.h
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/22.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@end

@interface ZuoWen : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger zid;

@end
