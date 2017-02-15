//
//  IQBasicRuleValidationManager.m
//  
//
//  Created by Jun on 16/9/6.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import "IQBasicRuleValidationManager.h"
#import <objc/runtime.h>

@interface IQBasicRuleValidationManager ()

@property (nonatomic, assign) IQRuleValidationType type;
@end

@implementation IQBasicRuleValidationManager

#pragma mark - ClassMethod

+ (nonnull IQBasicRuleValidationManager *)ruleValidationManagerWithType:(IQRuleValidationType)type
{
    NSString *className = [[self class] validationClassName];
    if (!className) return nil;
  
    IQBasicRuleValidationManager *manager = [[NSClassFromString(className) alloc] init];
    manager.type = type;
    return manager;
}

#pragma mark - public

- (BOOL)validationInputContentWhenChanged:(NSString *)content error:(NSError * _Nullable __autoreleasing *)error
{
    NSString *regularExpression = [self regularExpressionWhenChanged];
    if (regularExpression) {
        return [self validationInputContent:content regularExpression:regularExpression error:error];
    }
    return YES;
}

- (BOOL)validationInputContentWhileEndEditing:(NSString *)content error:(NSError * _Nullable __autoreleasing *)error
{
    NSString *regularExpression = [self regularExpressionWhileEndEditing];
    if (regularExpression) {
        return [self validationInputContent:content regularExpression:regularExpression error:error];
    }
    return YES;
}

#pragma mark - IQRuleValidationManager

+ (NSString *)validationClassName
{
    return NSStringFromClass([self class]);
}

- (NSString *)regularExpressionWhenChanged
{
    NSString *regularExpression = nil;
    switch (self.type) {
        case IQRuleValidationNone:
            break;
        case IQRuleValidationNumberWithTwoDecimalPoint:
            regularExpression = @"^(0|[1-9]\\d*)(\\.[0-9]{0,2})?$";
            break;
        case IQRuleValidationNumber:
            regularExpression = @"^[1-9]\\d*$";
            break;
        case IQRuleValidationMobile:
//            regularExpression = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
            break;
        case IQRuleValidationAlphaAndNumber:
            regularExpression = @"^[a-zA-Z0-9]+$";
            break;
        case IQRuleValidationAlpha:
            regularExpression = @"^[A-Za-z]+$";
            break;
        case IQRuleValidationUppercaseAlpha:
            regularExpression = @"^[A-Z]+$";
            break;
        case IQRuleValidationLowercaseAlpha:
            regularExpression = @"^[a-z]+$";
            break;
        case IQRuleValidationAlphaAndNumberAndUnderLine:
            regularExpression = @"^w+$";
            break;
        case IQRuleValidationMonthInYear:
            regularExpression = @"^(0?[1-9]|1[0-2])$";
            break;
        case IQRuleValidationDaysInMonth:
            regularExpression = @"^((0?[1-9])|((1|2)[0-9])|30|31)$";
            break;
        case IQRuleValidationEmail:
            
            break;
        default:
            break;
    }
    return regularExpression;
}

- (NSString *)regularExpressionWhileEndEditing
{
    NSString *regularExpression = nil;
    switch (self.type) {
        case IQRuleValidationNone:
            break;
        case IQRuleValidationNumberWithTwoDecimalPoint:
            regularExpression = @"^(0|[1-9]\\d*)(\\.[0-9]{1,2})?$";
            break;
        case IQRuleValidationNumber:
            regularExpression = @"^[1-9]\\d*$";
            break;
        case IQRuleValidationMobile:
            regularExpression = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
            break;
        case IQRuleValidationAlphaAndNumber:
            regularExpression = @"^[a-zA-Z0-9]+$";
            break;
        case IQRuleValidationAlpha:
            regularExpression = @"^[A-Za-z]+$";
            break;
        case IQRuleValidationUppercaseAlpha:
            regularExpression = @"^[A-Z]+$";
            break;
        case IQRuleValidationLowercaseAlpha:
            regularExpression = @"^[a-z]+$";
            break;
        case IQRuleValidationAlphaAndNumberAndUnderLine:
            regularExpression = @"^w+$";
            break;
        case IQRuleValidationMonthInYear:
            regularExpression = @"^(0?[1-9]|1[0-2])$";
            break;
        case IQRuleValidationDaysInMonth:
            regularExpression = @"^((0?[1-9])|((1|2)[0-9])|30|31)$";
            break;
        case IQRuleValidationEmail:
            regularExpression = @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$";
            break;
        default:
            break;
    }
    return regularExpression;
}

#pragma Mark - private

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

@end
