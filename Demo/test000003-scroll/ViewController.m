//
//  ViewController.m
//  test000003-scroll
//
//  Created by 李笑臣 on 16/11/30.
//  Copyright © 2016年 李笑臣. All rights reserved.
//

#import "ViewController.h"
#import "BBDShowView.h"

@interface ViewController ()

@property (nonatomic, weak) BBDShowView *showView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BBDShowModel *model1 = [BBDShowModel showModelWithTitle:@"生活玩乐爆款剧透-美食好券不止5折" imageName:@"001"];
    BBDShowModel *model2 = [BBDShowModel showModelWithTitle:@"一件装备-勾起一段历史" imageName:@"002"];
    BBDShowModel *model3 = [BBDShowModel showModelWithTitle:@"棉立方聚划算“衬衫”直降20元" imageName:@"003"];
    BBDShowModel *model4 = [BBDShowModel showModelWithTitle:@"”不止千元“法院低价处置车-限量疯抢" imageName:@"004"];

    NSArray *showModelArray = @[model1, model2, model3, model4];
    
    BBDShowView *showView = [BBDShowView showViewWithShowModelArray:showModelArray subViewScale:0.8 andFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    
    self.showView = showView;    
    [self.view addSubview:showView];
}



@end
