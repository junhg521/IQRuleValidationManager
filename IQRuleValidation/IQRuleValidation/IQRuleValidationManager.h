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
    IQRuleValidationNumberWithTwoDecimalPoint, // such as 1.23, 11.23 111.23,1111.23
    IQRuleValidationNumber,                       // such as 1, 11,1111,11111
    IQRuleValidationMobile,                     //
    IQRuleValidationAlphaAndNumber,             // such as a132,abcd1
    IQRuleValidationAlpha,                      // such as Aa, AAa, AAAa
    IQRuleValidationUppercaseAlpha,             // such as A, AA, AAA
    IQRuleValidationLowercaseAlpha,             // such as a, aa, aaa
    IQRuleValidationAlphaAndNumberAndUnderLine, // such a_43, a43, ab
    IQRuleValidationMonthInYear,                // such as 01, 02, 1, 2
    IQRuleValidationDaysInMonth,                // such as 1, 2, 3 ..31
    IQRuleValidationEmail,
};

NS_ASSUME_NONNULL_BEGIN

@protocol IQRuleValidationManagerDelegate <NSObject>

@required
/**
 *  @brief  提供对应于IQRuleValidationType所处理的类名,继承的子类都必须提供该方法
 *
 *  @return 类名
 */
+ (nonnull NSString *)validationClassName;
/**
 *  @brief  提供对应于IQRuleValidationType所处理的正则表达式,继承的子类都必须提供该方法
 *
 *  @return 返回正则表达式字符串
 */
- (nonnull NSString *)regularExpressionWhenChanged;
/**
 *  @brief  提供对应于IQRuleValidationType所处理的正则表达式,继承的子类都必须提供该方法
 *
 *  @return 返回正则表达式字符串
 */
- (nonnull NSString *)regularExpressionWhileEndEditing;

@optional

@end

@interface IQRuleValidationManager : NSObject<IQRuleValidationManagerDelegate>
/**
 *  @brief  实例化IQRuleValidationManager
 *
 *  @param type 参考IQRuleValidationType定义
 *
 *  @return IQRuleValidationManager类及子类
 */
+ (nonnull __kindof IQRuleValidationManager *)ruleValidationManagerWithType:(IQRuleValidationType)type;
/**
 *  @brief  对用户正在输入的内容进行正则表达式判断
 *
 *  @param content UITextField或UITextView的输入内容
 *  @param error   正则表达式判断错误
 *
 *  @return 返回YES表示成功，NO表示失败
 */
- (BOOL)validationInputContentWhenChanged:(NSString *)content error:(NSError * _Nullable __autoreleasing *)error;
/**
 *  @brief  对用户输入完的内容进行正则表达式判断
 *
 *  @param content UITextField或UITextView的输入内容
 *  @param error   正则表达式判断错误
 *
 *  @return 返回YES表示成功，NO表示失败
 */
- (BOOL)validationInputContentWhileEndEditing:(NSString *)content error:(NSError * _Nullable __autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END
