//
//  UserCenter.m
//  ZuoWen
//
//  Created by 张洋威 on 2017/3/23.
//  Copyright © 2017年 张洋威. All rights reserved.
//

#import "UserCenter.h"
#import <YYKit/YYKit.h>
#import "Model.h"

@interface UserCenter ()
@property (nonatomic, copy, readwrite)NSString *name;
@property (nonatomic, strong) YYCache *loveCache;
@property (nonatomic, strong) YYCache *zuowenCache;

@end

@implementation UserCenter
+(instancetype)shareUserCenter {
    static UserCenter *shareUserCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareUserCenter = [[UserCenter alloc] init];
        shareUserCenter.loveCache = [YYCache cacheWithName:@"love"];
        shareUserCenter.zuowenCache = [YYCache cacheWithName:@"zuowen"];

        if (![shareUserCenter.zuowenCache containsObjectForKey:@"zuowen"]) {
            NSData *data = [NSData dataNamed:[NSString stringWithFormat:@"zuowen.json"]];
            [shareUserCenter.zuowenCache setObject:data forKey:@"zuowen"];
        }
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

- (NSSet *)loveList {
    if (![UserCenter shareUserCenter].name) {
        return nil;
    }
    
    id love = [[UserCenter shareUserCenter].loveCache objectForKey:[UserCenter shareUserCenter].name];
    return love;
    
}

- (void)deleteLoveZuoWen:(NSString *)zid {
    NSMutableSet *set = [NSMutableSet setWithSet:[[UserCenter shareUserCenter] loveList]];
    for (NSString *loveZid in [[UserCenter shareUserCenter] loveList]) {
        if ([loveZid isEqualToString:zid]) {
            [set removeObject:zid];
        }
    }
    [[UserCenter shareUserCenter].loveCache setObject:[set copy] forKey:[UserCenter shareUserCenter].name];
}

- (void)loveZuoWen:(NSString *)zid {
    if (![UserCenter shareUserCenter].name) {
        return;
    }
    NSSet *loveList = [self loveList];
    if (loveList) {
        NSMutableSet *set = [NSMutableSet setWithSet:loveList];
        [set addObject:zid];
        [[UserCenter shareUserCenter].loveCache setObject:[set copy] forKey:[UserCenter shareUserCenter].name];
    } else {
        NSSet *set = [NSSet setWithObject:zid];
        [[UserCenter shareUserCenter].loveCache setObject:set forKey:[UserCenter shareUserCenter].name];
    }
    
    
}

- (BOOL)isLoved:(NSString *)zid {
    if (![UserCenter shareUserCenter].name) {
        return NO;
    }
    id love = [[UserCenter shareUserCenter].loveCache objectForKey:[UserCenter shareUserCenter].name];
    NSLog(@"=== %@", love);
    if (love) {
        for (NSString *loveId in love) {
            if ([loveId isEqualToString:zid]) {
                return YES;
            }
        }
    }
    return NO;
}

- (NSArray *)getLoveList {
    NSData *data = (NSData *)[[UserCenter shareUserCenter].zuowenCache objectForKey:@"zuowen"];
    if (data) {
        NSArray *zuowenList = [NSArray modelArrayWithClass:[ZuoWen class] json: data];
        NSSet *loveIdList = [self loveList];
        NSMutableArray *loveList = [NSMutableArray arrayWithCapacity:0];
        for (ZuoWen *zuowen in zuowenList) {
            for (NSString *zid in loveIdList) {
                if ([zuowen.zid isEqualToString:zid]) {
                    [loveList addObject:zuowen];
                }
            }
        }
        return [loveList copy];
        
    }
    return nil;
}

- (NSArray *)getZuoWenList {
    NSData *data = (NSData *)[[UserCenter shareUserCenter].zuowenCache objectForKey:@"zuowen"];
    if (data) {
       return [NSArray modelArrayWithClass:[ZuoWen class] json: data];
    }
    return nil;
}

- (void)addZuowen:(ZuoWen *)zuowen {
    NSData *data = (NSData *)[[UserCenter shareUserCenter].zuowenCache objectForKey:@"zuowen"];
    NSMutableArray *zuowenList = [NSMutableArray arrayWithCapacity:0];
    if (data) {
        [zuowenList appendObjects:[NSArray modelArrayWithClass:[ZuoWen class] json: data]];
    }
    [zuowenList addObject:zuowen];
    [[UserCenter shareUserCenter].zuowenCache setObject:[zuowenList modelToJSONData] forKey:@"zuowen"];
}

@end
