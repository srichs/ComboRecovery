//
//  RPViewController.m
//  Combo Recovery
//
//  Created by srich on 7/18/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "ComboRecovery.h"
#import "CRTableViewController.h"
#import "RPViewController.h"

@implementation RPViewController : UIViewController

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
    if (textField == self.resPoint && [self.resPoint.text isEqualToString:@"0"]) {
        self.resPoint.text = @"";
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    recRed = [UIColor colorWithRed:232.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f];
    self.resPoint.tintColor = [UIColor redColor];
    [self setKeyboards];
}

- (void)setKeyboards {
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32)];
    [toolbar setBarStyle:UIBarStyleDefault];
    toolbar.barTintColor = recRed;
    UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard:)];
    doneBtn.tintColor = [UIColor whiteColor];
    [toolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, doneBtn, nil]];
    
    self.resPoint.delegate = self;
    self.resPoint.inputAccessoryView = toolbar;
}

- (IBAction)clearPressed:(id)sender {
    self.resPoint.text = @"";
}

- (IBAction)getCombosPressed:(id)sender {
    [self resignAllKeyboards];
    [self.recover.combinationsArray removeAllObjects];
    [self.recover sortArrayForRP:self.resPoint.text.intValue];
    [self.recover fillCombinationsArray];
    [self alertLogic];
}

- (void)alertLogic {
    if ([self.resPoint.text isEqual:@""])
        [self alert2];
    else if (self.resPoint.text.intValue < 0 || self.resPoint.text.intValue > 39)
        [self alert1];
    else {
        [self alert3];
        [self performSegueWithIdentifier:@"rpSegue" sender:self];
    }
}

- (void)alert1 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"The resistance point of the combination should be a number on the dial. Please enter an integer from 0 to 39."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert2 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"Please enter the resistance point of the combination lock."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert3 {
    NSString *partOne = @"The third combination number of this lock is ";
    NSString *thirdNum = [NSString stringWithFormat:@"%i",self.recover.thirdNumber];
    NSString *partTwo = @". Write this number down or remember it in case you need it later.";
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Third Combination Number"
                                            message:[[partOne stringByAppendingString:thirdNum] stringByAppendingString:partTwo]
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)resignAllKeyboards {
    [self.resPoint resignFirstResponder];
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
    if([segue.identifier isEqualToString:@"rpSegue"]) {
        CRTableViewController *controller = (CRTableViewController *)segue.destinationViewController;
        controller.recover = (ComboRecovery *) self.recover;
        controller.isKamkar = NO;
    }
}

@end
