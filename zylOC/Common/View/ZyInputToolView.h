//
//  ZyInputToolView.h
//  zylOC
//
//  Created by 张钰营 on 2018/7/23.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZyInputToolViewDelegate <NSObject>
//输入框输入结束
- (void)inputToolViewDelegateFunforEditedEnd:(NSString *)inputStr;
@end

@interface ZyInputToolView : UIView
@property (nonatomic, weak) id<ZyInputToolViewDelegate> inputToolViewDelegate;
@end
