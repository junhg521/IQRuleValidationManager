//
//  ViewController.m
//  IQRuleValidationManagerExample
//
//  Created by Jun on 2/15/17.
//  Copyright © 2017 JunHg. All rights reserved.
//

#import "ViewController.h"
#import "RuleTableViewCell.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *datasources;
@property (nonatomic, strong) NSMutableArray *typeDatasources;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.datasources = [NSMutableArray arrayWithObjects:@"两位小数点正数：", @"正整数:", @"电话：", @"字母数字：",
                        @"字母：", @"大写字母：", @"小写字母：", @"字母数字下划线：", @"一年每月：", @"一月每天：", @"EMail：", nil];
    self.typeDatasources = [NSMutableArray arrayWithObjects:@(IQRuleValidationNumberWithTwoDecimalPoint), @(IQRuleValidationNumber), @(IQRuleValidationMobile), @(IQRuleValidationAlphaAndNumber), @(IQRuleValidationAlpha), @(IQRuleValidationUppercaseAlpha), @(IQRuleValidationLowercaseAlpha), @(IQRuleValidationAlphaAndNumberAndUnderLine), @(IQRuleValidationMonthInYear), @(IQRuleValidationDaysInMonth), @(IQRuleValidationEmail), nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RuleTableViewCell" bundle:nil] forCellReuseIdentifier:@"RuleTableViewCell"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RuleTableViewCell" forIndexPath:indexPath];
    
    if ([cell isKindOfClass:[RuleTableViewCell class]]) {
        RuleTableViewCell *ruleCell = (RuleTableViewCell *)cell;
        ruleCell.typeLabel.text = [self.datasources objectAtIndex:indexPath.row];
        ruleCell.typeTextField.ruleType = [[self.typeDatasources objectAtIndex:indexPath.row] integerValue];
    }
    return cell;
}

@end
