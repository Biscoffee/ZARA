//
//  FirstVC.m
//  ZARA
//
//  Created by 吴桐 on 2025/6/4.
//

#import "FirstVC.h"

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 设置 tab 图标
    UIImage *homeIcon = [UIImage systemImageNamed:@"house"];
    UIImage *homeIconSelected = [UIImage systemImageNamed:@"house.fill"];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
                                                     image:homeIcon
                                             selectedImage:homeIconSelected];
    
    // 屏幕尺寸
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat bannerHeight = screenWidth * 16.0 / 9.0;
    
    UIScrollView *verticalScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, bannerHeight* 7)];
       verticalScrollView.alwaysBounceVertical = YES;
       verticalScrollView.showsVerticalScrollIndicator = YES;
       verticalScrollView.backgroundColor = [UIColor systemBackgroundColor];
       verticalScrollView.contentSize = CGSizeMake(screenWidth, self.view.bounds.size.height * 7);
    [self.view addSubview:verticalScrollView];
    
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.frame = CGRectMake(50, 50, 100, 50);
    UIImage *logo = [UIImage imageNamed:@"zara.png"];
    logoView.image = logo;
    [self.view addSubview:logoView];
    
    // 创建滚动视图
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, bannerHeight)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;

    NSArray *images = @[@"5.jpg", @"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", @"1.jpg"];
    
    for (int i = 0; i < images.count; i++) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:images[i]]];
        imgView.frame = CGRectMake(screenWidth * i, 0, screenWidth, bannerHeight);
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.userInteractionEnabled = YES;
        imgView.tag = 100 + i;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bannerTapped:)];
        [imgView addGestureRecognizer:tap];
        [self.scrollView addSubview:imgView];
    }

    self.scrollView.contentSize = CGSizeMake(screenWidth * images.count, bannerHeight);
    self.scrollView.contentOffset = CGPointMake(screenWidth, 0); // 起始页
    [verticalScrollView addSubview:self.scrollView];

    // 添加 pageControl
    self.page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, bannerHeight - 30, screenWidth, 30)];
    self.page.numberOfPages = 5;
    self.page.currentPage = 0;
    [verticalScrollView addSubview:self.page];
    [self.page addTarget:self action:@selector(pageChanged:) forControlEvents:UIControlEventValueChanged];
    // 启动定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];

    // 左按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftBtn setTitle:@"〈" forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(10, bannerHeight / 2 - 20, 40, 40);
    leftBtn.tag = 111;
    [leftBtn addTarget:self action:@selector(scrollChange:) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftBtn.layer.cornerRadius = 20;
    [verticalScrollView addSubview:leftBtn];

    // 右按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rightBtn setTitle:@"〉" forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(screenWidth - 50, bannerHeight / 2 - 20, 40, 40);
    rightBtn.tag = 222;
    [rightBtn addTarget:self action:@selector(scrollChange:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.layer.cornerRadius = 20;
    [verticalScrollView addSubview:rightBtn];
    
    
    
    CGFloat smallBannerHeight = bannerHeight * 0.5;
//    CGFloat smallBannerY = bannerHeight;
    CGFloat smallBannerY = CGRectGetMaxY(self.scrollView.frame);

    // 更新 verticalScrollView 的 contentSize，确保两个滚动视图连贯显示
//    verticalScrollView.contentSize = CGSizeMake(screenWidth, CGRectGetMaxY(self.smallScrollView.frame) + 100);
    
    
    self.smallScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, smallBannerY, screenWidth, smallBannerHeight)];
    _smallScrollView.pagingEnabled = YES;
    _smallScrollView.showsHorizontalScrollIndicator = NO;
    _smallScrollView.delegate = self;

    NSArray* smallImages = @[@"文件4.jpeg",@"文件1.jpeg", @"文件2.jpeg", @"文件3.jpeg", @"文件4.jpeg", @"文件1.jpeg"];
    for (int i = 0; i < smallImages.count; i++) {
        UIImageView* imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:smallImages[i]]];
        imgView.frame = CGRectMake(screenWidth * i, 0, screenWidth, smallBannerHeight);
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        imgView.userInteractionEnabled = YES;
        [_smallScrollView addSubview:imgView];
    }

    _smallScrollView.contentSize = CGSizeMake(screenWidth * smallImages.count, smallBannerHeight);
    self.scrollView.contentOffset = CGPointMake(screenWidth, 0);
    [verticalScrollView addSubview:_smallScrollView];

    
    self.smallPage = [[UIPageControl alloc] initWithFrame:CGRectMake(0, smallBannerY + smallBannerHeight - 20, screenWidth, 20)];
    self.smallPage.numberOfPages = smallImages.count - 2;
    self.smallPage.currentPage = 0;
    [verticalScrollView addSubview: self.smallPage];
    [self.smallPage addTarget:self action:@selector(smallPageChanged:) forControlEvents:UIControlEventValueChanged];
    self.smallTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScrollSmall) userInfo:nil repeats:YES];

}

- (void)autoScrollSmall {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat currentOffset = self.smallScrollView.contentOffset.x;
    NSInteger nextPage = (NSInteger)(currentOffset / width) + 1;

    // 边界检查
       if (nextPage >= self.smallPage.numberOfPages + 1) { // +1 因为第一张是假图
           // 如果滚动到假尾页，跳转到第二张真实图片
           [self.smallScrollView setContentOffset:CGPointMake(width, 0) animated:NO];
           nextPage = 1; // 重置为第二张真实图片
       } else {
           // 正常滚到下一页
           [self.smallScrollView setContentOffset:CGPointMake(nextPage * width, 0) animated:YES];
       }
       
       // 更新分页指示器 (索引减去1，因为第一张是假图)
       self.smallPage.currentPage = nextPage - 1;
}

- (void)smallPageChanged:(UIPageControl *)sender {
    [self.timer invalidate];
    self.timer = nil;
    NSInteger page = sender.currentPage;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 位置偏移 +1 因为第一张是假图
    [self.smallScrollView setContentOffset:CGPointMake((page + 1) * width, 0) animated:YES];
    self.smallPage.currentPage = page;
    
    self.smallTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScrollSmall) userInfo:nil repeats:YES];
}


- (void)scrollChange:(UIButton *)btn {
    //停止自动轮播
    [self.timer invalidate];
    self.timer = nil;

    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    NSInteger currentPage = self.page.currentPage;

    if (btn.tag == 111) {
        if (currentPage == 0) {
            [self.scrollView setContentOffset:CGPointMake(width * 5, 0) animated:YES];
            self.page.currentPage = 4;
        } else {
            currentPage--;
            [self.scrollView setContentOffset:CGPointMake((currentPage + 1) * width, 0) animated:YES];
            self.page.currentPage = currentPage;
        }
    } else if (btn.tag == 222) {
        if (currentPage == 4) {
            [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
            self.page.currentPage = 0;
        } else {
            currentPage++;
            [self.scrollView setContentOffset:CGPointMake((currentPage + 1) * width, 0) animated:YES];
            self.page.currentPage = currentPage;
        }
    }

    self.timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
}

- (void)autoScroll {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + width, 0) animated:YES];
}

//保证首尾无限连接
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat totalWidth = scrollView.contentSize.width;

    if (scrollView == self.scrollView) {
        if (offsetX >= totalWidth - screenWidth) {
            [scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
            self.page.currentPage = 0;
        } else if (offsetX <= 0) {
            [scrollView setContentOffset:CGPointMake(totalWidth - 2 * screenWidth, 0) animated:NO];
            self.page.currentPage = 4;
        } else {
            self.page.currentPage = (offsetX / screenWidth) - 1;
        }
    } else if (scrollView == self.smallScrollView) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
                CGFloat offsetX = scrollView.contentOffset.x;
                CGFloat totalWidth = scrollView.contentSize.width;
                CGFloat contentWidth = screenWidth * (self.smallPage.numberOfPages + 1); // 实际内容宽度
                
                if (offsetX >= contentWidth - screenWidth) {
                    // 滚动到假尾页时，跳转到第二张真实图片
                    [scrollView setContentOffset:CGPointMake(screenWidth, 0) animated:NO];
                    self.smallPage.currentPage = 0;
                } else if (offsetX <= 0) {
                    // 滚动到假首页时，跳转到倒数第二张真实图片
                    [scrollView setContentOffset:CGPointMake(contentWidth - 2 * screenWidth, 0) animated:NO];
                    self.smallPage.currentPage = self.smallPage.numberOfPages - 1;
                } else {
                    // 使用四舍五入计算当前页（更精确）
                    NSInteger currentPage = (NSInteger)roundf(offsetX / screenWidth) - 1;
                    if (currentPage != self.smallPage.currentPage) {
                        self.smallPage.currentPage = currentPage;
                    }
                }
    }
}

- (void)bannerTapped:(UITapGestureRecognizer *)gesture {
    UIImageView *imgView = (UIImageView *)gesture.view;
    UIImage *image = imgView.image;
    if (!image) return;
    
    // 创建全屏黑色背景视图，覆盖整个屏幕
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc] initWithFrame:keyWindow.bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = 0;
    
    // 创建全屏图片视图，显示图片，保持宽高比
    UIImageView *fullImageView = [[UIImageView alloc] initWithFrame:backgroundView.bounds];
    fullImageView.contentMode = UIViewContentModeScaleAspectFit;
    fullImageView.image = image;
    fullImageView.userInteractionEnabled = YES;
    
    // 添加点击手势，点击关闭全屏图
    UITapGestureRecognizer *tapClose = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissFullScreenImage:)];
    [fullImageView addGestureRecognizer:tapClose];
    
    [backgroundView addSubview:fullImageView];
    [keyWindow addSubview:backgroundView];
    
    // 动画显示背景视图
    [UIView animateWithDuration:0.3 animations:^{
        backgroundView.alpha = 1.0;
    }];
}

- (void)pageChanged:(UIPageControl *)sender {
    NSInteger page = sender.currentPage;
    NSLog(@"%ld", page);
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    [self.scrollView setContentOffset:CGPointMake((page + 1) * width, 0) animated:YES];
}



// 点击大图后调用此方法关闭全屏查看
- (void)dismissFullScreenImage:(UITapGestureRecognizer *)tap {
    UIView *backgroundView = tap.view.superview;
    [UIView animateWithDuration:0.3 animations:^{
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
@end


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
