//
//  ZyTabBarController.m
//  zylOC
//
//  Created by UNOHACHA on 2018/4/13.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyTabBarController.h"
#import "ZyBaseViewController.h"
#import "DefaultViewController.h"

@interface ZyTabBarController ()<UITabBarControllerDelegate>

@end

@implementation ZyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    NSArray *arrCtrsAll = @[
                                 @{@"title" : @"首页", @"controller":@"HomePageViewController", @"ico_selected":@"tabbar_buy_s",   @"ico_unSelected":@"tabbar_buy_n"},
                                 @{@"title" : @"分类", @"controller":@"ClassifyViewController", @"ico_selected":@"tabbar_class_s", @"ico_unSelected":@"tabbar_class_n"},
                                 @{@"title" : @"我的", @"controller":@"MineViewController",     @"ico_selected":@"tabbar_my_s",    @"ico_unSelected":@"tabbar_my_n"}
                                 ];
    
    NSMutableArray *arrCtrs = [NSMutableArray array];
    for (NSDictionary *dicControler in arrCtrsAll) {
        UIImage *imageSelected = [UIImage imageNamed:dicControler[@"ico_selected"]];
        imageSelected = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UIImage *imageUnSelected = [UIImage imageNamed:dicControler[@"ico_unSelected"]];
        imageUnSelected = [imageUnSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        Class c = NSClassFromString([NSString stringWithFormat:@"%@", [dicControler valueForKey:@"controller"]]);
        ZyBaseViewController *basecontroller = [c new];
        [basecontroller setTitle:[dicControler valueForKey:@"title"]];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:basecontroller];
        navController.tabBarItem = [[UITabBarItem alloc] initWithTitle:[dicControler valueForKey:@"title"] image:imageUnSelected selectedImage:imageSelected];
        
        //未选中字体颜色
        [navController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:FONT(14)} forState:UIControlStateNormal];
        
        //选中字体颜色
        [navController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:FONT(14)} forState:UIControlStateSelected];
        [arrCtrs addObject:navController];
    }
    [self setViewControllers:arrCtrs];
    
    [self setSelectedIndex:1];
    echo(@"%@", self.selectedViewController);
    id ctr = self.selectedViewController;
    NSArray *arrCtr = self.viewControllers;
    echo(@"%@", arrCtr);
    
//    [self setSelectedViewController:[[DefaultViewController alloc] init]];
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0) {
    echo(@"触发的tabbar方法===%s", __FUNCTION__);
//    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
//    NSString *tokenStr = [userdefault objectForKey:UD_access_token];

//    UIViewController *selController = viewController.childViewControllers.firstObject;
//    if ([selController isKindOfClass:[UIViewController class]]||[selController isKindOfClass:[UIViewController class]]||[selController isKindOfClass:[UIViewController class]]) {
//        if (tokenStr) {
//            return true;
//        } else {
//            NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
//            NSString *tokenStr = [userdefault objectForKey:UD_access_token];
//
//            UIViewController *selController = viewController.childViewControllers.firstObject;
//            if ([selController isKindOfClass:[UIViewController class]]||[selController isKindOfClass:[UIViewController class]]||[selController isKindOfClass:[UIViewController class]]) {
//                if (tokenStr) {
//                    return true;
//                } else {
////                    跳转到登录
////                    [self signInApp];
//                    return false;
//                }
//            }
//            return false;
//        }
//    }
    return true;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    echo(@"触发的tabbar方法===%s", __FUNCTION__);
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED {
    echo(@"触发的tabbar方法===%s", __FUNCTION__);
}

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED {
    echo(@"触发的tabbar方法===%s", __FUNCTION__);
}

- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed __TVOS_PROHIBITED {
    echo(@"触发的tabbar方法===%s", __FUNCTION__);
}

- (UIInterfaceOrientationMask)tabBarControllerSupportedInterfaceOrientations:(UITabBarController *)tabBarController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
    echo(@"触发的tabbar方法===%s", __FUNCTION__);
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(UITabBarController *)tabBarController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
    echo(@"触发的tabbar方法===%s", __FUNCTION__);
    return UIInterfaceOrientationLandscapeRight;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController NS_AVAILABLE_IOS(7_0) {
    echo(@"触发的tabbar方法===%s", __FUNCTION__);
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
                     animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                                       toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0) {
    echo(@"触发的tabbar方法===%s", __FUNCTION__);
    return nil;
}

@end
