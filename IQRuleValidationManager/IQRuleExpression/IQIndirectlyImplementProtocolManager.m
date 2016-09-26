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
    DLog(@"--textFieldShouldBeginEditing--")
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    DLog(@"--textFieldDidBeginEditing--")
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    DLog(@"--textFieldShouldEndEditing--")
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    DLog(@"--textFieldDidEndEditing--")
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    DLog(@"--textField:shouldChangeCharactersInRange:replacementString--")
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    DLog(@"--textFieldShouldClear--")
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    DLog(@"--textFieldShouldReturn--")
    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    DLog(@"--textFieldShouldBeginEditing--")
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    DLog(@"--textFieldShouldBeginEditing--")
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    DLog(@"--textViewDidBeginEditing--")
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    DLog(@"---textViewDidEndEditing--")
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    DLog(@"--textView:shouldChangeTextInRange:replacementText:--")
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    DLog(@"--textViewDidChange--")
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    DLog(@"--textViewDidChangeSelection--")
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    DLog(@"--textView:shouldInteractWithURL:--")
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    DLog(@"--textView:shouldInteractWithTextAttachment:inRange:--")
    return YES;
}

@end
