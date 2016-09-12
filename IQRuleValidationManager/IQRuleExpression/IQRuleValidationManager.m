//
//  IQRuleValidationManager.m
//  
//
//  Created by Jun on 16/9/6.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import "IQRuleValidationManager.h"
#import "IQIndirectlyImplementProtocolManager.h"
#import "UITextField+RuleOperation.h"
#import "UITextView+RuleOperation.h"
#import <objc/runtime.h>

@interface IQRuleValidationManager ()

@property (nonatomic, assign) IQRuleValidationType type;
@end

@implementation IQRuleValidationManager

+ (void)swizzlingInstanceClassMethod:(_Nonnull Class) validateClass originalSelector:(_Nonnull SEL) originalSelector swizzledSelector:(_Nonnull SEL) swizzledSelector
{
    Method originalMethod = class_getInstanceMethod(validateClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
    
    if (!originalMethod) {
        Method indirectlyMethod = class_getInstanceMethod([IQIndirectlyImplementProtocolManager class], originalSelector);
        BOOL addMethod = class_addMethod(validateClass, originalSelector, method_getImplementation(indirectlyMethod), method_getTypeEncoding(indirectlyMethod));
        validateClass = [IQIndirectlyImplementProtocolManager class];
        if (!addMethod) {
            return;
        }
    }
    
    BOOL registerMethod = class_addMethod(validateClass, swizzledSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (!registerMethod) {
        return;
    }

    swizzledMethod = class_getInstanceMethod(validateClass, swizzledSelector);
    if (!swizzledMethod) {
        return;
    }
    
    BOOL didAddMethod = class_addMethod(validateClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(validateClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)lookforValidateClassImplement:(Protocol *) protocol originalSelector:(_Nonnull SEL) originalSelector swizzledSelector:(_Nonnull SEL) swizzledSelector
{
    int classesCount = objc_getClassList(NULL, 0);
    Class *classes = (Class *)malloc(classesCount * sizeof(Class));
    objc_getClassList(classes, classesCount);
    
    for (NSInteger i=0; i<classesCount; i++) {
        @autoreleasepool {
            Class conformClass = classes[i];
            if (![NSStringFromClass(conformClass) hasPrefix:@"BP"] || [NSStringFromClass(conformClass) isEqualToString:@"IQIndirectlyImplementProtocolManager"]) {
                continue;
            }
            while (conformClass != Nil) {
                if (class_conformsToProtocol(conformClass, protocol)) {
                    break;
                }
                conformClass = class_getSuperclass(conformClass);
            }
            
            if (conformClass != Nil) {
                unsigned int methodsCount = 0;
                class_copyMethodList(conformClass, &methodsCount);
                for( unsigned methodIndex = 0; methodIndex < methodsCount; methodIndex++) {
                    @autoreleasepool {
                        [IQRuleValidationManager swizzlingInstanceClassMethod:conformClass originalSelector:originalSelector swizzledSelector:swizzledSelector];
                    }
                }
            }
        }
    }
    if (classes) {
        free(classes);
        classes = nil;
    }
}

+ (void)load
{
    [[IQRuleValidationManager sharedManager] setRuleValidationEnable:YES];
}

/*  Automatically called from the `+(void)load` method. */
+ (IQRuleValidationManager*)sharedManager
{
    static IQRuleValidationManager *_sharedManager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}


- (instancetype)init
{
    if (self = [super init]) {
        [self lookforSwizzledProtocolName:"UITextFieldDelegate"
                         originalSelector:@selector(textFieldShouldBeginEditing:)
                         swizzledSelector:@selector(ruleValidationTextFieldShouldBeginEditing:)];
        [self lookforSwizzledProtocolName:"UITextFieldDelegate"
                         originalSelector:@selector(textFieldDidBeginEditing:)
                         swizzledSelector:@selector(ruleValidationTextFieldDidBeginEditing:)];
        [self lookforSwizzledProtocolName:"UITextFieldDelegate"
                         originalSelector:@selector(textFieldShouldEndEditing:)
                         swizzledSelector:@selector(ruleValidationTextFieldShouldEndEditing:)];
        [self lookforSwizzledProtocolName:"UITextFieldDelegate"
                         originalSelector:@selector(textFieldDidEndEditing:)
                         swizzledSelector:@selector(ruleValidationTextFieldDidEndEditing:)];
        [self lookforSwizzledProtocolName:"UITextFieldDelegate"
                         originalSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)
                         swizzledSelector:@selector(ruleValidationTextField:shouldChangeCharactersInRange:replacementString:)];
        [self lookforSwizzledProtocolName:"UITextFieldDelegate"
                         originalSelector:@selector(textFieldShouldClear:)
                         swizzledSelector:@selector(ruleValidationTextFieldShouldClear:)];
        [self lookforSwizzledProtocolName:"UITextFieldDelegate"
                         originalSelector:@selector(textFieldShouldReturn:)
                         swizzledSelector:@selector(ruleValidationTextFieldShouldReturn:)];
        [self lookforSwizzledProtocolName:"UITextViewDelegate"
                         originalSelector:@selector(textViewShouldBeginEditing:)
                         swizzledSelector:@selector(ruleValidationTextViewShouldBeginEditing:)];
        [self lookforSwizzledProtocolName:"UITextViewDelegate"
                         originalSelector:@selector(textViewShouldEndEditing:)
                         swizzledSelector:@selector(ruleValidationTextViewShouldEndEditing:)];
        [self lookforSwizzledProtocolName:"UITextViewDelegate"
                         originalSelector:@selector(textViewDidBeginEditing:)
                         swizzledSelector:@selector(ruleValidationTextViewDidBeginEditing:)];
        [self lookforSwizzledProtocolName:"UITextViewDelegate"
                         originalSelector:@selector(textView:shouldChangeTextInRange:replacementText:)
                         swizzledSelector:@selector(ruleValidationTextView:shouldChangeTextInRange:replacementText:)];
        [self lookforSwizzledProtocolName:"UITextViewDelegate"
                         originalSelector:@selector(textViewDidChange:)
                         swizzledSelector:@selector(ruleValidationTextViewDidChange:)];
        [self lookforSwizzledProtocolName:"UITextViewDelegate"
                         originalSelector:@selector(textViewDidChangeSelection:)
                         swizzledSelector:@selector(ruleValidationTextViewDidChangeSelection:)];
        [self lookforSwizzledProtocolName:"UITextViewDelegate"
                         originalSelector:@selector(textView:shouldInteractWithURL:inRange:)
                         swizzledSelector:@selector(ruleValidationTextView:shouldInteractWithURL:inRange:)];
        [self lookforSwizzledProtocolName:"UITextViewDelegate"
                         originalSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)
                         swizzledSelector:@selector(ruleValidationTextView:shouldInteractWithTextAttachment:inRange:)];
    }
    return self;
}


#pragma mark - ClassMethod

+ (nonnull IQRuleValidationManager *)ruleValidationManagerWithType:(IQRuleValidationType)type
{
    NSString *className = [[self class] validationClassNameWithType:type];
    if (className) {
        IQRuleValidationManager *manager = [[NSClassFromString(className) alloc] init];
        manager.type = type;
        return manager;
    }
    return nil;
}

#pragma mark - public

- (BOOL)validationInputContent:(NSString *)content error:(NSError * _Nullable __autoreleasing *)error
{
    NSString *regularExpression = [self regularExpressionWithType:self.type];
    if (regularExpression) {
        return [self validationInputContent:content regularExpression:regularExpression error:error];
    }
    return YES;
}

#pragma mark - IQRuleValidationManager

+ (NSString *)validationClassNameWithType:(IQRuleValidationType)type
{
    NSString *className = nil;
    switch (type) {
        case IQRuleValidationLengthConstraint:
        case IQRuleValidationTextFieldDecimal:
        case IQRuleValidationTextFieldNumber:
            className = NSStringFromClass([IQRuleValidationManager class]);
            break;
        default:
            break;
    }
    return className;
}

- (NSString *)regularExpressionWithType:(IQRuleValidationType)type
{
    NSString *regularExpression = nil;
    switch (self.type) {
        case IQRuleValidationNone:
            break;
            
        case IQRuleValidationLengthConstraint:
            
            break;
        case IQRuleValidationTextFieldDecimal:
            regularExpression = @"^(0|[1-9]\\d*)(\\.[0-9]{0,2})?$";
            break;
            
        case IQRuleValidationTextFieldNumber:
            regularExpression = @"^[1-9]\\d*$";
            break;
            
        default:
            break;
    }
    return regularExpression;
}

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

#pragma mark - swizzled UITextView Method

- (BOOL)ruleValidationTextViewShouldBeginEditing:(UITextView *)textView
{
    BOOL editing = [self ruleValidationTextViewShouldBeginEditing:textView];
    BOOL ruleEditing = [textView textViewShouldBeginEditing:textView];
    return editing && ruleEditing;
}

- (BOOL)ruleValidationTextViewShouldEndEditing:(UITextView *)textView
{
    BOOL editing = [self ruleValidationTextViewShouldEndEditing:textView];
    BOOL ruleEditing = [textView textViewShouldEndEditing:textView];
    return editing && ruleEditing;
}

- (void)ruleValidationTextViewDidBeginEditing:(UITextView *)textView
{
    [self ruleValidationTextViewDidBeginEditing:textView];
    [textView textViewDidBeginEditing:textView];
}

- (void)ruleValidationTextViewDidEndEditing:(UITextView *)textView
{
    [self ruleValidationTextViewDidEndEditing:textView];
    [textView textViewDidEndEditing:textView];
}

- (BOOL)ruleValidationTextView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    BOOL editing = [self ruleValidationTextView:textView shouldChangeTextInRange:range replacementText:text];
    BOOL ruleEditing = [textView textView:textView shouldChangeTextInRange:range replacementText:text];
    return editing && ruleEditing;
}

- (void)ruleValidationTextViewDidChange:(UITextView *)textView
{
    [self ruleValidationTextViewDidChange:textView];
    [textView textViewDidChange:textView];
}

- (void)ruleValidationTextViewDidChangeSelection:(UITextView *)textView
{
    [self ruleValidationTextViewDidChangeSelection:textView];
    [textView textViewDidChangeSelection:textView];
}

- (BOOL)ruleValidationTextView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    BOOL editing = [self ruleValidationTextView:textView shouldInteractWithURL:URL inRange:characterRange];
    BOOL ruleEditing = [textView textView:textView shouldInteractWithURL:URL inRange:characterRange];
    return editing && ruleEditing;
}

- (BOOL)ruleValidationTextView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    BOOL editing = [self ruleValidationTextView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    BOOL ruleEditing = [textView textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    return editing && ruleEditing;
}

#pragma mark - private

- (void)lookforSwizzledProtocolName:( const char * _Nonnull )protocolName originalSelector:(_Nonnull SEL) originalSelector swizzledSelector:(_Nonnull SEL) swizzledSelector
{
    if (protocolName && objc_getProtocol(protocolName)) {
        [IQRuleValidationManager lookforValidateClassImplement:objc_getProtocol(protocolName)
                                              originalSelector:originalSelector
                                              swizzledSelector:swizzledSelector];
    }
}

#pragma mark - Property

- (void)setRuleValidationEnable:(BOOL)ruleValidationEnable
{
    _ruleValidationEnable = ruleValidationEnable;
}

@end
