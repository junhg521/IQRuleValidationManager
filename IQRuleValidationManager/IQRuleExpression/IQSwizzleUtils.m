//
//  IQSwizzleUtils.m
//
//  Created by Jun on 16/9/12.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import "IQSwizzleUtils.h"
#import "IQIndirectlyImplementProtocolManager.h"
#import <objc/runtime.h>

@implementation IQSwizzleUtils

+ (void)swizzlingInstanceMethod:(_Nonnull Class)originalClass originalSelector:(_Nonnull SEL)originalSelector swizzledClass:(_Nonnull Class)swizzledClass swizzledSelector:(_Nonnull SEL)swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    
    if (!originalMethod) {
        // 对于originalClass未能实现的协议，将其originalSelector的指针指向IQIndirectlyImplementProtocolManager所对应的方法
        Method indirectlyMethod = class_getInstanceMethod([IQIndirectlyImplementProtocolManager class], originalSelector);
        BOOL addMethod = class_addMethod(originalClass, originalSelector, method_getImplementation(indirectlyMethod), method_getTypeEncoding(indirectlyMethod));
        if (!addMethod) {
            return;
        }
        
        originalMethod = class_getInstanceMethod(originalClass, originalSelector);
        if (!originalMethod) {
            return;
        }
    }
    
    BOOL registerMethod = class_addMethod(originalClass, swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (!registerMethod) {
        return;
    }
    
    swizzledMethod = class_getInstanceMethod(originalClass, swizzledSelector);
    if (!swizzledMethod) {
        return;
    }
    
    BOOL didAddMethod = class_addMethod(originalClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(originalClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)lookforOriginalClassImplementProtocol:(Protocol *)protocol originalSelector:(_Nonnull SEL) originalSelector swizzledClass:(_Nonnull Class)swizzledClass swizzledSelector:(_Nonnull SEL)swizzledSelector
{
    int classesCount = objc_getClassList(NULL, 0);
    Class *classes = (Class *)malloc(classesCount * sizeof(Class));
    objc_getClassList(classes, classesCount);
    
    for (NSInteger i=0; i<classesCount; i++) {
        @autoreleasepool {
            Class conformClass = classes[i];
            if ([NSStringFromClass(conformClass) isEqualToString:@"IQIndirectlyImplementProtocolManager"]
                ) {
                continue;
            }
            while (conformClass != Nil) {
                if (class_conformsToProtocol(conformClass, protocol)) {
                    break;
                }
                conformClass = class_getSuperclass(conformClass);
            }
            
            if ([NSStringFromClass(conformClass) hasPrefix:@"UI"] || [NSStringFromClass(conformClass) hasPrefix:@"_UI"]) {
                continue;
            }
            if (conformClass != Nil) {
                unsigned int methodsCount = 0;
                class_copyMethodList(conformClass, &methodsCount);
                for( unsigned methodIndex = 0; methodIndex < methodsCount; methodIndex++) {
                    @autoreleasepool {
                        [IQSwizzleUtils swizzlingInstanceMethod:conformClass
                                               originalSelector:originalSelector
                                                  swizzledClass:swizzledClass
                                               swizzledSelector:swizzledSelector];
                    }
                }
            }
        }
    }
    if (classes) {
        free(classes);
        classes = nil;
    }
}

+ (void)lookforSwizzledProtocolName:( const char * _Nonnull )protocolName originalSelector:(_Nonnull SEL)originalSelector  swizzledClass:(_Nonnull Class)swizzledClass swizzledSelector:(_Nonnull SEL) swizzledSelector
{
    if (protocolName && objc_getProtocol(protocolName)) {
        [IQSwizzleUtils lookforOriginalClassImplementProtocol:objc_getProtocol(protocolName)
                                              originalSelector:originalSelector
                                                         swizzledClass:swizzledClass
                                                      swizzledSelector:swizzledSelector];
    }
}

@end
