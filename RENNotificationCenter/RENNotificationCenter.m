//
//  RENNotificationCenter.m
//  demo
//
//  Created by renlei on 16/1/28.
//  Copyright © 2016年 renlei. All rights reserved.
//

#import "RENNotificationCenter.h"
#import <objc/runtime.h>

@interface RENSubscribeObject : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) RENNotificationBlock block;

+ (instancetype)rl_subscribe:(NSString *)name block:(RENNotificationBlock)block;

@end

@implementation RENSubscribeObject

+ (instancetype)rl_subscribe:(NSString *)name block:(RENNotificationBlock)block {
    RENSubscribeObject *obj = [[RENSubscribeObject alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:obj selector:@selector(rl_subscribeCallbackObject:) name:name object:nil];
    obj.name = name;
    obj.block = [block copy];
    return obj;
}

- (void)rl_subscribeCallbackObject:(NSNotification *)note {
    self.block(note);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:self.name object:nil];
}

@end



@interface RENNotificationCenter ()

@property (nonatomic, strong) NSMutableDictionary *subscribeInfosMap;
@property (nonatomic, weak) id object;

@end

@implementation RENNotificationCenter

+ (instancetype)rl_subscribeObject:(id)obj {
    return [[RENNotificationCenter alloc] initWithObserver:obj];
}

- (instancetype)initWithObserver:(id)obj {
    if (self = [super init]) {
        self.subscribeInfosMap = [[NSMutableDictionary alloc] init];
        self.object = obj;
    }
    return self;
}

- (void)rl_subscribe:(NSString *)name block:(RENNotificationBlock)block {
    
    if ([self.subscribeInfosMap.allKeys containsObject:name]) {
        NSLog(@"重复订阅事件：%@",name);
        return;
    }
    RENSubscribeObject *object = [RENSubscribeObject rl_subscribe:name block:block];
    [self.subscribeInfosMap setObject:object forKey:name];
}

- (void)rl_publish:(NSString *)name userInfo:(id)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:self.object userInfo:userInfo];
}

- (void)rl_unsubscribe:(NSString *)eventName {
    [self.subscribeInfosMap removeObjectForKey:eventName];
}


- (void)rl_unsubscribeAll {
    [self.subscribeInfosMap removeAllObjects];
}

@end


@implementation NSObject (RENNotificationCenter)

- (RENNotificationCenter *)notification {
    
    id obj = objc_getAssociatedObject(self, _cmd);

    if (!obj) {
        obj = [RENNotificationCenter rl_subscribeObject:self];
        self.notification = obj;
    }
    return obj;
}

- (void)setNotification:(RENNotificationCenter *)notification {
    objc_setAssociatedObject(self, @selector(notification), notification, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
