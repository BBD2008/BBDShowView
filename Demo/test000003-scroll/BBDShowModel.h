//
//  BBDShowModel.h
//  test000003-scroll
//
//  Created by 李笑臣 on 16/11/30.
//  Copyright © 2016年 李笑臣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBDShowModel : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imageName;

+ (instancetype)showModelWithTitle:(NSString *)title imageName:(NSString *)imageName;

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName;

@end
