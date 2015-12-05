//
//  ViewController.m
//  ConfirmationCodeUI
//
//  Created by Manuel Deschamps on 12/4/15.
//  Copyright © 2015 Manuel Deschamps. All rights reserved.
//

#import "ViewController.h"
#import "DGTCodeField.h"

@interface ViewController () <DGTCodeFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *doneLabel;

@property (weak, nonatomic) IBOutlet DGTCodeField *codeField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.codeField.delegate = self;
    
    [self.codeField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) entryIsCompletedWithCode:(NSString *)code
{
    self.doneLabel.hidden = NO;
}

- (void) entryIsIncomplete
{
    self.doneLabel.hidden = YES;
}

@end
