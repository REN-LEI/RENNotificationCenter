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

+ (instancetype)rl_subscribe:(NSString *)name block:(RENNotificationBlock)block;

@end

@implementation RENSubscribeObject {
    NSString *_name;
    RENNotificationBlock _block;
}
+ (instancetype)rl_subscribe:(NSString *)name block:(RENNotificationBlock)block {
    RENSubscribeObject *obj = [[RENSubscribeObject alloc] init];
    obj->_name = name;
    obj->_block = [block copy];
    [[NSNotificationCenter defaultCenter] addObserver:obj selector:@selector(rl_subscribeCallbackObject:) name:name object:nil];
    return obj;
}

- (void)rl_subscribeCallbackObject:(NSNotification *)not {
    id obj = not.userInfo[_name]?:not.userInfo;
    RENEvent *event = [[RENEvent alloc] initWithName:not.name object:not.object userInfo:obj];
    _block(event);
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_name object:nil];
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
        _subscribeInfosMap = [[NSMutableDictionary alloc] init];
        _object = obj;
    }
    return self;
}

- (void)rl_subscribe:(NSString *)name block:(RENNotificationBlock)block {
    
    if ([self.subscribeInfosMap.allKeys containsObject:name]) {
        NSLog(@"重复订阅事件：%@",name);
        return;
    }
    RENSubscribeObject *object = [RENSubscribeObject rl_subscribe:name block:block];
    [_subscribeInfosMap setObject:object forKey:name];
}

- (void)rl_publish:(NSString *)name userInfo:(id)userInfo {
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:_object userInfo:userInfo?@{name:userInfo}:nil];
}

- (void)rl_unsubscribe:(NSString *)eventName {
    [_subscribeInfosMap removeObjectForKey:eventName];
}


- (void)rl_unsubscribeAll {
    [_subscribeInfosMap removeAllObjects];
}

@end


@implementation RENEvent

- (instancetype)initWithName:(NSString *)name object:(id)object userInfo:(id)userInfo {
    
    if (self = [super init]) {
        _name = name;
        _object = object;
        _userInfo = userInfo;
    }
    return self;
}

@end

void *RENNotificationKey;

@implementation NSObject (RENNotificationCenter)

- (RENNotificationCenter *)notification {
    
    id obj = objc_getAssociatedObject(self, RENNotificationKey);
    
    if (!obj) {
        obj = [RENNotificationCenter rl_subscribeObject:self];
        self.notification = obj;
    }
    return obj;
}

- (void)setNotification:(RENNotificationCenter *)notification {
    objc_setAssociatedObject(self, RENNotificationKey, notification, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end






