//
//  UserCenter.h
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/23.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCenter : NSObject
+(instancetype)shareUserCenter;

@property (nonatomic, copy, readonly)NSString *name;

- (void)loginOut;

- (BOOL)loginWithUserName:(NSString *)userName password:(NSString *)password;

- (BOOL)registerWithUserName:(NSString *)userName password:(NSString *)password;

@end
