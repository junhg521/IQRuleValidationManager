//
//  UITextView+RuleOperation.m
//  WandaBP
//
//  Created by Jun on 16/9/12.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import "UITextView+RuleOperation.h"
#import "UITextView+RuleAddition.h"

@implementation UITextView (RuleOperation)

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
//    return [self validate:textView.text error:nil];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{

}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
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
    
    return [self validate:content error:nil];
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
