//
//  ProfileEditViewController.m
//  ZARA
//
//  Created by 吴桐 on 2025/6/11.
//

#import "ProfileEditViewController.h"
#import <Photos/Photos.h> // 用于相册权限检查
#import "UserManager.h"
@interface ProfileEditViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
//@property (nonatomic, strong) UITextField *nameTextField;
//@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIImage *selectedAvatar; // 保存用户选择的头像
@end

@implementation ProfileEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"编辑资料";
    
    // 头像 ImageView
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100)/2, 120, 100, 100)];
    self.avatarImageView.image = self.initialAvatar ?: [UIImage imageNamed:@"defaultAvatar"];
    self.avatarImageView.userInteractionEnabled = YES;
    self.avatarImageView.layer.cornerRadius = 50;
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    // 添加头像点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAvatar)];
    [self.avatarImageView addGestureRecognizer:tapGesture];
    
    [self.view addSubview:self.avatarImageView];

    // 昵称输入框
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(40, 250, self.view.frame.size.width - 80, 40)];
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTextField.placeholder = @"请输入昵称";
    self.nameTextField.text = self.initialName; // 设置初始昵称
    self.nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:self.nameTextField];
    
    // 设置昵称文本框自动获取焦点
    [self.nameTextField becomeFirstResponder];

    // 保存按钮
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    saveButton.frame = CGRectMake((self.view.frame.size.width - 100)/2, 320, 100, 40);
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.backgroundColor = [UIColor systemBlueColor];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.layer.cornerRadius = 8;
    [saveButton addTarget:self action:@selector(saveProfile) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveButton];
}

#pragma mark - 头像选择

- (void)selectAvatar {
    // 检查相册权限
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusRestricted) {
        [self showPhotoPermissionAlert];
        return;
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = YES; // 允许裁剪
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)showPhotoPermissionAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"无法访问相册"
                                                                   message:@"请在设置中允许访问您的照片"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]
                                           options:@{}
                                 completionHandler:nil];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    // 获取编辑后的图片
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    if (editedImage) {
        // 更新头像显示
        self.avatarImageView.image = editedImage;
        self.selectedAvatar = editedImage;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveProfile {
    NSString *newName = [self.nameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // 检查昵称是否为空
    if (newName.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"昵称不能为空"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    // 限制昵称长度
    if (newName.length > 20) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"昵称不能超过20个字符"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    // 准备要返回的头像
    UIImage *newAvatar = self.selectedAvatar ?: self.initialAvatar;

    // 执行回调块，返回更新后的数据
    if (self.onProfileUpdated) {
        self.onProfileUpdated(newName, newAvatar);
    }

    // 返回上一个页面
    [self.navigationController popViewControllerAnimated:YES];
}

@end
