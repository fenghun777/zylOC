//
//  ZyRuntime.m
//  zylOC
//
//  Created by yy z on 2018/3/28.
//  Copyright © 2018年 zly. All rights reserved.
//

#import "ZyRuntime.h"
#import <objc/runtime.h>

//message.h：主要包含了一些向对象发送消息的函数，这是OC对象方法调用的底层实现。
//runtime.h：运行时最重要的文件，其中包含了对运行时进行操作的方法。


@implementation ZyRuntime

#pragma mark  替换系统方法
//对对象进行操作的方法一般以object_开头
//对类进行操作的方法一般以class_开头
//对类或对象的方法进行操作的方法一般以method_开头
//对成员变量进行操作的方法一般以ivar_开头
//对属性进行操作的方法一般以property_开头
//对协议进行操作的方法一般以protocol_开头
+ (void)zy_ReplaceClassMethod:(Class)class originalSelector:(SEL)originalSelector otherSelector:(SEL)otherSelector {
    
    // 1.得到系统的方法  类方法
    Method originalMethod = class_getClassMethod(class, originalSelector);
    // 2.得到要交换的方法（自己处理过得方法）  类方法
    Method otherMethod = class_getClassMethod(class, otherSelector);
    
    // 3.进行方法交换(就是表面上调用的是系统的方法 实际上调用的是交换后的方法的实现) (注意交换的是 类方法 即工厂方法)
    method_exchangeImplementations(originalMethod, otherMethod);
}


+ (void)zy_ReplaceInstanceMethod:(Class)class originalSelector:(SEL)originalSelector otherSelector:(SEL)otherSelector {
    
    // 1.得到系统的方法 对象方法
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    // 2.得到要交换的方法（自己处理过得方法） 对象方法
    Method otherMethod = class_getInstanceMethod(class, otherSelector);
    
    // 3.进行方法交换(就是表面上调用的是系统的方法 实际上调用的是交换后的方法的实现) (注意交换的是 对象方法 即实例方法)
    method_exchangeImplementations(originalMethod, otherMethod);
}


#pragma mark 扩展属性（Associative）
//objective-c有两个扩展机制：category和associative。通过category来扩展方法，但是它有个很大的局限性，不能扩展属性。于是，就有了专门用来扩展属性的机制：associative。

//objc_setAssociatedObject 用于给对象添加关联对象，传入 nil 则可以移除已有的关联对象
//objc_getAssociatedObject 用于获取关联对象
//objc_removeAssociatedObjects 用于移除一个对象的所有关联对象
//注：objc_removeAssociatedObjects 函数我们一般是用不上的，因为这个函数会移除一个对象的所有关联对象，将该对象恢复成“原始”状态。这样做就很有可能把别人添加的关联对象也一并移除，这并不是我们所希望的。所以一般的做法是通过给 objc_setAssociatedObject 函数传入 nil 来移除某个已有的关联对象。

//object（源对象）: The source object for the association.
//key（关键字）: The key for the association.
//value（关联的对象） :The value to associate with the key key for object. Pass nil to clear an existing association.
//policy（关联策略） :The policy for the association. For possible values, see “Associative Object Behaviors.”























































@end
