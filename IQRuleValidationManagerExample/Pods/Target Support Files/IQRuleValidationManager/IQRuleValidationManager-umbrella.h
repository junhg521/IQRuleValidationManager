#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UITextField+RuleAddition.h"
#import "UITextView+RuleAddition.h"
#import "IQBasicRuleValidationManager.h"
#import "IQIndirectlyImplementProtocolManager.h"
#import "IQRuleMacro.h"
#import "IQRuleValidationManager.h"
#import "IQSwizzleUtils.h"

FOUNDATION_EXPORT double IQRuleValidationManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char IQRuleValidationManagerVersionString[];

