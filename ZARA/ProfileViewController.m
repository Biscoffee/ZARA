//
//  ProfileViewController.m
//  ZARA
//
//  Created by 吴桐 on 2025/6/8.
//


// ProfileViewController.m
#import "ProfileViewController.h"
#import "ProfileEditViewController.h"
#import "UserManager.h"

@interface ProfileViewController ()
@property (nonatomic, strong) NSArray *profileTitles;
@property (nonatomic, weak) UserManager *userManager; // 弱引用UserManager
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profileTitles = @[@"头像", @"昵称", @"微信号"];
    self.tableView.rowHeight = 60;
    
    // 使用UserManager作为统一数据源
    self.userManager = [UserManager sharedManager];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData]; // 返回时刷新数据
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.profileTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"profileCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"profileCell"];
    }
    
    NSString *title = self.profileTitles[indexPath.row];
    cell.textLabel.text = title;
    
    // 重置accessoryView和detailTextLabel
    cell.accessoryView = nil;
    cell.detailTextLabel.text = nil;
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    switch (indexPath.row) {
        case 0: // 头像
        {
            UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            avatarImageView.image = self.userManager.avatar;
            avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
            avatarImageView.layer.cornerRadius = 4.0;
            avatarImageView.clipsToBounds = YES;
            
            cell.accessoryView = avatarImageView;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case 1: // 昵称
            // 使用UserManager中的昵称
            cell.detailTextLabel.text = self.userManager.nickname;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 2: // 微信号
            cell.detailTextLabel.text = @"110110110";
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        [self openProfileEditor];
    }
}

#pragma mark - 打开编辑页面

- (void)openProfileEditor {
    ProfileEditViewController *editVC = [[ProfileEditViewController alloc] init];
    
    // 传递当前数据
    editVC.initialName = self.userManager.nickname;
    editVC.initialAvatar = self.userManager.avatar;
    
    // 设置回调块
    __weak typeof(self) weakSelf = self;
    editVC.onProfileUpdated = ^(NSString *name, UIImage *avatar) {
        // 更新UserManager中的数据
        UserManager *manager = [UserManager sharedManager];
        manager.nickname = name;
        manager.avatar = avatar;
        [manager saveToStorage]; // 立即保存
        
        // 刷新表格
        [weakSelf.tableView reloadData];
    };
    
    [self.navigationController pushViewController:editVC animated:YES];
}

@end
