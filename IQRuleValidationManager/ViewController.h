//
//  ViewController.h
//  IQRuleValidationManager
//
//  Created by Jun on 16/9/9.
//  Copyright © 2016年 JunHg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *numberWithTwoDecimalPointTextField;
@property (nonatomic, weak) IBOutlet UITextField *numberTextField;
@property (nonatomic, weak) IBOutlet UITextField *mobileTextField;
@property (nonatomic, weak) IBOutlet UITextField *alphaAndNumberTextField;
@property (nonatomic, weak) IBOutlet UITextField *alphaTextField;
@property (nonatomic, weak) IBOutlet UITextField *uppercaseAlphaTextField;
@property (nonatomic, weak) IBOutlet UITextField *lowercaseAlphaTextField;
@property (nonatomic, weak) IBOutlet UITextField *alphaAndNumberAndUnderLineTextField;
@property (nonatomic, weak) IBOutlet UITextField *monthInYearTextField;
@property (nonatomic, weak) IBOutlet UITextField *daysInMonthTextField;
@property (nonatomic, weak) IBOutlet UITextField *emailTextField;

@end

