# RENNotificationCenter

RENNotificationCenter是一款非常小巧轻量的基于`NSNotificationCenter`的封装，用于简化 iOS 开发中的发布订阅模式。
##特性

- 利用iOS动态性实现自动释放通知，当持有类销毁时，自动释放注册通知 
- 使用blcok的方式作为事件触发的回调，简洁明了
- 支持系统的所有通知，并转发userInfo字段
## 例子
```
[self.notification rl_subscribe:UIApplicationDidEnterBackgroundNotification block:^(RENEvent *event) {
NSLog(@"eventName = %@",event.name);
}];

[self.notification rl_subscribe:@"CustomEventName" block:^(RENEvent *event) {
NSLog(@"eventName = %@",event.name);
}];

[self.notification rl_unsubscribe:@"CustomEventName"];
```
## 安装

### CocoaPods

* 在 `Podfile` 里添加以下依赖：

```
pod 'RENNotificationCenter', '~> 0.0.2'
```
* 运行 `pod install` 

###源文件

直接导入源文件。

* 下载[最新代码](https://github.com/REN-LEI/RENNotificationCenter/archive/master.zip)
* 导入 `RENNotificationCenter.h` 和 `RENNotificationCenter.m` 

##感谢
本人通过阅读[Facebook](https://github.com/facebook)开源的[KVOController](https://github.com/facebook/KVOController)源码后，基于其思想实现了RENNotificationCenter
## License

基于 MIT 协议
