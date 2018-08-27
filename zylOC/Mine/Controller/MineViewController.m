//
//  MineViewController.m
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)controllerInit{
    [super controllerInit];
    
    
    UIButton *btnLogin = [UIButton zy_InitWithTitle:@"" font:FONT(14) colors:@[COLOR_TEXT_TITLE] bgcolors:[UIColor redColor] radius:5 bkHandler:^(id sender) {
        
    }];
    [self.view addSubview:btnLogin];
    [btnLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 35));
    }];
}

@end
