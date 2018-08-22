//
//  NextViewController.m
//  HJFullNavigationController
//
//  Created by huangjian on 2018/4/24.
//  Copyright © 2018年 huangjian. All rights reserved.
//

#import "NextViewController.h"
#import "UIViewController+HJNavigationExtension.h"
//#import "UIViewController+JTNavigationExtension.h"
#import "ViewController.h"
@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blueColor];
    self.hj_fullScreenPopGestureEnabled=YES;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"呵呵" style:UIBarButtonItemStylePlain target:self action:@selector(hah)];
}
-(void)hah
{
    ViewController *vc=[[ViewController alloc]init];
//    NSUInteger index= [self.navigationController.hj_navigationController.viewControllers indexOfObject:vc];
//    [self.navigationController popToViewController:self.hj_navigationController.hj_viewControllers[index] animated:YES];
    NSUInteger index= [self.navigationController.hj_navigationController.viewControllers indexOfObject:vc];
    [self.navigationController popToViewController:self.hj_navigationController.hj_viewControllers[index] animated:YES];
}
@end
