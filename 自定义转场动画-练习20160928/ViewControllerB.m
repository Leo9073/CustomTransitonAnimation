//
//  ViewControllerB.m
//  自定义转场动画-练习20160928
//
//  Created by Leo on 9/28/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "ViewControllerB.h"
#import "AnimationManager.h"

@interface ViewControllerB () <UIViewControllerTransitioningDelegate>
{
    CGRect customRect;
    UIImageView *showImageView;
}

@end

@implementation ViewControllerB

- (instancetype)initWithRect:(CGRect)rect {
    self = [super init];
    if (self) {
        //使用自定义的动画
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
        customRect = rect;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    showImageView = [[UIImageView alloc]init];
    [self.view addSubview:showImageView];
    [self.view addObserver:self forKeyPath:@"frame" options:(NSKeyValueObservingOptionNew) context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    showImageView.image = self.showImage;
    showImageView.frame = self.view.bounds;
}

- (void)dealloc {
    
    [self.view removeObserver:self forKeyPath:@"frame" context:nil];
}

//入场动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [AnimationManager customAnimationWithType:CustomAnimationTypePresent andRect:customRect];
}

//出场动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return [AnimationManager customAnimationWithType:CustomAnimationTypeDismiss andRect:customRect];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
