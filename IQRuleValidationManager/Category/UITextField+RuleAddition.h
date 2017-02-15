//
//  UITextField+RuleAddition.h
//  
//
//  Created by Jun on 16/9/7.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IQBasicRuleValidationManager.h"

@interface UITextField (RuleAddition)

@property (nonatomic, assign) IBInspectable NSInteger maxRuleLength;
@property (nonatomic, assign) IBInspectable NSInteger minRuleLength;
/**
 *  @brief  默认的处理的规则，它的值在IQRuleValidationType范围内，超过该范围的数据默认不处理
 */
#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSUInteger ruleType;
#else
@property (nonatomic, assign) IQRuleValidationType ruleType;
#endif
/**
 *  @brief  自定义处理规则的类名，如果设置该变量，则ruleType的值将无效
 */
@property (nonatomic, strong) IBInspectable NSString *ruleManagerClassName;

/**
 获取处理UITextField的规则类

 @return IQRuleValidationManager及自定义的子类
 */
- (__kindof IQBasicRuleValidationManager *)getRuleManager;

@end
