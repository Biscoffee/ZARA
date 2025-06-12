//
//  SecondVC.m
//  ZARA
//
//  Created by 吴桐 on 2025/6/4.
//

#import "SecondVC.h"

@interface SecondVC () <UIScrollViewDelegate>

@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *searchIcon = [UIImage systemImageNamed:@"magnifyingglass"];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"发现"
                                                     image:searchIcon
                                             selectedImage:searchIcon];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width * 16.0 / 9.0;
    
    // 创建分段控制器
    self.segControl = [[UISegmentedControl alloc] initWithItems:@[@"男装", @"箱包", @"女装"]];
    self.segControl.frame = CGRectMake(20, 65, width - 40, 30);
    self.segControl.selectedSegmentIndex = 1;
    self.segControl.backgroundColor = [UIColor systemGray6Color];
    self.segControl.selectedSegmentTintColor = [UIColor systemBlueColor];
    [self.segControl setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.blackColor}
                                  forState:UIControlStateNormal];
    [self.segControl setTitleTextAttributes:@{NSForegroundColorAttributeName: UIColor.whiteColor}
                                  forState:UIControlStateSelected];
    [self.segControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segControl];
    
    // 创建页面控制器
    self.page = [[UIPageControl alloc] init];
    self.page.frame = CGRectMake(0, 100 + height - 30, width, 20);
    self.page.numberOfPages = 3;
    [self.view addSubview:self.page];
    
    // 创建滚动视图
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, width, height)];
    self.scrollView.pagingEnabled = YES;
    NSArray* photos = @[@"ph3.jpg", @"ph1.jpg", @"ph2.jpg", @"ph3.jpg", @"ph1.jpg"];
    self.scrollView.contentSize = CGSizeMake(width * photos.count, height);
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    for (int i = 0; i < photos.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:photos[i]]];
        imgView.frame = CGRectMake(width * i, 0, width, height);
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.tag = 200 + i;
        [self.scrollView addSubview:imgView];
    }
    
    // 初始位置设为第一张实际图片，跳过第0张假图
    self.scrollView.contentOffset = CGPointMake(width, 0);
    
    // 创建定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                 target:self
                                               selector:@selector(autoScroll)
                                               userInfo:nil
                                                repeats:YES];
}
//自动滚动逻辑
- (void)autoScroll {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + width, 0) animated:YES];
    //每次滚动一个图片宽度，有动画效果
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    [self.timer invalidate]; // 停止当前定时器
    self.timer = nil;
    
    CGFloat width = self.scrollView.bounds.size.width;
    NSInteger index = sender.selectedSegmentIndex;
    
    // 移动到目标位置（索引+1是因为第0页是假页面）
    [self.scrollView setContentOffset:CGPointMake(width * (index + 1), 0) animated:YES];
}
//动画滚动结束
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self updateSegControlFromScrollPosition]; // 更新分段控制器
    [self restartTimer]; // 重启定时器
}
//手动滑动结束
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateSegControlFromScrollPosition]; // 更新分段控制器
    [self restartTimer]; // 重启定时器
}
//拖动暂停定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 拖动时停止定时器
    [self.timer invalidate];
    self.timer = nil;
}

- (void)updateSegControlFromScrollPosition {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat offsetX = self.scrollView.contentOffset.x;
    
    // 计算实际页码（减1是因为第0页是假页面）
    NSInteger page = (NSInteger)round(offsetX / screenWidth) - 1;
    
    // 确保页码在有效范围内（0-2）
    page = MAX(0, MIN(page, 2));
    
    // 更新分段控制器
    self.segControl.selectedSegmentIndex = page;
    self.page.currentPage = page;
}
//边界循环处理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat totalWidth = scrollView.contentSize.width;

    // 处理循环边界
    if (offsetX >= totalWidth - screenWidth) {
        [scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
        self.page.currentPage = 0;
        self.segControl.selectedSegmentIndex = 0;
    } else if (offsetX <= 0) {
        [scrollView setContentOffset:CGPointMake(totalWidth - 2 * screenWidth, 0) animated:NO];
        self.page.currentPage = 2;
        self.segControl.selectedSegmentIndex = 2;
    } else {
        // 在滚动过程中更新页面控制器
        NSInteger page = (offsetX / screenWidth) - 1;
        self.page.currentPage = page;
    }
}

- (void)restartTimer {
    // 先停止现有定时器
    [self.timer invalidate];
    self.timer = nil;
    
    // 创建新的定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                 target:self
                                               selector:@selector(autoScroll)
                                               userInfo:nil
                                                repeats:YES];
}

@end
