//
//  SecondVC.h
//  ZARA
//
//  Created by 吴桐 on 2025/6/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondVC : UIViewController<UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIPageControl *page;


@end

NS_ASSUME_NONNULL_END
