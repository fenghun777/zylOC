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
@property (nonatomic, strong) UIImageView *coverView ;
@property (nonatomic, strong) UIView *svView ;
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
    
//    ZyScratchcardsView *view = [[ZyScratchcardsView alloc] initWithFrame:CGRectMake(10, 10, 300, 600)];
//    [self.view addSubview:view];
    
}

- (void)func1{

    // 刮出后要展示的图片
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"girl"]];

    // 设置frame
    imgView.frame = self.view.bounds;

    // 添加其为子控件
    [self.view addSubview:imgView];

    // 遮罩层图片
    UIImageView *coverView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zy_default"]];

    // 设置frame
    coverView.frame = CGRectMake((WIDTH - 200)/2, (HEIGHT - 200)/2, 200, 200);

    // 打开与用户交互功能
    coverView.userInteractionEnabled = YES;

    // 添加其为子控件
    [self.view addSubview:coverView];

    // 配置遮罩层view(添加水印文字)
    coverView.image = [self deployCoverViewWithGivenImgView:coverView givenStr:@"刮开涂层有惊喜" givenFont:[UIFont systemFontOfSize:30.0]];

    self.coverView = coverView;
}

///  配置遮盖层view
///
///  @param coverImgView 遮盖层的imageView
///  @param givenStr     显示的文字
///  @param givenFont    字体大小
///
///  @return 返回一个有水印文字的image

- (UIImage *)deployCoverViewWithGivenImgView:(UIImageView *)coverImgView givenStr:(NSString *)givenStr givenFont:(UIFont *)givenFont
{
    CGSize size = CGSizeMake(coverImgView.bounds.size.width, coverImgView.bounds.size.height);

    // 画布大小
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);

    // 画图起点
    [coverImgView.image drawAtPoint:CGPointMake(0, 0)];

    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // 绘制路径
    // kCGPathFill填充非零绕数规则,kCGPathEOFill表示用奇偶规则,kCGPathStroke路径,kCGPathFillStroke路径填充,kCGPathEOFillStroke表示描线,不是填充
    CGContextDrawPath(ctx, kCGPathStroke);

    // 要显示字体所占的宽度
    CGFloat w = [self boundingRectHeightWithText:givenStr font:givenFont].width;

    // 要显示字体的画图位置
    [givenStr drawAtPoint:CGPointMake((coverImgView.bounds.size.width - w) / 2, 50) withAttributes:@{NSFontAttributeName:givenFont,NSForegroundColorAttributeName:[UIColor blackColor]}];

    // 获取从当前上下文中的图片
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();

    // 结束上下文
    UIGraphicsEndPDFContext();

    return newImg;
}

// 返回文字所占大小
- (CGSize)boundingRectHeightWithText:(NSString *)text font:(UIFont *)font {

    CGSize maximumSize = CGSizeMake(270, CGFLOAT_MAX);
    CGRect boundingRect = [text boundingRectWithSize:maximumSize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{ NSFontAttributeName : font}
                                             context:nil];
    return boundingRect.size;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 任意触摸位置
    UITouch *touch = touches.anyObject;

    // 获取在当前view中的坐标
    CGPoint centerPoint = [touch locationInView:self.coverView];

    // 设置清除点的大小
    CGRect rect = CGRectMake(centerPoint.x, centerPoint.y, 40, 40);

    // 画布大小
    UIGraphicsBeginImageContextWithOptions(self.coverView.bounds.size, NO, 0.0);

    // 获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // 将coverView的layer映射渲染到上下文中
    [self.coverView.layer renderInContext:ctx];

    // 清除划过位置的图片
    CGContextClearRect(ctx, rect);

    // 获取从当前上下文中的图片
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();

    // 结束上下文
    UIGraphicsEndImageContext();

    self.coverView.image = newImg;
}

@end
