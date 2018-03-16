//
//  DefaultViewController.m
//  zylOC
//
//  Created by yy z on 2018/3/14.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "DefaultViewController.h"
#import "ZyScratchcardsView.h"

@interface DefaultViewController ()
@property (nonatomic, strong) ZyScratchcardsView *svView ;

@end

@implementation DefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)controllerInit{

//    [self setImage1];
 
    self.svView = [[ZyScratchcardsView alloc] initWithFrame:CGRectMake(10, 10, WIDTH - 20, HEIGHT - 20)];
    [self.view addSubview:self.svView];
}

- (void)func1{
    UIImage *image = [UIImage zy_MakeDrawImage:@"ss"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    imageView.frame = CGRectMake(10, 10, image.size.width, image.size.height);
    echo(@"width:%f /n,height:%f", image.size.width, image.size.height);
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // 任意触摸位置
    UITouch *touchFirst = touches.anyObject;
    
    // 获取在当前view中的坐标
    CGPoint centerPoint = [touchFirst locationInView:self.svView];
    
    [self.svView clearTouchPoint:centerPoint];
}

























@end
