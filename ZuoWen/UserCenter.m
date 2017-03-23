//
//  UserCenter.m
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/23.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import "UserCenter.h"
#import <YYKit/YYKit.h>

@interface UserCenter ()
@property (nonatomic, copy, readwrite)NSString *name;

@end

@implementation UserCenter
+(instancetype)shareUserCenter {
    static UserCenter *shareUserCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareUserCenter = [[UserCenter alloc] init];
    });
    return shareUserCenter;
}

- (NSString *)name {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
}

- (void)loginOut {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
}

- (BOOL)loginWithUserName:(NSString *)userName password:(NSString *)password {
    if (!userName || !password) {
        return NO;
    }
    NSString *keypassword = [YYKeychain getPasswordForService:@"userAccount" account:userName];
    if (keypassword && keypassword == password) {
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
        return YES;
    }
    return NO;
}

- (BOOL)registerWithUserName:(NSString *)userName password:(NSString *)password {
    if (!userName || !password) {
        return NO;
    }
    NSString *keypassword = [YYKeychain getPasswordForService:@"userAccount" account:userName];
    if (keypassword) {
        return NO;
    } else {
        return [YYKeychain setPassword:password forService:@"userAccount" account:userName];
    
    }
    return NO;
}

@end
