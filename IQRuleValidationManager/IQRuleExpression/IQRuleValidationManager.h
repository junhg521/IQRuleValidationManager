//
//  IQRuleValidationManager.h
//  WandaBP
//
//  Created by Jun on 16/9/6.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, IQRuleValidationType)
{
    IQRuleValidationNone = 0,
    IQRuleValidationLengthConstraint,
    IQRuleValidationTextFieldDecimal, //定义为最大两位小数点的正数
    IQRuleValidationTextFieldNumber,  //定义为正整数
};


NS_ASSUME_NONNULL_BEGIN

@protocol IQRuleValidationManager <NSObject>

@required
/**
 *  @brief  提供对应于IQRuleValidationType所处理的类名,继承的子类都必须提供该方法
 *
 *  @param type 定义的处理类型
 *
 *  @return 类名
 */
+ (nonnull NSString *)validationClassNameWithType:(IQRuleValidationType)type;
/**
 *  @brief  提供对应于IQRuleValidationType所处理的正则表达式,继承的子类都必须提供该方法
 *
 *  @param type 定义的处理类型
 *
 *  @return 返回正则表达式字符串
 */
- (nonnull NSString *)regularExpressionWithType:(IQRuleValidationType)type;

@optional

@end

@interface IQRuleValidationManager : NSObject<IQRuleValidationManager>

@property (nonatomic, assign, getter=isRuleValidationEnable) BOOL ruleValidationEnable;

/**
 *  @brief  <#Description#>
 *
 *  @param type <#type description#>
 *
 *  @return <#return value description#>
 */
+ (nonnull __kindof IQRuleValidationManager *)ruleValidationManagerWithType:(IQRuleValidationType)type;
/**
 *  @brief  <#Description#>
 *
 *  @param content <#content description#>
 *  @param error   <#error description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)validationInputContent:(NSString *)content error:(NSError * _Nullable __autoreleasing *)error;
@end

NS_ASSUME_NONNULL_END
