//
//  AllFunctionViewController.m
//  zylOC
//
//  Created by yy z on 2018/3/16.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "AllFunctionViewController.h"
#import "ZyScratchcardsView.h"

@interface AllFunctionViewController ()
@property (nonatomic, strong) ZyScratchcardsView *svView ;
@end

@implementation AllFunctionViewController

//这里汇总所有的特殊功能
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)controllerInit{
    
//    刮一刮 刮刮乐
    [self func1];
    
}

//    刮一刮 刮刮乐
- (void)func1{
    self.svView = [[ZyScratchcardsView alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, HEIGHT - 20)];
    [self.view addSubview:self.svView];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 任意触摸位置
    UITouch *touchFirst = touches.anyObject;
//    刮刮乐
    [self.svView clearTouchPoint:touchFirst];
}

@end
