//
//  BBDShowModel.m
//  test000003-scroll
//
//  Created by 李笑臣 on 16/11/30.
//  Copyright © 2016年 李笑臣. All rights reserved.
//

#import "BBDShowModel.h"

@interface BBDShowModel ()



@end

@implementation BBDShowModel

+ (instancetype)showModelWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    return [[self alloc] initWithTitle:title imageName:imageName];
}

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    if (self = [super init])
    {
        self.title = title;
        self.imageName = imageName;
    }
    return self;
}

@end
