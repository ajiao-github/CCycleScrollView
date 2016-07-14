//
//  ViewController.m
//  LVScrollView
//
//  Created by ajiao on 16/7/14.
//  Copyright © 2016年 ajiao. All rights reserved.
//
/*
 *********************************************************************************
 *
 * 🌟🌟🌟 新建LVScrollView交流QQ群：277157761 🌟🌟🌟
 *
 * 在您使用此自动轮播库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并
 * 帮您解决问题。
 * Email : 2528982823@qq.com
 * GitHub: https://github.com/ajiao-github
 *
 *********************************************************************************
 */

#import "ViewController.h"
#import "LVScrollView.h"

//屏幕宽度
#define SCREEN_WIDTH      [UIScreen mainScreen].bounds.size.width
//屏幕高度
#define SCREEN_HEIGHT     [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *imgArr = @[@"http://img2.c.yinyuetai.com/others/admin/160712/0/-M-3ffad8890be36d9b6666e92929be5351_0x0.jpg",
                        @"http://img3.c.yinyuetai.com/others/admin/160706/0/-M-2698280be0fac8bea747841fc7df3d07_0x0.jpg",
                        @"http://img1.c.yinyuetai.com/others/admin/160712/0/-M-acd533e089f8e74b8ef1834c8e077b21_0x0.jpg",
                        @"http://img1.c.yinyuetai.com/others/admin/160712/0/-M-5000b25aa304f51066e8d58033a59bd3_0x0.jpg"];
    
//    NSArray *localImgArr = @[@"0.jpg",@"1.jpg",@"2.jpg",@"3.jpg"];
    
    LVScrollView *lvScrollView = [[LVScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) withAnimationDuration:1 withLoacalImage:NO withImageArr:imgArr andWithPlaceHoldImage:nil];
    [self.view addSubview:lvScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
