//
//  UITextView+RuleAddition.m
//
//  Created by Jun on 16/9/7.
//  Copyright © 2016年  All rights reserved.
//

#import "UITextView+RuleAddition.h"
#import <objc/runtime.h>

static char kAssociatedTextViewRuleManagerKey;
static char kAssociatedTextViewDelegateKey;

@implementation UITextView (RuleAddition)
@dynamic maxRuleLength;
@dynamic minRuleLength;
@dynamic ruleType;
@dynamic ruleManagerClassName;

#pragma mark - ClassMethod

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzlingInstanceClassMethod([self class], @selector(setValidateTextViewDelegate:), @selector(setDelegate:));
    });
}

#pragma mark @dynamic proerty

- (void)setMaxRuleLength:(NSInteger)maxRuleLength
{
    objc_setAssociatedObject(self, @selector(maxRuleLength), @(maxRuleLength), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)maxRuleLength
{
    return [(NSNumber *)objc_getAssociatedObject(self, @selector(maxRuleLength)) integerValue];
}

- (void)setMinRuleLength:(NSInteger)minRuleLength
{
    objc_setAssociatedObject(self, @selector(minRuleLength), @(minRuleLength), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)minRuleLength
{
    return [(NSNumber *)objc_getAssociatedObject(self, @selector(minRuleLength)) integerValue];
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
    objc_setAssociatedObject(self, &kAssociatedTextViewRuleManagerKey, manager, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setRuleTextViewDelegate:(id<UITextViewDelegate>)delegate
{
    objc_setAssociatedObject(self, &kAssociatedTextViewDelegateKey, delegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<UITextViewDelegate>)getRuleTextViewDelegate
{
    return objc_getAssociatedObject(self, &kAssociatedTextViewDelegateKey);
}

#pragma mark - public

- (__kindof IQRuleValidationManager *)getRuleManager
{
    return objc_getAssociatedObject(self, &kAssociatedTextViewRuleManagerKey);
}

- (BOOL)validate:(NSString *)str error:(NSError *__autoreleasing *)error
{
    return [[self getRuleManager] validationInputContent:str error:error];
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    id<UITextViewDelegate> textViewDelegate = [textView getRuleTextViewDelegate];
    if ([textViewDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [textViewDelegate textViewShouldBeginEditing:textView];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    id<UITextViewDelegate> textViewDelegate = [textView getRuleTextViewDelegate];
    if ([textViewDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [textViewDelegate textViewShouldEndEditing:textView];
    }
    return [self validate:textView.text error:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    id<UITextViewDelegate> textViewDelegate = [textView getRuleTextViewDelegate];
    if ([textViewDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [textViewDelegate textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    id<UITextViewDelegate> textViewDelegate = [textView getRuleTextViewDelegate];
    if ([textViewDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [textViewDelegate textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *content = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    //删除字符肯定是安全的
    if ([text isEqualToString:@""]) {
        return YES;
    }
    
    if (content.length > textView.maxRuleLength && textView.maxRuleLength > 0) {
        return NO;
    }
    if (content.length < textView.minRuleLength && textView.minRuleLength > 0) {
        return NO;
    }
    
    id<UITextViewDelegate> textViewDelegate = [textView getRuleTextViewDelegate];
    if ([textViewDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [textViewDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }

    return [self validate:content error:nil];
}

- (void)textViewDidChange:(UITextView *)textView
{
    id<UITextViewDelegate> textViewDelegate = [textView getRuleTextViewDelegate];
    if ([textViewDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        return [textViewDelegate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    id<UITextViewDelegate> textViewDelegate = [textView getRuleTextViewDelegate];
    if ([textViewDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        return [textViewDelegate textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    id<UITextViewDelegate> textViewDelegate = [textView getRuleTextViewDelegate];
    if ([textViewDelegate respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        return [textViewDelegate textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    id<UITextViewDelegate> textViewDelegate = [textView getRuleTextViewDelegate];
    if ([textViewDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [textViewDelegate textViewShouldBeginEditing:textView];
    }
    return YES;
}

#pragma mark - swizzled method

- (void)setValidateTextViewDelegate:(id<UITextViewDelegate>)delegate
{
    [self setValidateTextViewDelegate:self];
    [self setRuleTextViewDelegate:delegate];
}

@end
