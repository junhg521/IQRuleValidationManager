//
//  NSString+EscapePrefix.m
//  IQRuleValidationManager
//
//  Created by Jun on 16/10/18.
//  Copyright © 2016年 JunHg. All rights reserved.
//

#import "NSString+EscapePrefix.h"

@implementation NSString (EscapePrefix)

- (BOOL)escapeWithClassPrefix:(NSString *)prefix
{
    if (![[prefix stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        return NO;
    }
    
    if ([self hasPrefix:prefix]) {
        return YES;
    }
    return NO;
}

@end
