//
//  ZyBaseViewController.m
//  jkbs_train
//
//  Created by iosdev1 on 16/8/25.
//  Copyright © 2016年 iosdev1. All rights reserved.
//

#import "ZyBaseViewController.h"
#import "AppDelegate.h"

@interface ZyBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation ZyBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _TabBarHidden = true;
    [self initUIRectEdge:3];
    [self controllerInit];
    //    解决卡顿问题 点击push的按钮后，导航条会跳动，然后导航条下面的view就没有渐变效果，而是瞬间变换的。
    //    然后设置一个背景色以后，就有一个柔顺的过渡效果了
//    [self.view setBackgroundColor:COLOR_BACKGROUND];
    [self setNavigationControllerNavigationBar];
    
//    设置右划返回
    [self addRightMoveBack];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setTabBarHidden:_TabBarHidden];
}

- (void)addRightMoveBack{
    
    //1.获取系统interactivePopGestureRecognizer对象的target对象
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    
    //2.创建滑动手势，taregt设置interactivePopGestureRecognizer的target，所以当界面滑动的时候就会自动调用target的action方法。
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] init];
    [pan addTarget:target action:NSSelectorFromString(@"handleNavigationTransition:")];
    pan.delegate = self;
    
    //3.添加到导航控制器的视图上
    [self.navigationController.view addGestureRecognizer:pan];
    
    //4.禁用系统的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

#pragma mark - 滑动开始触发事件
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
//    //只有导航的根控制器不需要右滑的返回的功能。
//    if (self.navigationController.viewControllers.count <= 1) {
//        return NO;
//    }
    
    return YES;
}

- (void)controllerInit{
    self.TabBarHidden = false;
    [self initUIRectEdge:0];
}

- (void)initData:(NSString *)dataStr{
    
    
}

- (void)setNavigationControllerNavigationBar{
    //    设置导航栏
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];//消除导航栏的黑线（苹果默认加了一个图片）
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:false];
//    设置导航栏字体颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:FONT(16)}];
}


- (void)setTabBarHidden:(BOOL)TabBarHidden{
    _TabBarHidden = TabBarHidden;
    [self.tabBarController.tabBar setHidden:_TabBarHidden];

    if (_TabBarHidden == true) {
        UIImage *imageBack = [UIImage imageNamed:@"nav_back"];
        imageBack = [imageBack imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:imageBack style:UIBarButtonItemStylePlain target:self action:@selector(navBack:)];
        [self.navigationItem setLeftBarButtonItem:backBtn];
    }else{

    }
    
}

- (void)initUIRectEdge:(NSInteger)edg{
//    左右的目前是一致的没区别
    switch (edg) {
        case 0:
            //    edgesForExtendedLayout属性设置为UIRectEdgeNone，这样布局就是从导航栏下面开始了,tabbar上面结束
            self.edgesForExtendedLayout = UIRectEdgeNone;
            break;
        case 1:
//            布局就是从导航栏上面开始了,tabbar上面结束
            self.edgesForExtendedLayout = UIRectEdgeTop;
            break;
        case 2:
//            布局就是从导航栏下面开始了,tabbar上面结束
            self.edgesForExtendedLayout = UIRectEdgeLeft;
            break;
        case 3:
            //            布局就是从导航栏下面开始了,tabbar下面结束
            self.edgesForExtendedLayout = UIRectEdgeBottom;
            break;
        case 4:
            //            布局就是从导航栏下面开始了,tabbar上面结束
            self.edgesForExtendedLayout = UIRectEdgeRight;
            break;
        default:
                  //            布局就是从导航栏上面开始了,tabbar下面结束 全屏幕
            self.edgesForExtendedLayout = UIRectEdgeAll;
            break;
    }
}



- (void) showHUD:(NSString *)title AndContent:(NSString *)content{
//    [ZyUI showMessage:title];
}

- (void) hideHUD{
//   [ZyUI showMessage:@"加载结束"];
}

- (void) navBack:(BOOL) animated{
    [self backController:YES];
}

- (void)backController:(BOOL) animated{
    [self backController:1 animated:animated];
}

- (void) backController:(NSInteger) lever animated:(BOOL) animated{
    UINavigationController *navcontroller = _TabBarHidden ? self.navigationController : self.tabBarController.navigationController;
    NSMutableArray *viewcontroller = [NSMutableArray arrayWithArray:navcontroller.viewControllers];
    if (lever >= viewcontroller.count) {
        [navcontroller popToRootViewControllerAnimated:animated];
        return;
    }
    for (int i = 0; i < lever; i ++) {
        [viewcontroller removeLastObject];
    }
    [navcontroller setViewControllers:viewcontroller animated:animated];
}

- (void) backToRootViewControllerAnimated:(BOOL) animated{
    UINavigationController *navcontroller = self.TabBarHidden ? self.navigationController : self.tabBarController.navigationController;
    //    NSMutableArray *viewcontroller = [NSMutableArray arrayWithArray:navcontroller.viewControllers];
    [navcontroller popToRootViewControllerAnimated:animated];
    return;
}

- (void) pushController:(UIViewController *)controller{
    [self pushController:controller animated:YES];
}

- (void) pushController:(UIViewController *)controller animated:(BOOL) animated{
    [self pushController:controller toLever:0 animated:animated];
}

- (void) pushController:(UIViewController *)controller toLever:(NSInteger) lever animated:(BOOL) animated{
    UINavigationController *navcontroller = self.navigationController;
    NSMutableArray *viewcontroller = [NSMutableArray arrayWithArray:navcontroller.viewControllers];
    if (lever >= viewcontroller.count || lever == 0) {
        if (([viewcontroller.lastObject isKindOfClass:NSClassFromString(@"ChatViewController")] || [[viewcontroller.lastObject class] isSubclassOfClass:NSClassFromString(@"ZyChatViewController")]) && [viewcontroller.lastObject isKindOfClass:[controller class]]) {
            return;
        }
        [navcontroller pushViewController:controller animated:animated];
        return;
    }
    for (int i = 0; i < lever; i ++) {
        [viewcontroller removeLastObject];
    }
    
    [viewcontroller addObject:controller];
    [navcontroller setViewControllers:viewcontroller animated:animated];
}

- (void)dealloc{
    echo(@"内存释放");
}

@end
