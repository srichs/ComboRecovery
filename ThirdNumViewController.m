//
//  ThirdNumViewController.m
//  Combo Recovery
//
//  Created by srich on 11/8/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import "ComboRecovery.h"
#import "ThirdNumViewController.h"
#import "CRTableViewController.h"
#import "RPViewController.h"

@interface ThirdNumViewController ()

@end

@implementation ThirdNumViewController

#pragma UITextField

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString*)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newString.length > 0) {
        if ((textField.text.length + string.length - range.length) > 2)
            return NO;
        if ((textField.text.length + string.length - range.length) > 1) {
            if ([newString characterAtIndex:0] == '0')
                return NO;
            else if ([newString characterAtIndex:0] > '3')
                return NO;
        }
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.thirdNum && [self.thirdNum.text isEqualToString:@"0"]) {
        self.thirdNum.text = @"";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    recRed = [UIColor colorWithRed:232.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f];
    self.thirdNum.tintColor = [UIColor redColor];
    [self setKeyboards];
    recover = [[ComboRecovery alloc] init];
}

- (void)setKeyboards {
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32)];
    [toolbar setBarStyle:UIBarStyleDefault];
    toolbar.barTintColor = recRed;
    UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard:)];
    doneBtn.tintColor = [UIColor whiteColor];
    [toolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, doneBtn, nil]];
    
    self.thirdNum.delegate = self;
    self.thirdNum.inputAccessoryView = toolbar;
}

- (IBAction)clearPressed:(id)sender {
    self.thirdNum.text = @"";
    recover = [[ComboRecovery alloc] init];
}

- (IBAction)getCombosPressed:(id)sender {
    [self resignAllKeyboards];
    recover = [[ComboRecovery alloc] init];
    [recover setThirdNumber:[[self.thirdNum text] doubleValue]];
    [recover fillFirstNumberArray];
    [recover fillSecondNumberArray];
    [recover fillCombinationsArray];
    [self alertLogic];
}

- (IBAction)useRPPressed:(id)sender {
    [self resignAllKeyboards];
    recover = [[ComboRecovery alloc] init];
    [recover setThirdNumber:[[self.thirdNum text] doubleValue]];
    [recover fillFirstNumberArray];
    [recover fillSecondNumberArray];
    [self alertLogic2];
}

- (void)alertLogic {
    if ([self.thirdNum.text isEqual:@""])
        [self alert2];
    else if ([recover thirdNumber] < 0 || [recover thirdNumber] > 39)
        [self alert1];
    else
        [self performSegueWithIdentifier:@"thirdNumSegue" sender:self];
}

- (void)alertLogic2 {
    if ([self.thirdNum.text isEqual:@""])
        [self alert2];
    else if ([recover thirdNumber] < 0 || [recover thirdNumber] > 39)
        [self alert1];
    else
        [self performSegueWithIdentifier:@"thirdUseRPSegue" sender:self];
}

- (void)alert1 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"The third number of the combination should be a number on the dial. Please enter an integer from 0 to 39."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert2 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"Please enter the third number of the combination."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)resignAllKeyboards {
    [self.thirdNum resignFirstResponder];
}

- (IBAction)dismissKeyboard:(id)sender {
    [self resignAllKeyboards];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"thirdNumSegue"]) {
        CRTableViewController *controller = (CRTableViewController *)segue.destinationViewController;
        controller.recover = (ComboRecovery *) recover;
        controller.isKamkar = NO;
    }
    else if([segue.identifier isEqualToString:@"thirdUseRPSegue"]) {
        RPViewController *controller = (RPViewController *)segue.destinationViewController;
        controller.recover = (ComboRecovery *) recover;
    }
}

@end
