//
//  DefaultViewController.m
//  zylOC
//
//  Created by yy z on 2018/3/14.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "DefaultViewController.h"

@interface DefaultViewController ()

@end

@implementation DefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)controllerInit{
    
    UILabel *topView = [[UILabel alloc] initWithFrame:CGRectMake(64, 10, 200, 300)];
    [self.view addSubview:topView];
    topView.backgroundColor = [UIColor yellowColor];

    echo(@"%@", [NSDate zy_FormattedTime:[NSDate date]]);
    
}

@end
