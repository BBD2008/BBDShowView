//
//  BBDShowView.h
//  test000003-scroll
//
//  Created by 李笑臣 on 16/11/30.
//  Copyright © 2016年 李笑臣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBDShowModel.h"
#import "BBDShowSubView.h"

@interface BBDShowView : UIScrollView

// 保存模型数组
@property (nonatomic, copy) NSArray *showModelArray;

// 构造方法
- (instancetype)initWithShowModelArray:(NSArray *)showModelArray subViewScale:(CGFloat)subViewScale andFrame:(CGRect)frame;

+ (instancetype)showViewWithShowModelArray:(NSArray *)showModelArray subViewScale:(CGFloat)subViewScale andFrame:(CGRect)frame;

@end
