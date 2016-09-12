//
//  UITextField+RuleOperation.m
//
//  Created by Jun on 16/9/12.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import "UITextField+RuleOperation.h"
#import "UITextField+RuleAddition.h"

@implementation UITextField (RuleOperation)

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
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
    
    NSString *content = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (content.length > textField.maxRuleLength && textField.maxRuleLength > 0) {
        return NO;
    }
    if (content.length < textField.minRuleLength && textField.minRuleLength > 0) {
        return NO;
    }
    
    return [self validateWhenChanged:content error:nil];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [self validateWhileEndEditing:textField.text error:nil];
}

@end
