//
//  ZyScrollView.h
//  zylOC
//
//  Created by yy z on 2018/3/21.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickImageNumBlock)(NSString *indexStr);
@interface ZyScrollView : UIScrollView
@property (nonatomic, strong) NSArray *mainData;
@property (nonatomic, strong) ClickImageNumBlock clickImageNumBlock;

- (void)initView;
- (void)scrollViewOfWidth:(CGFloat)svWidth andSpaceWidth:(CGFloat)spaceWidth;
@end
