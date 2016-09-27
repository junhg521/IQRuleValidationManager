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
#import "UITextField+RuleOperation.h"
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
                                   swizzledSelector:@selector(ruleValidationTextFieldShouldBeginEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textFieldDidBeginEditing:)
                                      swizzledClass:[UITextField class]
                                   swizzledSelector:@selector(ruleValidationTextFieldDidBeginEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textFieldShouldEndEditing:)
                                      swizzledClass:[UITextField class]
                                   swizzledSelector:@selector(ruleValidationTextFieldShouldEndEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textFieldDidEndEditing:)
                                      swizzledClass:[UITextField class]
                                   swizzledSelector:@selector(ruleValidationTextFieldDidEndEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)
                                      swizzledClass:[UITextField class]
                                   swizzledSelector:@selector(ruleValidationTextField:shouldChangeCharactersInRange:replacementString:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textFieldShouldClear:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(ruleValidationTextFieldShouldClear:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextFieldDelegate"
                                   originalSelector:@selector(textFieldShouldReturn:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(ruleValidationTextFieldShouldReturn:)];

    });
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
    if ([className length] && [[className class] isKindOfClass:[IQRuleValidationManager class]]) {
        IQRuleValidationManager *manager = [[[className class] alloc] init];
        return manager;
    }
    else {
        IQRuleValidationManager *manager = [IQRuleValidationManager ruleValidationManagerWithType:[self ruleType]];
        return manager;
    }
}

#pragma mark - swizzled UITextField method

- (BOOL)ruleValidationTextFieldShouldBeginEditing:(UITextField *)textField
{
    DLog()
    BOOL editing =  [self ruleValidationTextFieldShouldBeginEditing:textField];
    BOOL ruleEditing = [textField textFieldShouldBeginEditing:textField];
    return editing && ruleEditing;
}

- (void)ruleValidationTextFieldDidBeginEditing:(UITextField *)textField
{
    DLog()
    [self ruleValidationTextFieldDidBeginEditing:textField];
    [textField textFieldDidBeginEditing:textField];
}

- (BOOL)ruleValidationTextFieldShouldEndEditing:(UITextField *)textField
{
    DLog()
    BOOL editing = [self ruleValidationTextFieldShouldEndEditing:textField];
    BOOL ruleEditing = [textField textFieldShouldEndEditing:textField];
    return editing && ruleEditing;
}

- (void)ruleValidationTextFieldDidEndEditing:(UITextField *)textField
{
    DLog()
    [self ruleValidationTextFieldDidEndEditing:textField];
    [textField textFieldDidEndEditing:textField];
}

- (BOOL)ruleValidationTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    DLog();
    BOOL editing = [self ruleValidationTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    BOOL ruleEditing = [textField textField:textField shouldChangeCharactersInRange:range replacementString:string];
    return editing && ruleEditing;
}

- (BOOL)ruleValidationTextFieldShouldClear:(UITextField *)textField
{
    DLog()
    BOOL editing = [self ruleValidationTextFieldShouldClear:textField];
    BOOL ruleEditing = [textField textFieldShouldClear:textField];
    return editing && ruleEditing;
}

- (BOOL)ruleValidationTextFieldShouldReturn:(UITextField *)textField
{
    DLog()
    BOOL editing = [self ruleValidationTextFieldShouldReturn:textField];
    BOOL ruleEditing = [textField textFieldShouldReturn:textField];
    return editing && ruleEditing;
}

@end
