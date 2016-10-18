//
//  IQSwizzleUtils.h
//
//  Created by Jun on 16/9/12.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IQSwizzleUtils : NSObject
/**
 *  @brief  替换所有遵循protocolName协议的方法, 去除对系统类型方法进行替换（如：UI,_UI, CN, AB开头的系统类），所以工程命令时请不要使用改
 *  类型的开头
 *
 *  @param protocolName     协议名
 *  @param originalSelector 协议的 old selector
 *  @param swizzledClass    替换的类
 *  @param swizzledSelector 替换的selector
 */
+ (void)lookforSwizzledProtocolName:( const char * _Nonnull )protocolName originalSelector:(_Nonnull SEL)originalSelector  swizzledClass:(_Nonnull Class)swizzledClass swizzledSelector:(_Nonnull SEL) swizzledSelector;



@end

NS_ASSUME_NONNULL_END
