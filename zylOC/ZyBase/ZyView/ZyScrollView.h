//
//  ZyScrollView.h
//  zylOC
//
//  Created by yy z on 2018/3/21.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZyScrollView : UIScrollView
- (void)initView;
@property (nonatomic, strong) NSArray *mainData;

- (void)scrollViewOfWidth:(CGFloat)svWidth andSpaceWidth:(CGFloat)spaceWidth;
@end
