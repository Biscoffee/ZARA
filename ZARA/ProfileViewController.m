//
//  ProfileViewController.m
//  ZARA
//
//  Created by 吴桐 on 2025/6/8.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()
@property (nonatomic, strong) NSArray *profileTitles;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.profileTitles = @[@"头像", @"昵称", @"微信号"];
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"profileCell"];
    self.tableView.rowHeight = 60;
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
    
    // 配置不同行的显示内容
    NSString *title = self.profileTitles[indexPath.row];
    cell.textLabel.text = title;
    
    switch (indexPath.row) {
        case 0: // 头像
        {
            // 添加头像图片
            UIImageView *avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            avatarImageView.image = [UIImage imageNamed:@"image1.jpg"]; // 默认图片
            avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
            avatarImageView.layer.cornerRadius = 4.0; // 圆角
            avatarImageView.layer.masksToBounds = YES;
            
            // 设置accessoryView（右侧显示）
            cell.accessoryView = avatarImageView;
            break;
        }
        case 1: // 昵称
            cell.detailTextLabel.text = @"TommyWu"; // 示例昵称
            break;
        case 2: // 微信号
            cell.detailTextLabel.text = @"110110110"; // 示例微信号
            break;
    }
    
    return cell;
}


@end
