//
//  FCBaseController.m
//  BaseProjectDemo
//
//  Created by locojoy on 15/10/26.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

/**
 常用头文件
 常胡宏定义
 
 初始化网络
 代理方法
 网络状态
 
 加载view
 常用控件初始化
 常用控件代理方法
 
 空页面内容显示
 指示器显示 HUD，ALTERVIEW，kt
 
 统计任务
 
 需要子类实现的方法
  返回方法
    空内容页面的文字或图片
 
 delloc  取消统计任务，通知监听，http请求
 
 */


#import "FCBaseController.h"

@interface FCBaseController ()<UIWebViewDelegate>

@end

@implementation FCBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    UIWebView *web = [[UIWebView alloc]init];
    web.delegate = self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
