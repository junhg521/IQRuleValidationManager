//
//  ViewController.m
//  IQRuleValidationManager
//
//  Created by Jun on 16/9/9.
//  Copyright © 2016年 JunHg. All rights reserved.
//

#import "ViewController.h"
#import "IQRuleExpression.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.numberWithTwoDecimalPointTextField.delegate = self;
    self.numberWithTwoDecimalPointTextField.ruleType = IQRuleValidationNumberWithTwoDecimalPoint;
    self.numberWithTwoDecimalPointTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    self.numberTextField.delegate = self;
    self.numberTextField.ruleType = IQRuleValidationNumber;
    self.numberTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.mobileTextField.delegate = self;
    self.mobileTextField.ruleType = IQRuleValidationMobile;
    self.mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.alphaAndNumberTextField.delegate = self;
    self.alphaAndNumberTextField.ruleType = IQRuleValidationAlphaAndNumber;
    
    self.alphaTextField.delegate = self;
    self.alphaTextField.ruleType = IQRuleValidationAlpha;
    
    self.uppercaseAlphaTextField.delegate = self;
    self.uppercaseAlphaTextField.ruleType = IQRuleValidationUppercaseAlpha;
    
    self.lowercaseAlphaTextField.delegate = self;
    self.lowercaseAlphaTextField.ruleType = IQRuleValidationLowercaseAlpha;
    
    self.alphaAndNumberAndUnderLineTextField.delegate = self;
    self.alphaAndNumberAndUnderLineTextField.ruleType = IQRuleValidationAlphaAndNumberAndUnderLine;
    
    self.monthInYearTextField.delegate = self;
    self.monthInYearTextField.ruleType = IQRuleValidationMonthInYear;
    self.monthInYearTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.daysInMonthTextField.delegate = self;
    self.daysInMonthTextField.ruleType = IQRuleValidationDaysInMonth;
    self.daysInMonthTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.emailTextField.delegate = self;
    self.emailTextField.ruleType = IQRuleValidationEmail;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
