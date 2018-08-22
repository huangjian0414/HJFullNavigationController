//
//  UIViewController+HJNavigationExtension.h
//  HJNavigationController
//
//  Created by huangjian on 17/4/23.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJNavigationController.h"


@interface UIViewController (HJNavigationExtension)

@property (nonatomic, assign) BOOL hj_fullScreenPopGestureEnabled;

@property (nonatomic, weak) HJNavigationController *hj_navigationController;

@end
