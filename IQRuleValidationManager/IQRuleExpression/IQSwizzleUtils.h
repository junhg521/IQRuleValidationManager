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
 *  @brief  <#Description#>
 *
 *  @param protocolName     <#protocolName description#>
 *  @param originalSelector <#originalSelector description#>
 *  @param swizzledClass    <#swizzledClass description#>
 *  @param swizzledSelector <#swizzledSelector description#>
 */
+ (void)lookforSwizzledProtocolName:( const char * _Nonnull )protocolName originalSelector:(_Nonnull SEL)originalSelector  swizzledClass:(_Nonnull Class)swizzledClass swizzledSelector:(_Nonnull SEL) swizzledSelector;

@end

NS_ASSUME_NONNULL_END
