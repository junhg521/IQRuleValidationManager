//
//  UITextField+RuleAddition.m 
//
//  Created by Jun on 16/9/7.
//  Copyright © 2016年  All rights reserved.
//

#import "UITextField+RuleAddition.h"
#import "IQRuleValidationManager.h"
#import "IQSwizzleUtils.h"
#import "IQRuleMacro.h"
#import <objc/runtime.h>

@implementation UITextField (RuleAddition)
@dynamic maxRuleLength;
@dynamic minRuleLength;
@dynamic ruleType;
@dynamic ruleManagerClassName;

#pragma mark ClassMethod

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textFieldShouldBeginEditing:)
                                      swizzledClass:[UITextField class]
                                   swizzledSelector:@selector(validationTextFieldShouldBeginEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textFieldDidBeginEditing:)
                                      swizzledClass:[UITextField class]
                                   swizzledSelector:@selector(validationTextFieldDidBeginEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textFieldShouldEndEditing:)
                                      swizzledClass:[UITextField class]
                                   swizzledSelector:@selector(validationTextFieldShouldEndEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textFieldDidEndEditing:)
                                      swizzledClass:[UITextField class]
                                   swizzledSelector:@selector(validationTextFieldDidEndEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)
                                      swizzledClass:[UITextField class]
                                   swizzledSelector:@selector(validationTextField:shouldChangeCharactersInRange:replacementString:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textFieldShouldClear:)
                                      swizzledClass:[UITextField class]
                                   swizzledSelector:@selector(validationTextFieldShouldClear:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textFieldShouldReturn:)
                                      swizzledClass:[UITextField class]
                                   swizzledSelector:@selector(validationTextFieldShouldReturn:)];

    });
}

- (void)dealloc
{
    DLog()
}

#pragma mark - @dynamic proerty

- (void)setMaxRuleLength:(NSInteger)maxRuleLength
{
    [self willChangeValueForKey:@"maxRuleLength"];
    objc_setAssociatedObject(self, @selector(maxRuleLength), @(maxRuleLength), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"maxRuleLength"];
}

- (NSInteger)maxRuleLength
{
    NSNumber *length = objc_getAssociatedObject(self, @selector(maxRuleLength));
    if (!length) return 0;
    return length.integerValue;
}

- (void)setMinRuleLength:(NSInteger)minRuleLength
{
    [self willChangeValueForKey:@"minRuleLength"];
    objc_setAssociatedObject(self, @selector(minRuleLength), @(minRuleLength), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"minRuleLength"];
}

- (NSInteger)minRuleLength
{
    NSNumber *length = objc_getAssociatedObject(self, @selector(minRuleLength));
    if (!length) return 0;
    return length.integerValue;
}

- (void)setRuleType:(IQRuleValidationType)ruleType
{
    [self willChangeValueForKey:@"ruleType"];
    objc_setAssociatedObject(self, @selector(ruleType), @(ruleType), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"ruleType"];
}

- (IQRuleValidationType)ruleType
{
    return [(NSNumber *)objc_getAssociatedObject(self, @selector(ruleType)) integerValue];
}

- (void)setRuleManagerClassName:(NSString *)ruleManagerClassName
{
    [self willChangeValueForKey:@"ruleManagerClassName"];
    objc_setAssociatedObject(self, @selector(ruleManagerClassName), ruleManagerClassName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"ruleManagerClassName"];
}

- (NSString *)ruleManagerClassName
{
    return objc_getAssociatedObject(self, @selector(ruleManagerClassName));
}

#pragma mark - public

- (__kindof IQRuleValidationManager *)getRuleManager
{
    NSString *className = [self ruleManagerClassName];
    if ([className length]) {
        id manager = [[NSClassFromString(className) alloc] init];
        if ([manager isKindOfClass:[IQRuleValidationManager class]]) {
            return manager;
        }
        return nil;
    }
    else {
        IQRuleValidationManager *manager = [IQRuleValidationManager ruleValidationManagerWithType:[self ruleType]];
        return manager;
    }
}

#pragma mark - swizzled UITextField method

- (BOOL)validationTextFieldShouldBeginEditing:(UITextField *)textField
{
    DLog()
    BOOL editing =  [self validationTextFieldShouldBeginEditing:textField];
    BOOL ruleEditing = [self textFieldShouldBeginEditing:textField];
    return editing && ruleEditing;
}

- (void)validationTextFieldDidBeginEditing:(UITextField *)textField
{
    DLog()
    [self validationTextFieldDidBeginEditing:textField];
    [self textFieldDidBeginEditing:textField];
}

- (BOOL)validationTextFieldShouldEndEditing:(UITextField *)textField
{
    DLog()
    BOOL editing = [self validationTextFieldShouldEndEditing:textField];
    BOOL ruleEditing = [self textFieldShouldEndEditing:textField];
    return editing && ruleEditing;
}

- (void)validationTextFieldDidEndEditing:(UITextField *)textField
{
    DLog()
    [self validationTextFieldDidEndEditing:textField];
    [self textFieldDidEndEditing:textField];
}

- (BOOL)validationTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    DLog();
    BOOL editing = [self validationTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    BOOL ruleEditing = [self textField:textField shouldChangeCharactersInRange:range replacementString:string];
    return editing && ruleEditing;
}

- (BOOL)validationTextFieldShouldClear:(UITextField *)textField
{
    DLog()
    BOOL editing = [self validationTextFieldShouldClear:textField];
    BOOL ruleEditing = [self textFieldShouldClear:textField];
    return editing && ruleEditing;
}

- (BOOL)validationTextFieldShouldReturn:(UITextField *)textField
{
    DLog()
    BOOL editing = [self validationTextFieldShouldReturn:textField];
    BOOL ruleEditing = [self textFieldShouldReturn:textField];
    return editing && ruleEditing;
}

#pragma mark - handle

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return [self textFieldShouldReturn:textField];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //删除字符肯定是安全的
    if ([string isEqualToString:@""]) {
        return YES;
    }
    
    __kindof IQRuleValidationManager *manager = [self getRuleManager];
    if (manager) {
        NSError *error = nil;
        return [manager validationInputContentWhenChanged:[textField.text stringByReplacingCharactersInRange:range withString:string]
                                                    error:&error];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ((textField.text.length > 0 && textField.text.length < textField.minRuleLength) || textField.text.length> textField.maxRuleLength) {
        return NO;
    }
    
    __kindof IQRuleValidationManager *manager = [self getRuleManager];
    if (manager && textField.text.length > 0) {
        NSError *error = nil;
        return [manager validationInputContentWhileEndEditing:textField.text error:&error];
    }
    return YES;
}

@end
