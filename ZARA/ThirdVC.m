//
//  ThirdVC.m
//  ZARA
//
//  Created by 吴桐 on 2025/6/4.
//

#import "ThirdVC.h"
#import "ProfileViewController.h"
@interface ThirdVC ()
@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *icon = [UIImage systemImageNamed:@"person"];
    UIImage *iconSelected = [UIImage systemImageNamed:@"person.fill"];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的" image:icon selectedImage:iconSelected];

    self.menuTitles = @[@"我的心愿单", @"我的地址簿", @"法律条款", @"个人信息"];
    self.menuIcons = @[@"heart", @"map", @"shield", @"person"];

    self.view.backgroundColor = [UIColor systemGroupedBackgroundColor];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    // 创建顶部header视图
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 220)];

    UIImageView *bg = [[UIImageView alloc] initWithFrame:header.bounds];
    bg.image = [UIImage imageNamed:@"miumiu.jpg"];
    bg.contentMode = UIViewContentModeScaleAspectFill;
    bg.clipsToBounds = YES;
    [header addSubview:bg];

    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 200, 30)];
    title.text = @"欢迎";
    title.font = [UIFont boldSystemFontOfSize:24];
    title.textColor = [UIColor whiteColor];
    [header addSubview:title];

    UILabel *desc = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 250, 20)];
    desc.text = @"尊敬的Miu Miu顾客，您好";
    desc.textColor = [UIColor whiteColor];
    desc.font = [UIFont systemFontOfSize:14];
    [header addSubview:desc];

    self.tableView.tableHeaderView = header;
    NSLog(@"navigationController: %@", self.navigationController);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menuCell"];
    }
    cell.textLabel.text = self.menuTitles[indexPath.row];
    cell.imageView.image = [UIImage systemImageNamed:self.menuIcons[indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 3) {
        ProfileViewController* profileVC = [[ProfileViewController alloc] init];
        [self.navigationController pushViewController:profileVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}



@end
