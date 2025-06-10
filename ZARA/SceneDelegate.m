//
//  SceneDelegate.m
//  ZARA
//
//  Created by 吴桐 on 2025/6/4.
//

#import "SceneDelegate.h"
#import "FirstVC.h"
#import "SecondVC.h"
#import "ThirdVC.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    FirstVC* vc1 = [[FirstVC alloc] init];
    vc1.title = @"首页";
    SecondVC* vc2 = [[SecondVC alloc] init];
    //vc2.title = @"发现";
    ThirdVC* vc3 = [[ThirdVC alloc] init];
    vc3.title = @"我的";
    
//    vc1.view.backgroundColor = [UIColor whiteColor];
//    vc2.view.backgroundColor = [UIColor whiteColor];
//    vc3.view.backgroundColor = [UIColor whiteColor];
    vc1.view.backgroundColor = [UIColor whiteColor];
    vc2.view.backgroundColor = [UIColor whiteColor];
    vc3.view.backgroundColor = [UIColor whiteColor];

    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    NSArray *arrVC = @[nav1,vc2, nav3];
    
    
    UITabBarController* tbc = [[UITabBarController alloc] init];
    tbc.viewControllers = arrVC;
    self.window.rootViewController = tbc;
    
   // self.window.backgroundColor = [UIColor systemFillColor];
    tbc.selectedIndex = 2;
    tbc.tabBar.tintColor = [UIColor grayColor];
    tbc.tabBar.translucent = NO;
    tbc.tabBar.backgroundColor = [UIColor whiteColor];
    tbc.tabBar.tintColor = [UIColor blackColor];
    tbc.tabBar.alpha = 0.8;
    
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
