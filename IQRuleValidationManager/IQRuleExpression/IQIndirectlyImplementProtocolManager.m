//
//  IQIndirectlyImplementProtocolManager.m
//
//  Created by Jun on 16/9/12.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import "IQIndirectlyImplementProtocolManager.h"

@implementation IQIndirectlyImplementProtocolManager

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textFieldShouldBeginEditing--");
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textFieldDidBeginEditing--");
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textFieldShouldEndEditing--");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textFieldDidEndEditing--");
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textField:shouldChangeCharactersInRange:replacementString--");
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textFieldShouldClear--");
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textFieldShouldReturn--");
    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textFieldShouldBeginEditing--");
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textFieldShouldBeginEditing--");
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textViewDidBeginEditing--");
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"---IQIndirectlyImplementProtocolManager textViewDidEndEditing--");
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textView:shouldChangeTextInRange:replacementText:--");
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textViewDidChange--");
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textViewDidChangeSelection--");
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textView:shouldInteractWithURL:--");
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange
{
    NSLog(@"--IQIndirectlyImplementProtocolManager textView:shouldInteractWithTextAttachment:inRange:--");
    return YES;
}

@end
