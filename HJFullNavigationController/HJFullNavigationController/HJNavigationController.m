//
//  HJNavigationController.m
//  HJNavigationController
//
//  Created by huangjian on 17/4/23.
//  Copyright © 2017年 huanjian. All rights reserved.
//

#import "HJNavigationController.h"
#import "UIViewController+HJNavigationExtension.h"

#pragma mark - HJWrapNavigationController

@interface HJWrapNavigationController : UINavigationController

@end

@implementation HJWrapNavigationController

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    HJNavigationController *hj_navigationController = viewController.hj_navigationController;
    NSInteger index = [hj_navigationController.hj_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:hj_navigationController.viewControllers[index] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.hj_navigationController = (HJNavigationController *)self.navigationController;
    viewController.hj_fullScreenPopGestureEnabled = viewController.hj_navigationController.fullScreenPopGestureEnabled;
    
   //UIImage *backButtonImage = viewController.hj_navigationController.backButtonImage;
    
    if (self.viewControllers.count>0) {
        [viewController setHidesBottomBarWhenPushed:YES];
//        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithImg:viewController.hj_navigationController.backImg highImg:viewController.hj_navigationController.backImg target:self action:@selector(didTapBackButton) forControlEvents:UIControlEventTouchUpInside];
        
    }
//    if (!backButtonImage) {
//        backButtonImage = [UIImage imageNamed:kDefaultBackImageName];
//    }
    
    //viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didTapBackButton)];
    
    [self.navigationController pushViewController:[HJWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.hj_navigationController=nil;
}

@end

#pragma mark - HJWrapViewController

@implementation HJWrapViewController

+ (HJWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    HJWrapNavigationController *wrapNavController = [[HJWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[viewController];
    HJWrapViewController *wrapViewController = [[HJWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}

- (BOOL)hj_fullScreenPopGestureEnabled {
    return [self rootViewController].hj_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    HJWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    return wrapNavController.viewControllers.firstObject;
}

@end

#pragma mark - HJNavigationController

@interface HJNavigationController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;

@property (nonatomic, strong) id popGestureDelegate;

@end

@implementation HJNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.hj_navigationController = self;
        self.viewControllers = @[[HJWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.hj_navigationController = self;
        self.viewControllers = @[[HJWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarHidden:YES animated:NO];
    self.delegate = self;
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
    self.popPanGesture.delegate=self;
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.hj_fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        }else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    }else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = viewController.hj_fullScreenPopGestureEnabled;
    }
}

#pragma mark - UIGestureRecognizerDelegate

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch locationInView:self.hj_navigationController.viewControllers.firstObject.view].x>20) {
        return NO;
    }
    NSLog(@"kkk-%@",NSStringFromClass([touch.view class]));
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        if (self.haveSideslip) {
            return NO;
        }
    }
    return YES;
}
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer{
    CGPoint translation = [gestureRecognizer velocityInView:gestureRecognizer.view];
    if (translation.x<0) {
        return NO;
    }else{
        return YES;
    }
 }
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter

- (NSArray *)hj_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (HJWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
        
    }
    return viewControllers.copy;
}

@end
