//
//  ZyBigImagesView.m
//  zylOC
//
//  Created by 张钰营 on 2018/5/22.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyBigImagesView.h"
#import <UIImageView+AFNetworking.h>

@interface ZyBigImagesView ()<UIScrollViewDelegate>
@property (nonatomic, strong) NSArray *mainData;
@property (nonatomic) BOOL isNetImage;
@property (nonatomic) NSInteger selected;
@end

@implementation ZyBigImagesView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)layoutSubviews{
    
}

- (void)initData:(NSArray *)mainData andSelected:(NSInteger)selected andIsNetImage:(BOOL)isNetImage{
    self.mainData = mainData;
    _isNetImage = isNetImage;
    _selected = selected;
    [self initView];
}

- (void)setMainData:(NSArray *)mainData{
    _mainData = mainData;
    if (_mainData == nil) {
        _mainData = [[NSArray alloc] init];
    }
}

- (void)initView{
    for (int i = 0; i < _mainData.count; i++) {
        UIImageView *ivImage = [[UIImageView alloc] init];
        if (_isNetImage) {
            [ivImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", _mainData[i]]] placeholderImage:[UIImage imageNamed:@"zy_default1"]];
        }else{
            [ivImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", _mainData[i]]]];
        }
        [ivImage setUserInteractionEnabled:YES];
        ivImage.contentMode = UIViewContentModeScaleAspectFit;
        ivImage.tag = 1000 + i;
        
        [self addSubview:ivImage];
        ivImage.frame = CGRectMake(WIDTH * i, 0, self.bounds.size.width, self.bounds.size.height);
        
//        UIPinchGestureRecognizer *pgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureRecognizerClick:)];
//        [ivImage addGestureRecognizer:pgr];
    }
    
    self.backgroundColor = [UIColor whiteColor];
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
    [self setContentOffset:CGPointMake(WIDTH * _selected, 0)];
    
    //clipsToBounds：是指视图上的子视图,如果超出父视图的部分就截取掉,
    //    masksToBounds：是指视图的图层上的子图层,如果超出父图层的部分就截取掉
    //    self.layer.masksToBounds = true;
    
    //    是否可触发
    [self setUserInteractionEnabled:true];
    
    // 设置UIScrollView的滚动范围（内容大小）如果该参数的width或者height设置为0，则scrollRectToVisible（有动画效果）方法无效，setContentOffset（无动画效果）有效
    self.contentSize = CGSizeMake(WIDTH * _mainData.count, 10);
    
    //    设置代理
    self.delegate = self;
}

//    MARK: 实现代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    已经滑动

}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    //    视图已经放大或缩小
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
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
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //    echo(@"不释放会一直调用，结束动画");
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    //    返回一个放大或者缩小的视图
    echo(@"");
    UIView *view = [[UIView alloc] init];
    return view;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    //    开始放大或者缩小
    echo(@"");
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    //    缩放结束时
    echo(@"");
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    //    是否支持滑动至顶部
    echo(@"");
    return true;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    //滑动到顶部时调用该方法
    echo(@"");
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [UIView animateWithDuration:1 animations:^{
//        [self setFrame:CGRectMake(0, 0, 0, 0)];
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
//}

//- (void)pinchGestureRecognizerClick:(UIPinchGestureRecognizer *)pgr{
//    UIImageView *ivImage = (UIImageView *)[self viewWithTag:1000];
//    ivImage.transform = CGAffineTransformMakeScale(pgr.scale, pgr.scale);
//}

@end
