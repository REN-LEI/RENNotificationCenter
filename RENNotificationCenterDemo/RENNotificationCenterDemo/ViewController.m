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
    
    [self.notification rl_subscribe:UIApplicationDidBecomeActiveNotification block:^(NSNotification *event) {
        
         NSLog(@"event = %@",event.name);
         NSLog(@"=== %@",event.userInfo);
     }];
    
    [self.notification rl_subscribe:UIApplicationDidBecomeActiveNotification block:^(NSNotification *event)
    {
        NSLog(@"event = %@",event.name);
        NSLog(@"=== %@",event.userInfo);
    }];
    
    [self.notification rl_subscribe:UIApplicationWillResignActiveNotification block:^(NSNotification *event)
     {
         NSLog(@"event = %@",event.name);
         NSLog(@"=== %@",event.userInfo);
     }];
    
    [self.notification rl_subscribe:@"aa" block:^(NSNotification *event) {
        NSLog(@"event = %@",event.name);
        NSLog(@"=== %@",event.userInfo);
    }];
    
    [self.notification rl_publish:@"aa" userInfo:nil];
    
    [self.notification rl_publish:@"aa" userInfo:@1];

    [self.notification rl_unsubscribe:@"aa"];
    
    [self.notification rl_publish:@"aa" userInfo:@1];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
