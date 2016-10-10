//
//  UITextView+RuleAddition.m
//
//  Created by Jun on 16/9/7.
//  Copyright © 2016年  All rights reserved.
//

#import "UITextView+RuleAddition.h"
#import "IQRuleValidationManager.h"
#import "IQSwizzleUtils.h"
#import <objc/runtime.h>
#import "IQRuleMacro.h"

@implementation UITextView (RuleAddition)
@dynamic maxRuleLength;
@dynamic minRuleLength;
@dynamic ruleType;
@dynamic ruleManagerClassName;

#pragma mark ClassMethod

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textViewShouldBeginEditing:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(validationTextViewShouldBeginEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textViewShouldEndEditing:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(validationTextViewShouldEndEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textViewDidBeginEditing:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(validationTextViewDidBeginEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textView:shouldChangeTextInRange:replacementText:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(validationTextView:shouldChangeTextInRange:replacementText:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textViewDidChange:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(validationTextViewDidChange:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textViewDidChangeSelection:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(validationTextViewDidChangeSelection:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textView:shouldInteractWithURL:inRange:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(validationTextView:shouldInteractWithURL:inRange:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(validationTextView:shouldInteractWithTextAttachment:inRange:)];
        
    });
}

#pragma mark @dynamic proerty

- (void)setMaxRuleLength:(NSInteger)maxRuleLength
{
    [self willChangeValueForKey:@"maxRuleLength"];
    objc_setAssociatedObject(self, @selector(maxRuleLength), @(maxRuleLength), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"maxRuleLength"];
}

- (NSInteger)maxRuleLength
{
    return [(NSNumber *)objc_getAssociatedObject(self, @selector(maxRuleLength)) integerValue];
}

- (void)setMinRuleLength:(NSInteger)minRuleLength
{
    [self willChangeValueForKey:@"minRuleLength"];
    objc_setAssociatedObject(self, @selector(minRuleLength), @(minRuleLength), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"minRuleLength"];
}

- (NSInteger)minRuleLength
{
    return [(NSNumber *)objc_getAssociatedObject(self, @selector(minRuleLength)) integerValue];
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

#pragma mark - swizzled UITextView Method

- (BOOL)validationTextViewShouldBeginEditing:(UITextView *)textView
{
    DLog()
    BOOL editing = [self validationTextViewShouldBeginEditing:textView];
    BOOL ruleEditing = [self textViewShouldBeginEditing:textView];
    return editing && ruleEditing;
}

- (BOOL)validationTextViewShouldEndEditing:(UITextView *)textView
{
    DLog()
    BOOL editing = [self validationTextViewShouldEndEditing:textView];
    BOOL ruleEditing = [self textViewShouldEndEditing:textView];
    return editing && ruleEditing;
}

- (void)validationTextViewDidBeginEditing:(UITextView *)textView
{
    DLog()
    [self validationTextViewDidBeginEditing:textView];
    [self textViewDidBeginEditing:textView];
}

- (void)validationTextViewDidEndEditing:(UITextView *)textView
{
    DLog()
    [self validationTextViewDidEndEditing:textView];
    [self textViewDidEndEditing:textView];
}

- (BOOL)validationTextView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    DLog()
    BOOL editing = [self validationTextView:textView shouldChangeTextInRange:range replacementText:text];
    BOOL ruleEditing = [self textView:textView shouldChangeTextInRange:range replacementText:text];
    return editing && ruleEditing;
}

- (void)validationTextViewDidChange:(UITextView *)textView
{
    DLog()
    [self validationTextViewDidChange:textView];
    [self textViewDidChange:textView];
}

- (void)validationTextViewDidChangeSelection:(UITextView *)textView
{
    DLog()
    [self validationTextViewDidChangeSelection:textView];
    [self textViewDidChangeSelection:textView];
}

- (BOOL)validationTextView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    DLog()
    BOOL editing = [self validationTextView:textView shouldInteractWithURL:URL inRange:characterRange];
    BOOL ruleEditing = [self textView:textView shouldInteractWithURL:URL inRange:characterRange];
    return editing && ruleEditing;
}

- (BOOL)validationTextView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    DLog()
    BOOL editing = [self validationTextView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    BOOL ruleEditing = [self textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    return editing && ruleEditing;
}

#pragma mark - handle

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ((textView.text.length > 0 && textView.text.length < textView.minRuleLength) || textView.text.length > textView.maxRuleLength) {
        return NO;
    }
    
    __kindof IQRuleValidationManager *manager = [self getRuleManager];
    if (manager && textView.text.length > 0) {
        NSError *error = nil;
        return [manager validationInputContentWhileEndEditing:textView.text error:&error];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //删除字符肯定是安全的
    if ([text isEqualToString:@""]) {
        return YES;
    }
    
    __kindof IQRuleValidationManager *manager = [self getRuleManager];
    if (manager) {
        NSError *error = nil;
        return [manager validationInputContentWhenChanged:[textView.text stringByReplacingCharactersInRange:range withString:text]
                                                    error:&error];
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    return YES;
}

@end
