//
//  DefaultViewController.m
//  zylOC
//
//  Created by yy z on 2018/3/14.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "DefaultViewController.h"
#import "ZyScrollView.h"

@interface DefaultViewController ()

@end

@implementation DefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)controllerInit{
  
    [self func1];
}

- (void)func1{

    ZyScrollView * sv = [[ZyScrollView alloc] initWithFrame:CGRectMake(10, 10, 300, 300)];
    [self.view addSubview:sv];
}



























@end
