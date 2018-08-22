//
//  HJNavigationController.h
//  HJNavigationController
//
//  Created by huangjian on 17/4/23.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HJNavigationController : UINavigationController

@property (nonatomic, strong) UIImage *backButtonImage;

@property (nonatomic, assign) BOOL fullScreenPopGestureEnabled;

@property (nonatomic, copy, readonly) NSArray *hj_viewControllers;

@property (nonatomic,copy)NSString *backImg;

@property (nonatomic,assign)BOOL haveSideslip;

@end

@interface HJWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (HJWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end
