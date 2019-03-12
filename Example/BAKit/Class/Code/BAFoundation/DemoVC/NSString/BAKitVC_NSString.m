//
//  BAKitVC_NSString.m
//  BAKit
//
//  Created by boai on 2017/6/8.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "BAKitVC_NSString.h"
#import "BAKitVC_NSMutableAttributedString.h"

static NSString * const kCellID = @"BAFoundationViewControllerCell";
static NSString * const test_string1 = @"Font Awesome 是一个非常方便的图标库。这些图片都是矢量图，以 .svg 文件格式保存。这些图标用起来就像字体一样。你可以使用像素单位来指定他们的大小，它们会继承父级HTML元素的字体大小。 使用 Font Awesome 分别为你的 info 按钮添加 info-circle 图标，为你的 delete 按钮添加 trash 图标。";
static NSString * const test_timeStap1 = @"1492672164";

@interface BAKitVC_NSString ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) NSArray *sectionDataArray;

@property(nonatomic, strong) NSIndexPath *selectIndexPath;

@end

@implementation BAKitVC_NSString

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)ba_base_setupUI
{
    self.view.backgroundColor = BAKit_Color_White;
}

#pragma mark - UITableViewDataSource / UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell ba_cellDequeueFromIdentify:kCellID cellStyle:UITableViewCellStyleValue1 tableView:tableView];
    NSString *msg = [@(indexPath.row + 1).stringValue stringByAppendingString:@"、"];
    
    cell.textLabel.text = [msg stringByAppendingString:self.dataArray[indexPath.section][indexPath.row]];
    cell.textLabel.font = BAKit_Font_systemFontOfSize_15;
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.selectIndexPath = indexPath;
    [self ba_selectRow:indexPath];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [BAKit_Color_Cyan colorWithAlphaComponent:0.3f];
    
    UILabel *headerTitle = [UILabel new];
    headerTitle.font = BAKit_Font_systemFontOfSize_15;
    headerTitle.textColor = BAKit_Color_Red;
    headerTitle.numberOfLines = 0;
    [headerView addSubview:headerTitle];
    
    headerTitle.frame = CGRectMake(20, 0, BAKit_SCREEN_WIDTH - 40, BAKit_Margin_30);
    headerTitle.text = [[NSString ba_stringFormatterWithSpellOutStyleWithNumberString:@(section+1).stringValue] stringByAppendingString:[NSString stringWithFormat:@"、%@", self.sectionDataArray[section]]];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return BAKit_Margin_30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}

#pragma mark - custom method

- (void)ba_selectRow:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.selectIndexPath];
    ;
    
    NSArray *buttonTitleArray = @[@"取消", @"确定"];
    NSArray *buttonTitleColorArray = @[BAKit_Color_Green, BAKit_Color_Red];
    NSArray *textFieldPlaceholderArray;
    
    switch (indexPath.section) {
        case 0:
        {
            cell.textLabel.textColor = BAKit_Color_Hex([NSString ba_stringRandomColor]);
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    textFieldPlaceholderArray = @[@"转换自身为开头大写的字符串"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        if ([textField1 ba_textField_isEmpty])
                        {
                            return;
                        }
                        NSString *result = [textField1.text ba_stringSentenceCapitalizedString];
                        if (!result)
                        {
                            return ;
                        }
                        BAKit_ShowAlertWithMsg_ios8([@"转换结果：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 1:
                {
                    textFieldPlaceholderArray = @[@"要编码的URL"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *url = textField1.text;
                        if ([textField1 ba_textField_isEmpty])
                        {
                            return;
                        }
                        NSString *result = [[url ba_stringUrlEncode] ba_stringSentenceCapitalizedString];
                        if (!result)
                        {
                            return ;
                        }
                        BAKit_ShowAlertWithMsg_ios8([@"编码结果：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 2:
                {
                    textFieldPlaceholderArray = @[@"要格式化的 string"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSData *stringData = [textField1.text ba_stringDataValue];
                        if ([textField1 ba_textField_isEmpty])
                        {
                            return;
                        }
                        NSString *result = [NSString stringWithFormat:@"%@", stringData];
                        
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"格式化结果：" stringByAppendingString:result]);
                    }];

                }
                    break;
                case 3:
                {
                    textFieldPlaceholderArray = @[@"要搜索的内容", @"起始位置", @"结束位置"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                        if (index == 1 || index == 2)
                        {
                            textField.keyboardType = UIKeyboardTypeWebSearch;
                        }
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        UITextField *textField2 = alertController.textFields[1];
                        UITextField *textField3 = alertController.textFields[2];

                        if ([textField2 ba_textField_isEmpty] || [textField3 ba_textField_isEmpty])
                        {
                            return;
                        }
                        NSString *result = [NSString ba_stringSearchInString:textField1.text charStart:*(char *)[textField2.text UTF8String] charEnd:*(char *)[textField3.text UTF8String]];
                        if (!result)
                        {
                            return ;
                        }
                        BAKit_ShowAlertWithMsg_ios8([@"搜索结果：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 4:
                {
                    textFieldPlaceholderArray = @[@"请输入内容"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        
                        BOOL result = [textField1.text ba_stringIsBlank];
                        BAKit_ShowAlertWithMsg_ios8([@"判断结果：" stringByAppendingString:result == YES ? @"为空":@"不为空"]);
                    }];
                }
                    break;
                case 5:
                {
                    textFieldPlaceholderArray = @[@"请输入身份证号码"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        
                        NSDateFormatter *format = [NSDateFormatter ba_setupDateFormatterWithYMD];
                        NSDate *result = [textField1.text ba_stringExtractBirthdayFromIDNumber];
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"生日为：" stringByAppendingString:[format stringFromDate:result]]);
                    }];
                }
                    break;
                case 6:
                {
                    textFieldPlaceholderArray = @[@"请输入身份证号码"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = [textField1.text ba_stringExtractGenderFromIDNumber];
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"性别为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 7:
                {
                    textFieldPlaceholderArray = @[@"请输入身份证号码"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = @([textField1.text ba_stringExtractAgeFromIDNumber]).stringValue;
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"年龄为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 8:
                {
                    NSString *msg = [cell.textLabel.text stringByAppendingString:[NSString ba_stringGetIPAddress]];
                    BAKit_ShowAlertWithMsg_ios8(msg);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
           
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    textFieldPlaceholderArray = @[@"请输入手机号码"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = [NSString ba_phoneNumberFormatterSpace:textField1.text];
                        if (!result)
                        {
                            return ;
                        }
                        BAKit_ShowAlertWithMsg_ios8([@"手机号码格式化为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 1:
                {
                    textFieldPlaceholderArray = @[@"请输入手机号码"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = [NSString ba_phoneNumberFormatterCenterStar:textField1.text];
                        if (!result)
                        {
                            return ;
                        }
                        BAKit_ShowAlertWithMsg_ios8([@"手机号码格式化为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 2:
                {
                    textFieldPlaceholderArray = @[@"请输入一串数字"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = [NSString ba_stringFormatterWithStyle:NSNumberFormatterDecimalStyle numberString:textField1.text];
                        if (!result)
                        {
                            return ;
                        }
                        BAKit_ShowAlertWithMsg_ios8([@"数字格式化为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 3:
                {
                    textFieldPlaceholderArray = @[@"请输入一串数字"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = [NSString ba_stringFormatterWithStyle:NSNumberFormatterCurrencyStyle numberString:textField1.text];
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"数字格式化为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 4:
                {
                    textFieldPlaceholderArray = @[@"请输入一串数字"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = [NSString ba_stringFormatterWithScientificStyleWithNumberString:textField1.text];
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"数字格式化为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 5:
                {
                    textFieldPlaceholderArray = @[@"请输入一串数字"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = [NSString ba_stringFormatterWithSpellOutStyleWithNumberString:textField1.text];
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"数字格式化为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 6:
                {
                    textFieldPlaceholderArray = @[@"请输入一串数字"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = [NSString ba_stringFormatterWithOrdinalStyleWithNumberString:textField1.text];
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"数字格式化为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 7:
                {
                    textFieldPlaceholderArray = @[@"请输入一串数字"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = [NSString ba_stringFormatterWithCurrencyISOCodeStyleWithNumberString:textField1.text];
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"数字格式化为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 8:
                {
                    textFieldPlaceholderArray = @[@"请输入一串数字"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = [NSString ba_stringFormatterWithCurrencyPluralStyleWithNumberString:textField1.text];
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"数字格式化为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 9:
                {
                    textFieldPlaceholderArray = @[@"请输入一串数字+字母"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = [textField1.text ba_removeStringSaveNumber];
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"数字格式化为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 10:
                {
                    textFieldPlaceholderArray = @[@"请输入一串数字"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        NSString *result = [NSString ba_stringTransformNumberWithString:textField1.text];
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"数字格式化为：" stringByAppendingString:result]);
                    }];
                }
                    break;
                case 11:
                {
                    textFieldPlaceholderArray = @[@"请输入一串数字"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                        textField.keyboardType = UIKeyboardTypeNumberPad;

                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        BOOL result = [NSString ba_stringIsInt:textField1.text];
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"数字格式化为：" stringByAppendingString:result == YES ? @"是 int 类型":@"不是 int 类型"]);
                    }];
                }
                    break;
                case 12:
                {
                    textFieldPlaceholderArray = @[@"请输入一串数字"];
                    [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                        
                        textField.keyboardType = UIKeyboardTypeNumberPad;
                        
                    } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                        
                        UITextField *textField1 = alertController.textFields[0];
                        BOOL result = [NSString ba_stringIsFloat:textField1.text];
                        if (!result)
                        {
                            return ;
                        }
                        
                        BAKit_ShowAlertWithMsg_ios8([@"数字格式化为：" stringByAppendingString:result == YES ? @"是 float 类型":@"不是 float 类型"]);
                    }];
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        case 3:
        {
            textFieldPlaceholderArray = @[@"请输入内容", @"搜索关键字"];
            [UIAlertController ba_alertTextFieldShowInViewController:self title:nil message:cell.textLabel.text buttonTitleArray:buttonTitleArray buttonTitleColorArray:buttonTitleColorArray buttonEnabledNoWithTitleArray:nil textFieldPlaceholderArray:textFieldPlaceholderArray textFieldConfigurationActionBlock:^(UITextField * _Nullable textField, NSInteger index) {
                
            } block:^(UIAlertController * _Nonnull alertController, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
                
                UITextField *textField1 = alertController.textFields[0];
                UITextField *textField2 = alertController.textFields[1];

                NSArray *result = [textField1.text ba_rangesOfString:textField2.text options:NSCaseInsensitiveSearch serachRange:NSMakeRange(0, textField1.text.length)];
                NSLog(@"搜索结果为：%@", result);
            }];
        }
            break;
        case 4:
        {
            switch (indexPath.row) {
                case 0:
                {
                    CGSize result = [test_string1 ba_stringGetSizeWithMaxSize:CGSizeMake(BAKit_SCREEN_WIDTH - 20, FLT_MAX) fontSize:15];
                    NSLog(@"文本 size 结果为：%@", NSStringFromCGSize(result));
                }
                    break;
                case 1:
                {
                    CGSize result = [test_string1 ba_stringGetSizeWithMaxSize:CGSizeMake(BAKit_SCREEN_WIDTH - 20, FLT_MAX) font:BAKit_Font_boldSystemFontOfSize_20];
                    NSLog(@"文本 size2 结果为：%@", NSStringFromCGSize(result));
                }
                    break;
                case 2:
                {
                    CGFloat result = [test_string1 ba_stringGetHeightWithFont:BAKit_Font_boldSystemFontOfSize_15 width:BAKit_SCREEN_WIDTH - 20];
                    NSLog(@"文本 height 结果为：%.2f", result);
                }
                    break;
                case 3:
                {
                    NSString *message = @"当前用户未 登录 ，是否 登录 ？";
                    NSString *keyWord = @"登录";

                    /*! 关键字添加效果 */
                    NSMutableAttributedString *attributedMessage = [[NSMutableAttributedString alloc] initWithString:message];
                    
                    /*! 获取关键字位置 */
                    NSRange range = [message rangeOfString:keyWord];
                    
                    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor],NSKernAttributeName:@2.0,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle),NSStrokeColorAttributeName:[UIColor blueColor],NSStrokeWidthAttributeName:@2.0,NSVerticalGlyphFormAttributeName:@(0)};
                    
                    /*! 设置关键字属性 */
                    [attributedMessage ba_changeAttributeDict:dic range:range];
                    
                    CGFloat result = [test_string1 ba_stringGetHeightWithStringAttributeDictionary:dic width:BAKit_SCREEN_WIDTH - 20];
                    NSLog(@"文本 height2 结果为：%.2f", result);
                }
                    break;
                    
                default:
                    break;
            }
        }
            break;
        case 5:
        {
            NSString *result = @"";
            switch (indexPath.row) {
                case 0:
                {
                    result = BAKit_Current_DateYMDHMS();
                }
                    break;
                case 1:
                {
                    result = BAKit_Current_DateWithFormatString(BAKit_FormatString_YMD3);
                }
                    break;
                case 2:
                {
                    result = [NSString ba_time_getDateWithTimeStampYMDHMS:test_timeStap1];
                }
                    break;
                case 3:
                {
                    result = [NSString ba_time_getDateWithTimeStamp:test_timeStap1 formatString:BAKit_FormatString_YMD3];
                }
                    break;
                case 4:
                {
                    result = [NSString ba_time_getCurrentDateTransformTimeStampYMDHMS];
                    NSString *currentTime = [@"当前时间：" stringByAppendingString:BAKit_Current_DateYMDHMS()];
                    result = [NSString stringWithFormat:@"%@\n%@", result, currentTime];
                }
                    break;
                case 5:
                {
                    result = [NSString stringWithFormat:@"%ld/%ld/%ld/%ld/%ld/%@",  (long)BAKit_Current_Year(), (long)BAKit_Current_Month(), (long)BAKit_Current_Day(), (long)BAKit_Current_Hour(), (long)BAKit_Current_Minute(), BAKit_Current_Weekday()];
                }
                    break;
                case 6:
                {
                    BOOL result2 = [@(BAKit_Current_Hour()).stringValue ba_time_isBetweenFromHour:8 toHour:20];
                    result = result2 ? @"是白天":@"是夜间";
                }
                    break;
                case 7:
                {
                    result = [NSString ba_time_formatWithTimeStamp:[NSString ba_time_getCurrentDateTransformTimeStampYMDHMS]];
                }
                    break;
                    
                default:
                    break;
            }
            
            NSString *msg = [cell.textLabel.text stringByAppendingString:[NSString stringWithFormat:@"：\n%@", result]];
            BAKit_ShowAlertWithMsg_ios8(msg);
        }
            break;
        case 8:
        {
            cell.textLabel.text = nil;
            UIButton *button = (UIButton *)[cell viewWithTag:100];
            if (!button)
            {
                button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(50, 5, 100, 30);
                button.tag = 100;
                [button setTitle:@"123456789" forState:UIControlStateNormal];
                [button setTitleColor:BAKit_Color_Black forState:UIControlStateNormal];
                [cell.contentView addSubview:button];
                
                [NSString ba_stringToBeUnderlineWithButton:button range:NSMakeRange(3, 5) lineColor:BAKit_Color_Red];
                [button addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            }
            
        }
            break;
        case 9:
        {
            NSString *string3 = @"123456";
            NSString *result = @"";
            switch (indexPath.row) {
                case 0:
                {
                    result = [string3 ba_stringMD5];
                }
                    break;
                case 1:
                {
                    result = [string3 ba_stringSHA1];
                }
                    break;
                case 2:
                {
                    result = [string3 ba_stringSHA256];
                }
                    break;
                case 3:
                {
                    result = [string3 ba_stringSHA512];
                }
                    break;
                case 4:
                {
                    result = [string3 ba_stringEncodeToBase64];
                }
                    break;
                case 5:
                {
                    result = [[string3 ba_stringEncodeToBase64] ba_stringDecodeBase64];
                }
                    break;
                
                default:
                    break;
            }
            NSString *msg = [cell.textLabel.text stringByAppendingString:[NSString stringWithFormat:@"：\n%@", result]];
            BAKit_ShowAlertWithMsg_ios8(msg);
        }
            break;
        case 10:
        {
            NSString *string4 = @"[微笑]";
            NSString *emotion1 = @"😃";
            NSString *result = @"";
            switch (indexPath.row) {
                case 0:
                {
                    result = [string4 ba_stringReplaceEmojiTextWithUnicode];
                }
                    break;
                case 1:
                {
                    result = [emotion1 ba_stringReplaceEmojiUnicodeWithText];
                }
                    break;
                    
                default:
                    break;
            }
            NSString *msg = [cell.textLabel.text stringByAppendingString:[NSString stringWithFormat:@"：\n%@", result]];
            BAKit_ShowAlertWithMsg_ios8(msg);
        }
            break;
        case 11:
        {
            [self.navigationController pushViewController:[BAKitVC_NSMutableAttributedString new] animated:YES];
        }
            break;
//        case 7:
//        {
//            
//        }
//            break;
//            
        default:
            break;
    }
}

- (void)handleButtonAction:(UIButton *)sender
{
    NSString *msg = @"你点击了按钮！";
    BAKit_ShowAlertWithMsg_ios8(msg);
}

#pragma mark - layout
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
    BAKit_UITableViewSetSeparator(self.tableView, BAKit_Color_Cyan, UIEdgeInsetsMake(0, 0, 0, 0));
}

#pragma mark - setter / getter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = BAKit_Color_Gray_11;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.tableView.estimatedRowHeight = BAKit_Margin_44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = @[
                       @[
                           @"获取十六进制的随机颜色【点击测试】\ncell.textLabel.textColor = BAKit_Color_Hex([NSString ba_stringRandomColor]);",
                           ],
                       @[
                           @"转换自身为开头大写字符串",
                           @"自编码成编码的URL字符串",
                           @"string Data 格式化",
                           @"搜索两个字符之间的字符串",
                           @"判断 string 是否为空",
                           @"从身份证号码里提取 生日",
                           @"从身份证号码里提取 性别",
                           @"从身份证号码里提取 年龄",
                           @"获取手机的 IP 地址"
                           ],
                       @[
                           @"手机号码格式化样式：344【中间空格】，示例：13855556666 --> 138 5555 6666",
                           @"手机号码格式化样式：3*4【中间4位为*】，示例：13855556666 --> 138****6666",
                           @"数字格式化样式，示例：12345678.89 --> 12,345,678.89",
                           @"格式化为货币样式，示例：12345678.89 --> 12,345,678.89",
                           @"格式化为科学计数样式，示例：12345678.89 --> 1.234567889E7",
                           @"格式化为英文输出样式（注：此处根据系统语言输出），示例：12345678.89 --> 一千二百三十四万五千六百七十八点八九",
                           @"格式化为序数样式，示例：12345678.89 --> 第1234,5679",
                           @"格式化为货币ISO代码样式样式，示例：123456889.86 --> CNY123,456,889.86",
                           @"格式化为货币多样式，示例：12345678.89 --> USD 12,345,678.89",
                           @"保留纯数字",
                           @"点赞数处理：2.1千，3.4万",
                           @"判断是否为 int 类型",
                           @"判断是否为 float 类型"
                           ],
                       @[
                           @"在接收器的给定范围内查找并返回给定字符串的范围"
                           ],
                       @[
                           @"获取文字 size，根据字体大小",
                           @"获取文字 size，根据字体",
                           @"计算一个字符串的 height，【限定 font、width】",
                           @"计算一个 attributeString 的 height，【限定 attributeDictionary、width】"
                           ],
                       @[
                           @"获取系统当前日期和时间【YYYY-MM-dd HH:mm:ss】",
                           @"获取系统当前日期和时间 【自定义 formatString】",
                           @"时间戳转换【YYYY-MM-dd HH:mm:ss】",
                           @"时间戳转换时间【自定义 formatString】",
                           @"当前时间【YYYY-MM-dd HH:mm:ss】转换成时间戳【10位数，如：1492672164】",
                           @"最简单的写法，自定义获取单个当前年、月、日、时、分、周",
                           @"判断当前时间是否在 fromHour 和 toHour 之间",
                           @"计算上报时间差: 几分钟前，几天前，传入时间戳，自动解析"
                           ],
                       @[],
                       @[],
                       @[
                           @"给 button 添加下划线"
                           ],
                       @[
                           @"创建一个MD5字符串【123456】",
                           @"创建一个SHA1字符串【123456】",
                           @"创建一个SHA256字符串【123456】",
                           @"创建一个SHA512字符串【123456】",
                           @"Base64 编码【123456】",
                           @"Base64 解码【123456 Base64 加密后解密】"
                           ],
                       @[
                           @"将文字转换成表情字符【[微笑]】",
                           @"将表情字符转换成文字【😃】"
                           ],
                       @[
                           @"富文本处理 类"
                           ]
                       ];
    }
    return _dataArray;
}

- (NSArray *)sectionDataArray
{
    if (!_sectionDataArray)
    {
        _sectionDataArray = @[
                              @"NSString+BAColor.h【颜色处理类】",
                              @"NSString+BAKit.h【常用方法处理类】",
                              @"NSString+BANSNumber.h【NSNumber处理类】",
                              @"NSString+BARange.h【NSRange处理类】",
                              @"NSString+BASize.h【计算宽高、size处理类】",
                              @"NSString+BATime.h【时间处理类】",
                              @"NSString+BATransform.h【转换处理类】",
                              @"NSString+BATrims.h【特殊文字处理类:html等】",
                              @"NSString+BAUIButton.h【button 下划线】",
                              @"NSString+BAEncrypt.h【安全加密类】",
                              @"NSString+BAEmoji.h【表情处理类】",
                              @"NSMutableAttributedString+BAKit.h"
                              ];
    }
    return _sectionDataArray;
}


@end
