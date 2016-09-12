//
//  UITextView+RuleOperation.h
//  WandaBP
//
//  Created by Jun on 16/9/12.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (RuleOperation)
/**
 *  @brief  <#Description#>
 *
 *  @param textView <#textView description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
/**
 *  @brief  <#Description#>
 *
 *  @param textView <#textView description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)textViewShouldEndEditing:(UITextView *)textView;
/**
 *  @brief  <#Description#>
 *
 *  @param textViewDidEndEditing <#textViewDidEndEditing description#>
 *  @param textView              <#textView description#>
 */
- (void)textViewDidBeginEditing:(UITextView *)textView;
/**
 *  @brief  <#Description#>
 *
 *  @param textView <#textView description#>
 */
- (void)textViewDidEndEditing:(UITextView *)textView;
/**
 *  @brief  <#Description#>
 *
 *  @param textView <#textView description#>
 *  @param range    <#range description#>
 *  @param text     <#text description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
/**
 *  @brief  <#Description#>
 *
 *  @param textView <#textView description#>
 */
- (void)textViewDidChange:(UITextView *)textView;
/**
 *  @brief  <#Description#>
 *
 *  @param textView <#textView description#>
 */
- (void)textViewDidChangeSelection:(UITextView *)textView;
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange;
/**
 *  @brief  <#Description#>
 *
 *  @param textView       <#textView description#>
 *  @param textAttachment <#textAttachment description#>
 *  @param characterRange <#characterRange description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange;

@end
