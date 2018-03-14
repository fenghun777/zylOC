//
//  HomePageViewController.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageView.h"

@interface HomePageViewController ()
@property (nonatomic, strong) HomePageView *mainView;
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
}

- (void)controllerInit{
    [super controllerInit];
    
    [self.view addSubview:self.mainView];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (HomePageView *)mainView{
    if (_mainView == nil){
        _mainView = [[HomePageView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewLayout alloc]init]];
    }
    return _mainView;
}

@end
