//
//  HBViewController.m
//  HBPhoneNumberFormatter
//
//  Created by HaykBrsoyan on 06/25/2017.
//  Copyright (c) 2017 HaykBrsoyan. All rights reserved.
//

#import "HBViewController.h"

@interface HBViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *myTextFielf;

@end

@implementation HBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myTextFielf.delegate = self;
}


@end
