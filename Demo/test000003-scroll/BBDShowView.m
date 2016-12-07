//
//  BBDShowView.m
//  test000003-scroll
//
//  Created by 李笑臣 on 16/11/30.
//  Copyright © 2016年 李笑臣. All rights reserved.
//

#import "BBDShowView.h"

#define RandomLessOne (arc4random_uniform(256)/256.0)
#define RandomLessOneMoreHalf (arc4random_uniform(1)/4.0 + 0.75)
#define AnimateDurition (0.3)
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface BBDShowView () <UIScrollViewDelegate>

// 记录子页面要显示的大小（不需要手动赋值，使用缩放比例参数控制）
@property (nonatomic, assign) CGSize subViewSize;
// 子界面的最小缩放比例（使用maxScale进行计算）
@property (nonatomic, assign) CGFloat minScale;
// 子界面的最大缩放比例（参数直接记录）
@property (nonatomic, assign) CGFloat maxScale;
// 用来记录上一次滚动时的偏移量(用来判断滚动的方向)
@property (nonatomic, assign) CGFloat lastContentOffsetX;

// 用来记录所有子界面
@property (nonatomic, copy) NSArray *subViewArray;
// 用来显示背景图
@property (nonatomic, weak) UIImageView *backgroundImageView;


@end


@implementation BBDShowView

#pragma mark 构造方法
- (instancetype)initWithShowModelArray:(NSArray *)showModelArray subViewScale:(CGFloat)subViewScale andFrame:(CGRect)frame
{
    // 初始化基本控制属性
    self.maxScale = subViewScale;
    self.minScale = subViewScale - 0.2;// 此处控制 最小缩放比例!!!
    
    // 求子控件初始尺寸（先给个和屏幕一样宽的，后期再去缩放）
    CGFloat originSubViewWidth = ScreenWidth;
    CGFloat originSubViewheight = frame.size.height;
    CGSize subViewSize = CGSizeMake(originSubViewWidth, originSubViewheight);
    
    // 求contentSize
    NSInteger count = showModelArray.count;
    CGFloat contentWidth = ScreenWidth *  count;
    CGFloat contentHeight = 0;
    CGSize contentSize = CGSizeMake(contentWidth, contentHeight);
    
    if (self = [super initWithFrame:frame])
    {
        self.subViewSize = subViewSize;
        self.contentSize = contentSize;
        
        self.showModelArray = showModelArray;
        
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.scrollEnabled = YES;
        self.pagingEnabled = YES;
        self.clipsToBounds = NO;
        self.bounces = NO;
        self.backgroundColor = [UIColor clearColor];//背景颜色在此设置
        
        self.delegate = self;
    }
    return self;
}

#pragma mark 便利构造方法
+ (instancetype)showViewWithShowModelArray:(NSArray *)showModelArray subViewScale:(CGFloat)subViewScale andFrame:(CGRect)frame
{
    return [[self alloc] initWithShowModelArray:showModelArray subViewScale:subViewScale andFrame:frame];
}

#pragma mark 数据传递处理
- (void)setShowModelArray:(NSArray *)showModelArray
{
    _showModelArray = showModelArray;
    
    NSMutableArray *tempSubViewArray = [NSMutableArray arrayWithCapacity:self.subViewArray.count];
    for (int i = 0; i < showModelArray.count; i++)
    {
        BBDShowSubView *subView = [BBDShowSubView showSubViewWithShowModel:showModelArray[i]];
        subView.backgroundColor = [UIColor colorWithHue:RandomLessOne saturation:RandomLessOneMoreHalf brightness:1.0 alpha:0.7];// 随机背景色，测试使用
        
        // 设置子控件subView
        CGFloat x = i * self.subViewSize.width;
        CGFloat y = 0;
        CGFloat w = self.subViewSize.width;
        CGFloat h = self.subViewSize.height;
        subView.frame = CGRectMake(x, y, w, h);
        
        [self addSubview:subView];
        [tempSubViewArray addObject:subView];
    }
    // 将subViewArray指向 子控件数组
    self.subViewArray = tempSubViewArray;
    // 刷新，显示第二页
    [self refreshSubViewWithContentOffsetX:0.0];
    self.lastContentOffsetX = 0.0;
    
    // 此处逻辑：
    // 假如一共有3个以上子控件：显示第2个
    // 假如只有1到2个子控件：显示第1个
    if (self.subViewArray.count >= 3)
    {
        [self setContentOffset:CGPointMake(ScreenWidth, 0)];
        [self refreshSubViewWithContentOffsetX:ScreenWidth];
        [self playAnimateWithContentOffsetX:ScreenWidth];
    }
    else
    {
        [self refreshSubViewWithContentOffsetX:0.0];
        [self playAnimateWithContentOffsetX:0.0];
    }
}

#pragma mark 刷新缩放方法
- (void)refreshSubViewWithContentOffsetX:(CGFloat)contentOffsetX
{
    // ********************     控制缩放     **************************************
    
    // 创建用来保存控制每个子控件缩放比例的数组
    NSMutableArray *subViewScaleArray = [NSMutableArray arrayWithCapacity:self.subViewArray.count];
    for (int i = 0; i < self.subViewArray.count; i++)
    {
        // 用来保存第i个子控件需要缩放的比例
        float scale = 0;
        // 缩到最小的情况
        if (ABS(contentOffsetX / ScreenWidth - i) >= 1)
        {
            scale = self.minScale;
        }
        // 进入此判断内，则一定是当前要发生变化的两个
        else if (ABS(contentOffsetX / ScreenWidth - i) < 1)
        {
            if ((i - contentOffsetX / ScreenWidth) > 0)
            {
                scale = ((float)((NSInteger)contentOffsetX % (NSInteger)(ScreenWidth)) / ScreenWidth) * (self.maxScale - self.minScale) + self.minScale;
            }
            else
            {
                scale = (1 - (float)((NSInteger)contentOffsetX % (NSInteger)(ScreenWidth)) / ScreenWidth) * (self.maxScale - self.minScale) + self.minScale;
            }
        }
        [subViewScaleArray addObject:[NSNumber numberWithFloat:scale]];
    }
    
    for (int i = 0; i < self.subViewArray.count; i++)
    {
        BBDShowSubView *currentSubView = self.subViewArray[i];
        [currentSubView setScale:[subViewScaleArray[i] floatValue]];
    }
}

#pragma mark 播放偏移动画，结束
- (void)playAnimateWithContentOffsetX:(CGFloat)contentOffsetX
{
    NSInteger currentIndex = (NSInteger)contentOffsetX / (NSInteger)ScreenWidth;
    
        // 防止下标越界,处理左边的子控件(i-1)
        if (currentIndex - 1 >= 0)
        {
            BBDShowSubView *leftSubView = self.subViewArray[currentIndex - 1];
            
            CGAffineTransform transformScale = CGAffineTransformMakeScale(self.minScale, self.minScale);
            CGFloat tx = ScreenWidth * (1 - self.maxScale + 1 - self.minScale) * 0.5 / leftSubView.scale - (ScreenWidth * (1 - self.maxScale) * 0.3);
            CGAffineTransform transformFinal = CGAffineTransformTranslate(transformScale, tx, 0);
            [UIView animateWithDuration:AnimateDurition animations:^
            {
                [leftSubView setTransform:transformFinal];
            }];
        }
        // 防止下标越界,处理右边的子控件(i+1)
        if (currentIndex + 1 < self.subViewArray.count)
        {
            BBDShowSubView *leftSubView = self.subViewArray[currentIndex + 1];
            
            CGAffineTransform transformScale = CGAffineTransformMakeScale(self.minScale, self.minScale);
            CGFloat tx = - ScreenWidth * (1 - self.maxScale + 1 - self.minScale) * 0.5 / leftSubView.scale + (ScreenWidth * (1 - self.maxScale) * 0.3);
            CGAffineTransform transformFinal = CGAffineTransformTranslate(transformScale, tx, 0);
            [UIView animateWithDuration:AnimateDurition animations:^
             {
                 [leftSubView setTransform:transformFinal];
             }];
        }
}

#pragma mark 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 随滚动，刷新显示
    [self refreshSubViewWithContentOffsetX:scrollView.contentOffset.x];
    self.lastContentOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 滚动动画结束后，播放位移动画
    [self playAnimateWithContentOffsetX:scrollView.contentOffset.x];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 滚动后,假如不需要decelerate,也要播放移位动画
    if (decelerate == NO)
    {
        [self playAnimateWithContentOffsetX:scrollView.contentOffset.x];
    }
}

@end






