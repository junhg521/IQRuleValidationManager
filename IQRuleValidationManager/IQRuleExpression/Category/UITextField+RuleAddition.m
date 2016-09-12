//
//  UITextField+RuleAddition.m 
//
//  Created by Jun on 16/9/7.
//  Copyright © 2016年  All rights reserved.
//

#import "UITextField+RuleAddition.h"
#import "IQRuleValidationManager.h"
#import "IQSwizzleUtils.h"
#import "UITextField+RuleOperation.h"
#import <objc/runtime.h>

static char kAssociatedTextFieldRuleManagerKey;

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
    objc_setAssociatedObject(self, @selector(maxRuleLength), @(maxRuleLength), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)maxRuleLength
{
    NSNumber *length = objc_getAssociatedObject(self, @selector(maxRuleLength));
    if (!length) return 0;
    return length.integerValue;
}

- (void)setMinRuleLength:(NSInteger)minRuleLength
{
    objc_setAssociatedObject(self, @selector(minRuleLength), @(minRuleLength), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)minRuleLength
{
    NSNumber *length = objc_getAssociatedObject(self, @selector(minRuleLength));
    if (!length) return 0;
    return length.integerValue;
}

- (void)setRuleType:(IQRuleValidationType)ruleType
{
    objc_setAssociatedObject(self, @selector(ruleType), @(ruleType), OBJC_ASSOCIATION_ASSIGN);
    __kindof IQRuleValidationManager *manager = [IQRuleValidationManager ruleValidationManagerWithType:ruleType];
    if (manager) {
        [self setRuleManager:manager];
    }
}

- (IQRuleValidationType)ruleType
{
    return [(NSNumber *)objc_getAssociatedObject(self, @selector(ruleType)) integerValue];
}

- (void)setRuleManagerClassName:(NSString *)ruleManagerClassName
{
    objc_setAssociatedObject(self, @selector(ruleManagerClassName), ruleManagerClassName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    __kindof IQRuleValidationManager *manager = [[NSClassFromString(ruleManagerClassName) alloc] init];
    [self setRuleManager:manager];
}

- (NSString *)ruleManagerClassName
{
    return objc_getAssociatedObject(self, @selector(ruleManagerClassName));
}

#pragma mark - private

- (void)setRuleManager:(__kindof IQRuleValidationManager *)manager
{
    objc_setAssociatedObject(self, &kAssociatedTextFieldRuleManagerKey, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - public

- (__kindof IQRuleValidationManager *)getRuleManager
{
    return objc_getAssociatedObject(self, &kAssociatedTextFieldRuleManagerKey);
}

- (BOOL)validateWhenChanged:(NSString *)str error:(NSError *__autoreleasing *)error
{
    __kindof IQRuleValidationManager *manager = [self getRuleManager];
    if (manager) {
        return [manager validationInputContentWhenChanged:str error:error];
    }
    return YES;
}

- (BOOL)validateWhileEndEditing:(NSString *)str error:(NSError *__autoreleasing *)error
{
    __kindof IQRuleValidationManager *manager = [self getRuleManager];
    if (manager) {
        return [manager validationInputContentWhileEndEditing:str error:error];
    }
    return YES;
}

#pragma mark - swizzled UITextField method

- (BOOL)ruleValidationTextFieldShouldBeginEditing:(UITextField *)textField
{
    BOOL editing =  [self ruleValidationTextFieldShouldBeginEditing:textField];
    BOOL ruleEditing = [textField textFieldShouldBeginEditing:textField];
    return editing && ruleEditing;
}

- (void)ruleValidationTextFieldDidBeginEditing:(UITextField *)textField
{
    [self ruleValidationTextFieldDidBeginEditing:textField];
    [textField textFieldDidBeginEditing:textField];
}

- (BOOL)ruleValidationTextFieldShouldEndEditing:(UITextField *)textField
{
    BOOL editing = [self ruleValidationTextFieldShouldEndEditing:textField];
    BOOL ruleEditing = [textField textFieldShouldEndEditing:textField];
    return editing && ruleEditing;
}

- (void)ruleValidationTextFieldDidEndEditing:(UITextField *)textField
{
    [self ruleValidationTextFieldDidEndEditing:textField];
    [textField textFieldDidEndEditing:textField];
}

- (BOOL)ruleValidationTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL editing = [self ruleValidationTextField:textField shouldChangeCharactersInRange:range replacementString:string];
    BOOL ruleEditing = [textField textField:textField shouldChangeCharactersInRange:range replacementString:string];
    return editing && ruleEditing;
}

- (BOOL)ruleValidationTextFieldShouldClear:(UITextField *)textField
{
    BOOL editing = [self ruleValidationTextFieldShouldClear:textField];
    BOOL ruleEditing = [textField textFieldShouldClear:textField];
    return editing && ruleEditing;
}

- (BOOL)ruleValidationTextFieldShouldReturn:(UITextField *)textField
{
    BOOL editing = [self ruleValidationTextFieldShouldReturn:textField];
    BOOL ruleEditing = [textField textFieldShouldReturn:textField];
    return editing && ruleEditing;
}

@end
