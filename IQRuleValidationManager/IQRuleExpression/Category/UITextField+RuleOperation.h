//
//  UITextField+RuleOperation.h
//  WandaBP
//
//  Created by Jun on 16/9/12.
//  Copyright © 2016年 Wanda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (RuleOperation)
/**
 *  @brief  <#Description#>
 *
 *  @param textField <#textField description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
/**
 *  @brief  <#Description#>
 *
 *  @param textField <#textField description#>
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField;
/**
 *  @brief  <#Description#>
 *
 *  @param textField <#textField description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
/**
 *  @brief  <#Description#>
 *
 *  @param textField <#textField description#>
 */
- (void)textFieldDidEndEditing:(UITextField *)textField;
/**
 *  @brief  <#Description#>
 *
 *  @param textField <#textField description#>
 *  @param range     <#range description#>
 *  @param string    <#string description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
/**
 *  @brief  <#Description#>
 *
 *  @param textField <#textField description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)textFieldShouldClear:(UITextField *)textField;
/**
 *  @brief  <#Description#>
 *
 *  @param textField <#textField description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
