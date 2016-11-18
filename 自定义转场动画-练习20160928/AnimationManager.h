//
//  AnimationManager.h
//  自定义转场动画-练习20160928
//
//  Created by Leo on 9/28/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//定义一个枚举，用来表示动画类型
typedef NS_ENUM(NSInteger,CustomAnimationType){
    CustomAnimationTypePresent = 0,
    CustomAnimationTypeDismiss,
};

@interface AnimationManager : NSObject <UIViewControllerAnimatedTransitioning>
//定义一个类方法
+ (instancetype)customAnimationWithType:(CustomAnimationType)type andRect:(CGRect)rect;
@end
