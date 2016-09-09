//
//  UITextField+RuleAddition.m 
//
//  Created by Jun on 16/9/7.
//  Copyright © 2016年  All rights reserved.
//

#import "UITextField+RuleAddition.h"
#import "IQRuleValidationManager.h"
#import <objc/runtime.h>

static char kAssociatedTextFieldRuleManagerKey;
static char kAssociatedTextFieldDelegateKey;

@implementation UITextField (RuleAddition)
@dynamic maxRuleLength;
@dynamic minRuleLength;
@dynamic ruleType;
@dynamic ruleManagerClassName;

#pragma mark - ClassMethod

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzlingInstanceClassMethod([self class], @selector(setValidateTextFieldDelegate:), @selector(setDelegate:));
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

- (void)setRuleTextFieldDelegate:(id<UITextFieldDelegate>)delegate
{
    objc_setAssociatedObject(self, &kAssociatedTextFieldDelegateKey, delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<UITextFieldDelegate>)getRuleTextFieldDelegate
{
    return objc_getAssociatedObject(self, &kAssociatedTextFieldDelegateKey);
}

#pragma mark - public

- (__kindof IQRuleValidationManager *)getRuleManager
{
    return objc_getAssociatedObject(self, &kAssociatedTextFieldRuleManagerKey);
}


- (BOOL)validate:(NSString *)str error:(NSError *__autoreleasing *)error
{
    return [[self getRuleManager] validationInputContent:str error:error];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    id<UITextFieldDelegate> textFieldDelegate = [self getRuleTextFieldDelegate];
    if ([textFieldDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)] ) {
        return [textFieldDelegate textFieldShouldBeginEditing:textField];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    id<UITextFieldDelegate> textFieldDelegate = [self getRuleTextFieldDelegate];
    if ([textFieldDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)] ) {
        [textFieldDelegate textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    id<UITextFieldDelegate> textFieldDelegate = [self getRuleTextFieldDelegate];
    if ([textFieldDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)] ) {
        return [textFieldDelegate textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    id<UITextFieldDelegate> textFieldDelegate = [self getRuleTextFieldDelegate];
    if ([textFieldDelegate respondsToSelector:@selector(textFieldDidEndEditing:)] ) {
        return [textFieldDelegate textFieldDidEndEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //删除字符肯定是安全的
    if ([string isEqualToString:@""]) {
        return YES;
    }
    NSString *content = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (content.length > textField.maxRuleLength && textField.maxRuleLength > 0) {
        return NO;
    }
    if (content.length < textField.minRuleLength && textField.minRuleLength > 0) {
        return NO;
    }
    
    id<UITextFieldDelegate> textFieldDelegate = [self getRuleTextFieldDelegate];
    if ([textFieldDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)] ) {
        return [textFieldDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }

    return [self validate:content error:nil];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    id<UITextFieldDelegate> textFieldDelegate = [self getRuleTextFieldDelegate];
    if ([textFieldDelegate respondsToSelector:@selector(textFieldShouldClear:)] ) {
        return [textFieldDelegate textFieldShouldClear:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    id<UITextFieldDelegate> textFieldDelegate = [self getRuleTextFieldDelegate];
    if ([textFieldDelegate respondsToSelector:@selector(textFieldShouldReturn:)] ) {
        return [textFieldDelegate textFieldShouldReturn:textField];
    }
    return [self validate:textField.text error:nil];
}

#pragma mark - swizzled method

- (void)setValidateTextFieldDelegate:(id<UITextFieldDelegate>)delegate
{
    [self setValidateTextFieldDelegate:self];
    [self setRuleTextFieldDelegate:delegate];
}

@end
