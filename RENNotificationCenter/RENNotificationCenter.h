//
//  RENNotificationCenter.h
//  demo
//
//  Created by renlei on 16/1/28.
//  Copyright © 2016年 renlei. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^RENNotificationBlock)(NSNotification *event);

@interface RENNotificationCenter : NSObject

/**
 *  订阅事件
 *
 *  @param name  事件名
 *  @param block 回调
 */
- (void)rl_subscribe:(NSString *)name block:(RENNotificationBlock)block;

/**
 *  发布事件
 *
 *  @param name     事件名
 *  @param userInfo 事件内容
 */
- (void)rl_publish:(NSString *)name userInfo:(id)userInfo;

/**
 *  取消订阅事件
 *
 *  @param eventName 事件名
 */
- (void)rl_unsubscribe:(NSString *)eventName;

/**
 *  取消所有订阅事件
 */
- (void)rl_unsubscribeAll;


@end



@interface NSObject (RENNotificationCenter)

@property (nonatomic, strong) RENNotificationCenter *notification;

@end

