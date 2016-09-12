//
//  UITextView+RuleAddition.m
//
//  Created by Jun on 16/9/7.
//  Copyright © 2016年  All rights reserved.
//

#import "UITextView+RuleAddition.h"
#import <objc/runtime.h>

static char kAssociatedTextViewRuleManagerKey;

@implementation UITextView (RuleAddition)
@dynamic maxRuleLength;
@dynamic minRuleLength;
@dynamic ruleType;
@dynamic ruleManagerClassName;

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

- (BOOL)validate:(NSString *)str error:(NSError *__autoreleasing *)error
{
    return [[self getRuleManager] validationInputContent:str error:error];
}

@end
