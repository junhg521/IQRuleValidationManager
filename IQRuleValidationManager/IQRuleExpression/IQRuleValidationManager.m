//
//  IQRuleValidationManager.m
//  
//
//  Created by Jun on 16/9/6.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import "IQRuleValidationManager.h"
#import "IQIndirectlyImplementProtocolManager.h"
#import "UITextField+RuleOperation.h"

#import <objc/runtime.h>

@interface IQRuleValidationManager ()

@property (nonatomic, assign) IQRuleValidationType type;
@end

@implementation IQRuleValidationManager

#pragma mark - ClassMethod

+ (nonnull IQRuleValidationManager *)ruleValidationManagerWithType:(IQRuleValidationType)type
{
    NSString *className = [[self class] validationClassNameWithType:type];
    if (className) {
        IQRuleValidationManager *manager = [[NSClassFromString(className) alloc] init];
        manager.type = type;
        return manager;
    }
    return nil;
}

#pragma mark - public

- (BOOL)validationInputContent:(NSString *)content error:(NSError * _Nullable __autoreleasing *)error
{
    NSString *regularExpression = [self regularExpressionWithType:self.type];
    if (regularExpression) {
        return [self validationInputContent:content regularExpression:regularExpression error:error];
    }
    return YES;
}

#pragma mark - IQRuleValidationManager

+ (NSString *)validationClassNameWithType:(IQRuleValidationType)type
{
    NSString *className = nil;
    switch (type) {
        case IQRuleValidationLengthConstraint:
        case IQRuleValidationTextFieldDecimal:
        case IQRuleValidationTextFieldNumber:
            className = NSStringFromClass([IQRuleValidationManager class]);
            break;
        default:
            break;
    }
    return className;
}

- (NSString *)regularExpressionWithType:(IQRuleValidationType)type
{
    NSString *regularExpression = nil;
    switch (self.type) {
        case IQRuleValidationNone:
            break;
            
        case IQRuleValidationLengthConstraint:
            
            break;
        case IQRuleValidationTextFieldDecimal:
            regularExpression = @"^(0|[1-9]\\d*)(\\.[0-9]{0,2})?$";
            break;
            
        case IQRuleValidationTextFieldNumber:
            regularExpression = @"^[1-9]\\d*$";
            break;
            
        default:
            break;
    }
    return regularExpression;
}

- (BOOL)validationInputContent:(NSString *)content regularExpression:(NSString *)regularExpression error:(NSError * _Nullable __autoreleasing *)error
{
//    NSString *pattern = [NSRegularExpression escapedPatternForString:regularExpression];
    NSRegularExpression *regularExpress = [NSRegularExpression regularExpressionWithPattern:regularExpression
                                                                                    options:NSRegularExpressionCaseInsensitive
                                                                                      error:error];
    NSRange range = [regularExpress rangeOfFirstMatchInString:content options:0 range:NSMakeRange(0, [content length])];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}

#pragma mark - Property

- (void)setRuleValidationEnable:(BOOL)ruleValidationEnable
{
    _ruleValidationEnable = ruleValidationEnable;
}

@end
