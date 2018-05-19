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

//物理效果
- (void)func1{
    

}












- (void)func100{
//    默认帮你把timer加入Runloop
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
    
//    放入子线程
    dispatch_queue_t global_queue = dispatch_get_global_queue(0, 0);
    dispatch_async(global_queue, ^{
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
        
        
//        NSDefaultRunLoopMode ： 占位符，在默认和UItracking下
//        NSRunLoopCommonModes ：runloop默认的模式，有事件就处理
        //        UITrackingRunLoopMode :(优先切换)这个模式就是当UI时间交互的时候runloop切换到的模式
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    });
}

- (void)timerRun{
    NSLog(@"===睡两秒");
//    阻塞主线程
    [NSThread sleepForTimeInterval:2.0];
    
    static int num = 0;
    NSLog(@"%@------%d", [NSThread currentThread], num++);
    
}


























@end
