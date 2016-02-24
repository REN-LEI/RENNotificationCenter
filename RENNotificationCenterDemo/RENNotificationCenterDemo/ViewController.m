//
//  ViewController.m
//  RENNotificationCenterDemo
//
//  Created by renlei on 16/2/24.
//  Copyright © 2016年 renlei. All rights reserved.
//

#import "ViewController.h"
#import "RENNotificationCenter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.notification rl_subscribe:UIApplicationDidBecomeActiveNotification block:^(RENEvent *event)
    {
        NSLog(@"event = %@",event.name);
    }];
    
    [self.notification rl_subscribe:UIApplicationWillResignActiveNotification block:^(RENEvent *event)
     {
         NSLog(@"event = %@",event.name);
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
