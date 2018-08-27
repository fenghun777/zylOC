//
//  ChatViewModel.h
//  zylOC
//
//  Created by 张钰营 on 2018/7/20.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyBaseModel.h"

@interface ChatViewModel : ZyBaseModel
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *cellType;
@property (nonatomic) ChatViewCellType type;
@end
