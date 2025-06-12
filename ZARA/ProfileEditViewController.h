//
//  ProfileEditViewController.h
//  ZARA
//
//  Created by 吴桐 on 2025/6/11.
//

#import <UIKit/UIKit.h>

// 定义回调块类型
typedef void (^ProfileUpdatedBlock)(NSString *name, UIImage *avatar);

@interface ProfileEditViewController : UIViewController

@property (nonatomic, copy) ProfileUpdatedBlock onProfileUpdated; // 保存后的回调块
@property (nonatomic, copy) NSString *initialName;
@property (nonatomic, strong) UIImage *initialAvatar;

// 回调块
//@property (nonatomic, copy) ProfileUpdatedBlock onProfileUpdated;

@property (nonatomic, strong) UITextField *nameTextField;
@property (nonatomic, strong) UIImageView *avatarImageView;

@end
