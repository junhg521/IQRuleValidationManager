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
    
    self.nameTextField.ruleType = IQRuleValidationPositiveWithTwoDecimalPoint;
    self.nameTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.nameTextField.delegate = self;
    
    self.passwordTextField.ruleType = IQRuleValidationPositive;
    self.passwordTextField.keyboardType = IQRuleValidationPositive;
    self.passwordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
