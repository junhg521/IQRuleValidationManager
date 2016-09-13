//
//  UITextView+RuleAddition.m
//
//  Created by Jun on 16/9/7.
//  Copyright © 2016年  All rights reserved.
//

#import "UITextView+RuleAddition.h"
#import "IQRuleValidationManager.h"
#import "IQSwizzleUtils.h"
#import "UITextView+RuleOperation.h"
#import <objc/runtime.h>

static char kAssociatedTextViewRuleManagerKey;

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
                                   swizzledSelector:@selector(ruleValidationTextViewShouldBeginEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textViewShouldEndEditing:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(ruleValidationTextViewShouldEndEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textViewDidBeginEditing:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(ruleValidationTextViewDidBeginEditing:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textView:shouldChangeTextInRange:replacementText:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(ruleValidationTextView:shouldChangeTextInRange:replacementText:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textViewDidChange:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(ruleValidationTextViewDidChange:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textViewDidChangeSelection:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(ruleValidationTextViewDidChangeSelection:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textView:shouldInteractWithURL:inRange:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(ruleValidationTextView:shouldInteractWithURL:inRange:)];
        [IQSwizzleUtils lookforSwizzledProtocolName:"UITextViewDelegate"
                                   originalSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)
                                      swizzledClass:[UITextView class]
                                   swizzledSelector:@selector(ruleValidationTextView:shouldInteractWithTextAttachment:inRange:)];
        
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

#pragma mark - public

- (__kindof IQRuleValidationManager *)getRuleManager
{
    return objc_getAssociatedObject(self, &kAssociatedTextViewRuleManagerKey);
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

#pragma mark - swizzled UITextView Method

- (BOOL)ruleValidationTextViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"--UITextView ruleValidationTextViewShouldBeginEditing--");
    BOOL editing = [self ruleValidationTextViewShouldBeginEditing:textView];
    BOOL ruleEditing = [textView textViewShouldBeginEditing:textView];
    return editing && ruleEditing;
}

- (BOOL)ruleValidationTextViewShouldEndEditing:(UITextView *)textView
{
    NSLog(@"--UITextView ruleValidationTextViewShouldEndEditing:--");
    BOOL editing = [self ruleValidationTextViewShouldEndEditing:textView];
    BOOL ruleEditing = [textView textViewShouldEndEditing:textView];
    return editing && ruleEditing;
}

- (void)ruleValidationTextViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"--UITextView ruleValidationTextViewDidBeginEditing:--");
    [self ruleValidationTextViewDidBeginEditing:textView];
    [textView textViewDidBeginEditing:textView];
}

- (void)ruleValidationTextViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"--UITextView ruleValidationTextViewDidEndEditing:--");
    [self ruleValidationTextViewDidEndEditing:textView];
    [textView textViewDidEndEditing:textView];
}

- (BOOL)ruleValidationTextView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"--UITextView ruleValidationTextView:shouldChangeTextInRange:replacementText:--");
    BOOL editing = [self ruleValidationTextView:textView shouldChangeTextInRange:range replacementText:text];
    BOOL ruleEditing = [textView textView:textView shouldChangeTextInRange:range replacementText:text];
    return editing && ruleEditing;
}

- (void)ruleValidationTextViewDidChange:(UITextView *)textView
{
    NSLog(@"--UITextView ruleValidationTextViewDidChange--");
    [self ruleValidationTextViewDidChange:textView];
    [textView textViewDidChange:textView];
}

- (void)ruleValidationTextViewDidChangeSelection:(UITextView *)textView
{
    NSLog(@"--UITextView ruleValidationTextViewDidChangeSelection--");
    [self ruleValidationTextViewDidChangeSelection:textView];
    [textView textViewDidChangeSelection:textView];
}

- (BOOL)ruleValidationTextView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"--UITextView ruleValidationTextView:shouldInteractWithURL:inRange:--");
    BOOL editing = [self ruleValidationTextView:textView shouldInteractWithURL:URL inRange:characterRange];
    BOOL ruleEditing = [textView textView:textView shouldInteractWithURL:URL inRange:characterRange];
    return editing && ruleEditing;
}

- (BOOL)ruleValidationTextView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSLog(@"--UITextView ruleValidationTextView:shouldInteractWithTextAttachment:inRange--");
    BOOL editing = [self ruleValidationTextView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    BOOL ruleEditing = [textView textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    return editing && ruleEditing;
}

@end
