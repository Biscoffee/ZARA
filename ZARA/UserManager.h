//
//  UserManager.h
//  ZARA
//
//  Created by 吴桐 on 2025/6/11.
//

// UserManager.h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserManager : NSObject

@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) UIImage *avatar;

/// 获取全局唯一实例
+ (instancetype)sharedManager;

/// 从本地加载数据
- (void)loadFromStorage;

/// 保存数据到本地
- (void)saveToStorage;

@end
