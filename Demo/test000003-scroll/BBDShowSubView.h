//
//  BBDShowSubView.h
//  test000003-scroll
//
//  Created by 李笑臣 on 16/11/30.
//  Copyright © 2016年 李笑臣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBDShowModel.h"

@interface BBDShowSubView : UIView

// 记录需要缩小的倍数，距离屏幕中心越远，越接近设定值
@property (nonatomic, assign) float scale;
// 展示用模型
@property (nonatomic, strong) BBDShowModel *showModel;



+ (instancetype)showSubViewWithShowModel:(BBDShowModel *)showModel;

- (instancetype)initWithShowModel:(BBDShowModel *)showModel;

@end
