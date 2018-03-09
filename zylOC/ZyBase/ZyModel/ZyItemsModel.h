//
//  ZyItemsModel.h
//  zylOC
//
//  Created by yy z on 2018/3/9.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyBaseModel.h"

@interface ZyItemsModel : ZyBaseModel
@property (copy, nonatomic) NSArray *items;
@property (copy, nonatomic) NSDictionary *_links;
@property (copy, nonatomic) NSDictionary *_meta;
@end
