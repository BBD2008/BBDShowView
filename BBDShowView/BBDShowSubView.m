//
//  BBDShowSubView.m
//  test000003-scroll
//
//  Created by 李笑臣 on 16/11/30.
//  Copyright © 2016年 李笑臣. All rights reserved.
//

#import "BBDShowSubView.h"

#define TitleBackgroundHeight 30

@interface BBDShowSubView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, weak) UIView *titleBackground;

@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, weak) UIImageView *backgroundImageView;

@end


@implementation BBDShowSubView

#pragma mark 构造方法
- (instancetype)initWithShowModel:(BBDShowModel *)showModel
{
    if (self = [super init])
    {
        [self setupSubViews];
        self.showModel = showModel;
    }
    return self;
}

+ (instancetype)showSubViewWithShowModel:(BBDShowModel *)showModel
{
    return [[self alloc] initWithShowModel:showModel];
}

#pragma mark 子控件初始化
- (void)setupSubViews
{
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    [self addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
    
}

#pragma mark 数据传递和内容刷新
- (void)setShowModel:(BBDShowModel *)showModel
{
    _showModel = showModel;
    self.backgroundImage = [UIImage imageNamed:showModel.imageName];
    self.backgroundImageView.image = self.backgroundImage;
}

#pragma mark 控制控件刷新
- (void)setScale:(float)scale
{
    _scale = scale;
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    // 在此控制子控件的frame
    self.backgroundImageView.frame = self.bounds;
    // 刷新子控件
    [self refreshSubviewsWithSelfFrame:frame];
}

#pragma mark 刷新子控件布局
- (void)refreshSubviewsWithSelfFrame:(CGRect)frame
{
    if (self.showModel.title != nil && self.showModel.title.length > 0)
    {
        // 配置label底色
        UIView *tempBackground = [UIView new];
        self.titleBackground = tempBackground;
        [self addSubview:self.titleBackground];
        
        self.titleBackground.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
        
        self.titleBackground.frame = CGRectMake(0, frame.size.height - TitleBackgroundHeight, frame.size.width, TitleBackgroundHeight);
        
        // 配置label
        UILabel *tempLabel = [UILabel new];
        self.titleLabel = tempLabel;
        [self addSubview:self.titleLabel];
        
        self.titleLabel.text = [@"  " stringByAppendingString:self.showModel.title];
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        
        self.titleLabel.frame = self.titleBackground.frame;
        
        
    }
}


@end










