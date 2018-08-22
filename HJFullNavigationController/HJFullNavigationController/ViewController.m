//
//  ViewController.m
//  HJFullNavigationController
//
//  Created by huangjian on 2018/4/24.
//  Copyright © 2018年 huangjian. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor orangeColor];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NextViewController *vc=[[NextViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
