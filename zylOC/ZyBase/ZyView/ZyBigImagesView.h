//
//  ZyBigImagesView.h
//  zylOC
//
//  Created by 张钰营 on 2018/5/22.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

//大图模式
@interface ZyBigImagesView : UIScrollView
- (void)initData:(NSArray *)mainData andSelected:(NSInteger)selected andIsNetImage:(BOOL)isNetImage;
@end
