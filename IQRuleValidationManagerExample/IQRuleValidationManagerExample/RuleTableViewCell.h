//
//  RuleTableViewCell.h
//  IQRuleValidationManagerExample
//
//  Created by Jun on 2/15/17.
//  Copyright © 2017 JunHg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RuleTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *typeLabel;
@property (nonatomic, weak) IBOutlet UITextField *typeTextField;

@end
