//
//  IQRuleValidationManager.m
//  
//
//  Created by Jun on 16/9/6.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import "IQRuleValidationManager.h"
#import <objc/runtime.h>

@interface IQRuleValidationManager ()

@property (nonatomic, assign) IQRuleValidationType type;
@end

@implementation IQRuleValidationManager

#pragma mark - ClassMethod

+ (nonnull IQRuleValidationManager *)ruleValidationManagerWithType:(IQRuleValidationType)type
{
    NSString *className = [[self class] validationClassName];
    if (!className) return nil;
  
    IQRuleValidationManager *manager = [[NSClassFromString(className) alloc] init];
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
    return NSStringFromClass([IQRuleValidationManager class]);
}

- (NSString *)regularExpressionWhenChanged
{
    NSString *regularExpression = nil;
    switch (self.type) {
        case IQRuleValidationNone:
            break;
            
        case IQRuleValidationPositiveWithTwoDecimalPoint:
            regularExpression = @"^(0|[1-9]\\d*)(\\.[0-9]{0,2})?$";
            break;
            
        case IQRuleValidationPositive:
            regularExpression = @"^[1-9]\\d*$";
            break;
            
        case IQRuleValidationMobile:
            regularExpression = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
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
            
        case IQRuleValidationPositiveWithTwoDecimalPoint:
            regularExpression = @"^(0|[1-9]\\d*)(\\.[0-9]{1,2})?$";
            break;
            
        case IQRuleValidationPositive:
            regularExpression = @"^[1-9]\\d*$";
            break;
            
        case IQRuleValidationMobile:
            regularExpression = @"^1(3[0-9]|4[57]|5[0-35-9]|7[01678]|8[0-9])\\d{8}$";
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
