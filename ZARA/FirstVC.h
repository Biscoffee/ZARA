//
//  FirstVC.h
//  ZARA
//
//  Created by 吴桐 on 2025/6/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FirstVC : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *page;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIScrollView *smallScrollView;
@property (nonatomic, strong) UIPageControl *smallPage;
@property (nonatomic, strong) NSTimer *smallTimer;


- (void)autoScrollSmall;
@end

NS_ASSUME_NONNULL_END
