//
//  AnimationManager.m
//  自定义转场动画-练习20160928
//
//  Created by Leo on 9/28/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "AnimationManager.h"
#define SW [UIScreen mainScreen].bounds.size.width
#define SH [UIScreen mainScreen].bounds.size.height

@interface AnimationManager ()
{
    CustomAnimationType customType;
    CGRect customRect;
}
@end

@implementation AnimationManager

//自定义一个对象方法
- (instancetype)initWithCustomType:(CustomAnimationType)type andRect:(CGRect)rect {
    self = [super init];
    if (self) {
        customType = type;
        customRect = rect;
    }
    return self;
}

//实现类方法
+ (instancetype)customAnimationWithType:(CustomAnimationType)type andRect:(CGRect)rect {
    
    AnimationManager *manager = [[AnimationManager alloc]initWithCustomType:type andRect:rect];
    return manager;
}

#pragma mark -- 代理方法

//返回动画持续时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return customType == CustomAnimationTypePresent ? 0.2:0.2;
}

//动画类型
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    switch (customType) {
        case CustomAnimationTypePresent:
            [self handlePresentAnimation:transitionContext];
            break;
        case CustomAnimationTypeDismiss:
            [self handleDismissAnimation:transitionContext];
            break;
        default:
            break;
    }
}

//入场动画
- (void)handlePresentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *snapShot = [fromVC.view snapshotViewAfterScreenUpdates:NO];
    
    snapShot.tag = 1;
    fromVC.view.hidden = YES;
    snapShot.frame = fromVC.view.frame;
    toVC.view.frame = customRect;
    [containerView addSubview:snapShot];
    [containerView addSubview:toVC.view];
    
    //具体动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.frame = CGRectMake(0, 300, SW, 300);
        snapShot.transform = CGAffineTransformMakeRotation(M_PI/180*33);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

//出场动画
- (void)handleDismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    UIView *snapShot = [containerView viewWithTag:1];
    
    //具体动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        snapShot.transform = CGAffineTransformIdentity;
        fromVC.view.frame = customRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        toVC.view.hidden = NO;
        [snapShot removeFromSuperview];
    }];
}
@end
