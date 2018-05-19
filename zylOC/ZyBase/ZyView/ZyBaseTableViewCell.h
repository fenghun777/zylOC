//
//  ZyBaseTableViewCell.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZyBaseTableViewCell : UITableViewCell
/**
 *  主图
 */
@property (nonatomic, strong) UIImageView *ivHead;

/**
 *  标题
 */
@property (nonatomic, strong) UILabel *lblTitle;

/**
 *  副标题
 */
@property (nonatomic, strong) UILabel *lblDetail;
@end
