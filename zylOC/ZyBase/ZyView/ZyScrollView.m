//
//  ZyScrollView.m
//  zylOC
//
//  Created by yy z on 2018/3/21.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyScrollView.h"

@interface ZyScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *mainData;
@property (nonatomic) CGFloat lastContentOffset;
@property (nonatomic) CGFloat currentContentOffset;
@property (nonatomic) CGFloat num;//记录
@end

@implementation ZyScrollView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
//    如果要无限循环四张图片，那么需要把第一张拼接到最后面，最后一张拼到最前进行过渡
//    _mainData = @[@"girl", @"zy_default1", @"girl", @"zy_default1"];
    _mainData = @[@"zy_default1", @"girl", @"zy_default1", @"girl", @"zy_default1", @"girl"];
    for (int i = 0; i < _mainData.count; i++) {
        UIImage *image = [UIImage imageNamed:_mainData[i]];
        UIImageView *ivImage = [[UIImageView alloc] initWithImage:image];
        ivImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:ivImage];
        ivImage.frame = CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height);
    }
    
    self.backgroundColor = [UIColor yellowColor];
    // 是否支持滑动最顶端
    self.scrollsToTop = true;
    
    // 是否反弹
    self.bounces = false;
    
    // 是否分页
    [self setPagingEnabled:true];
    
    // 是否滚动
    [self setScrollEnabled:true];
    
    // 隐藏垂直滚动条
    self.showsVerticalScrollIndicator = false;
    // 隐藏水平滚动条
    self.showsHorizontalScrollIndicator = true;
    
    // 设置indicator风格
    [self setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
    
    // 设置内容的边缘    UIEdgeInsetsMake(<#T##top: CGFloat##CGFloat#>, <#T##left: CGFloat##CGFloat#>, <#T##bottom: CGFloat##CGFloat#>, <#T##right: CGFloat##CGFloat#>)
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);// 增加额外的滚动区域
    //        Indicators边缘
    self.scrollIndicatorInsets = UIEdgeInsetsMake(0, 10, 10, 10);
    // 提示用户,Indicators flash
    [self flashScrollIndicators];
    // 是否同时运动,lock
    [self setDirectionalLockEnabled:false];    
    
    // 用来记录scrollview滚动的位置
//    self.contentOffset = CGPointMake(20, 40);
    //        设置初始位置
    [self setContentOffset:CGPointMake(self.frame.size.width, 0)];
    
    //设置超过子图层的部分裁减掉
//    self.layer.masksToBounds = true;
    
//    是否可触发
    [self setUserInteractionEnabled:true];
    
    // 设置UIScrollView的滚动范围（内容大小）
    self.contentSize = CGSizeMake(self.frame.size.width * _mainData.count, 0);
    
//    设置代理
    self.delegate = self;
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerClick) userInfo:@"timer" repeats:true];
}

//    MARK: 实现代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    已经滑动
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
//    视图已经放大或缩小
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    _lastContentOffset = point.x;

}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    echo(@"拖拽将要结束");
    
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
////    结束拖动
//
//}

//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
////    开始减速
//
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    减速停止
    _currentContentOffset = scrollView.contentOffset.x;
    CGPoint point = scrollView.contentOffset;
    CGFloat x = point.x/self.frame.size.width;
//    左滑，向左滑动
    if (_lastContentOffset < _currentContentOffset) {
        _num = x;
        if ((point.x == self.frame.size.width * (_mainData.count - 1))&&(point.y == 0)) {
            [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
        }
    }else{
        // 右划，向右滚动
        _num = x - 1.0;
        if ((point.x == 0)&&(point.y == 0)) {
            [scrollView setContentOffset:CGPointMake(self.frame.size.width * (_mainData.count - 2), 0)];
        }
    }
}

//- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
////    结束动画
//}
//
//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
////    返回一个放大或者缩小的视图
//    UIView *view = [[UIView alloc] init];
//    return view;
//}
//
//- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
////    开始放大或者缩小
//
//}
//
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
////    缩放结束时
//
//}

//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
//    //    是否支持滑动至顶部
//    return true;
//}
//
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
////滑动到顶部时调用该方法
//
//}



















- (void)timerClick{
    _num = _num + 1;
    CGPoint point = self.contentOffset;
    if ((point.x == self.frame.size.width * _mainData.count)&&(point.y == 0)) {
        [self setContentOffset:CGPointMake(0, 0)];
        _num = 1.0;
    }
    [self setContentOffset:CGPointMake(self.frame.size.width * _num, 0)];
    
    [self scrollRectToVisible:<#(CGRect)#> animated:<#(BOOL)#>]
    
    
//    //    减速停止
//    _currentContentOffset = scrollView.contentOffset.x;
//    CGPoint point = scrollView.contentOffset;
//    CGFloat x = point.x/self.frame.size.width;
//    //    左滑，向左滑动
//    if (_lastContentOffset < _currentContentOffset) {
//        _num = x;
//        if ((point.x == self.frame.size.width * (_mainData.count - 1))&&(point.y == 0)) {
//            [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0)];
//        }
//    }else{
//        // 右划，向右滚动
//        _num = x - 1.0;
//        if ((point.x == 0)&&(point.y == 0)) {
//            [scrollView setContentOffset:CGPointMake(self.frame.size.width * (_mainData.count - 2), 0)];
//        }
//    }
}

@end
