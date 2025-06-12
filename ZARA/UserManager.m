//
//  UserManager.m
//  ZARA
//
//  Created by 吴桐 on 2025/6/11.
//


#import "UserManager.h"

@implementation UserManager

+ (instancetype)sharedManager {
    static UserManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UserManager alloc] init];
        [instance loadFromStorage]; // 启动时自动加载数据
    });
    return instance;
}

- (void)loadFromStorage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 加载昵称
    NSString *savedName = [defaults stringForKey:@"user_nickname"];
    if (savedName) {
        self.nickname = savedName;
    } else {
        // 设置默认昵称
        self.nickname = @"TommyWu";
    }
    
    // 加载头像
    NSData *avatarData = [defaults objectForKey:@"user_avatar"];
    if (avatarData) {
        self.avatar = [UIImage imageWithData:avatarData];
    } else {
        // 设置默认头像
        self.avatar = [UIImage imageNamed:@"image1.jpg"];
    }
}

- (void)saveToStorage {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // 保存昵称
    if (self.nickname) {
        [defaults setObject:self.nickname forKey:@"user_nickname"];
    }
    
    // 保存头像
    if (self.avatar) {
        // 转换为PNG格式保存
        NSData *imageData = UIImagePNGRepresentation(self.avatar);
        [defaults setObject:imageData forKey:@"user_avatar"];
    }
    
    [defaults synchronize];
}

@end
