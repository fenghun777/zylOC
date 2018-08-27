//
//  HomePageViewController.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageView.h"
#import "ZyUI.h"


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
    CGSize labelsize = [ZyUtils zy_GetContentSize:@"测试以下犯上；领导家；两地分居；拉萨点击发送；了贷款纠纷；拉涉及到法律；按时就到拉萨；大姐夫；阿里山的积分；拉涉及到法律；氨基酸的；了房间爱上了；的房间爱上了； 接单方；拉世纪东方；了" font:17 size:CGSizeMake(0, 100)];
    echo(@"=======宽度：%f", labelsize.width);
    echo(@"=======高度：%f", labelsize.height);
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
