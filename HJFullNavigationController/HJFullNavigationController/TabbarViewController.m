//
//  TabbarViewController.m
//  HJFullNavigationController
//
//  Created by huangjian on 2018/4/26.
//  Copyright © 2018年 huangjian. All rights reserved.
//

#import "TabbarViewController.h"
#import "HJNavigationController.h"
#import "ViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ViewController *vc=[[ViewController alloc]init];
    [self setOneChildController:vc title:@"首页" nomarlImage:@"" selectedImage:@""];
    
    ViewController *vc1=[[ViewController alloc]init];
    [self setOneChildController:vc1 title:@"我" nomarlImage:@"" selectedImage:@""];
}

- (void)setOneChildController:(UIViewController *)vc title:(NSString *)title nomarlImage:(NSString *)nomarlImage selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title=title;
    vc.tabBarItem.image=[[UIImage imageNamed:nomarlImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage=[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
    HJNavigationController *navi=[[HJNavigationController alloc]initWithRootViewController:vc];
    navi.backButtonImage=[UIImage imageNamed:@"返回-黑色"];
    [self addChildViewController:navi];
}

@end
