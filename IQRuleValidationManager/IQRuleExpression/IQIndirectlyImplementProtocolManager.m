//
//  IQIndirectlyImplementProtocolManager.m
//
//  Created by Jun on 16/9/12.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import "IQIndirectlyImplementProtocolManager.h"
#import "IQRuleMacro.h"

@implementation IQIndirectlyImplementProtocolManager

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    DLog()
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    DLog()
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    DLog()
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    DLog()
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    DLog()
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    DLog()
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    DLog()
    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    DLog()
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    DLog()
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    DLog()
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    DLog()
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    DLog()
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    DLog()
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    DLog()
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    DLog()
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    DLog()
    return YES;
}

@end
