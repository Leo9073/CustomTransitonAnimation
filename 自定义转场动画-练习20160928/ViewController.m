//
//  ViewController.m
//  自定义转场动画-练习20160928
//
//  Created by Leo on 9/28/16.
//  Copyright © 2016 Leo. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerB.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 200, 200);
    button.center = self.view.center;
    [button setImage:[UIImage imageNamed:@"logo_client@3X"] forState:UIControlStateNormal];
//    button.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(buttonTaped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonTaped:(UIButton *)sender {
    
    CGRect rect = sender.frame;
    ViewControllerB *VCB = [[ViewControllerB alloc]initWithRect:rect];
    VCB.showImage = sender.imageView.image;
    [self presentViewController:VCB animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
