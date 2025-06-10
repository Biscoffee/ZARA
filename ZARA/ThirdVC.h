//
//  ThirdVC.h
//  ZARA
//
//  Created by 吴桐 on 2025/6/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThirdVC : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *menuIcons;

@end


NS_ASSUME_NONNULL_END
