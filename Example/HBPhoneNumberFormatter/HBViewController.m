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
    self.formatter = [[HBPhoneNumberFormatter alloc] initWithFormatting:@"(111) 1111-111"];
    self.formatter.shakeSize = 20;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //check textField
    if ([textField isEqual:self.myTextField]) {
        return [self.formatter textField:self.myTextField shouldChangeCharactersInRange:range replacementString:string];
    }
    return YES;
}

//isValidation
- (IBAction)isValidationisValidationAction {
    BOOL isValid = [self.formatter numberIsValidPhoneText:self.myTextField.text];
    
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:isValid ? @"textField is valid" : @"textField is not valid"
                                message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end
