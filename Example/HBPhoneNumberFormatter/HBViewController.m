//
//  HBViewController.m
//  HBPhoneNumberFormatter
//
//  Created by HaykBrsoyan on 06/25/2017.
//  Copyright (c) 2017 HaykBrsoyan. All rights reserved.
//

#import "HBViewController.h"
#import <HBPhoneNumberFormatter/HBPhoneNumberFormatter.h>

@interface HBViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *myTextField;
@property (nonatomic) HBPhoneNumberFormatter *formatter;
@end

@implementation HBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTextField.delegate = self;
    
    self.formatter = [[HBPhoneNumberFormatter alloc] initWithFormatting:@" (111) 1111:111"];
    
    // You can set country code prefix for your text field.
    [self.formatter setCountryName:@"United States" textField:self.myTextField];
    
    // Change default shake config.
    self.formatter.shakeSize = 10;          // default is 5
    self.formatter.shakeDuration = 0.2;     // default is 0.1
    self.formatter.shakeRepeatCount = 4;    // default is 2
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Check textField
    if ([textField isEqual:self.myTextField]) {
        // Your code here.
        return [self.formatter textField:self.myTextField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

// Check Formatter isValidation or not
- (IBAction)isValidationisValidationAction {
    BOOL isValid = [self.formatter numberIsValidPhoneText:self.myTextField.text];
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:isValid ? @"TextField is valid" : @"TextField is not valid"
                                message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end
