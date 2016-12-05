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
    
    BBDShowModel *model1 = [BBDShowModel showModelWithTitle:@"哇哈哈哈哈哈哈哈哈---001" imageName:@"001"];
    BBDShowModel *model2 = [BBDShowModel showModelWithTitle:@"哇哈哈哈哈哈哈哈哈---002" imageName:@"002"];
    BBDShowModel *model3 = [BBDShowModel showModelWithTitle:@"哇哈哈哈哈哈哈哈哈---003" imageName:@"003"];
    BBDShowModel *model4 = [BBDShowModel showModelWithTitle:@"哇哈哈哈哈哈哈哈哈---004" imageName:@"004"];

    NSArray *showModelArray = @[model1, model2, model3, model4];
    
    BBDShowView *showView = [BBDShowView showViewWithShowModelArray:showModelArray subViewScale:0.8 andFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 180)];
    
    self.showView = showView;    
    [self.view addSubview:showView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
