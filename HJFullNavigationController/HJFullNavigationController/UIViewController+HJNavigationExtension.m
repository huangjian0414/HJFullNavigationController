//
//  UIViewController+HJNavigationExtension.m
//  HJNavigationController
//
//  Created by huangjian on 17/4/23.
//  Copyright © 2017年 huangjian. All rights reserved.
//

#import "UIViewController+HJNavigationExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (HJNavigationExtension)

- (BOOL)hj_fullScreenPopGestureEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setHj_fullScreenPopGestureEnabled:(BOOL)fullScreenPopGestureEnabled {
    objc_setAssociatedObject(self, @selector(hj_fullScreenPopGestureEnabled), @(fullScreenPopGestureEnabled), OBJC_ASSOCIATION_ASSIGN);
}

- (HJNavigationController *)hj_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHj_navigationController:(HJNavigationController *)navigationController {
    objc_setAssociatedObject(self, @selector(hj_navigationController), navigationController, OBJC_ASSOCIATION_ASSIGN);
}

@end
