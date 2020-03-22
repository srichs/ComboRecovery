//
//  KamkarViewController.m
//  Combo Recovery
//
//  Created by srich on 7/25/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "KamkarReduction.h"
#import "KamkarViewController.h"
#import "CRTableViewController.h"

@implementation KamkarViewController : UIViewController

#pragma UIPickerView

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return pickArray.count;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [pickArray objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (pickerView == firstLockPicker) {
        kamRec.firstLock = (int)[firstLockPicker selectedRowInComponent:0];
        self.firstLockField.text = [NSString stringWithFormat:@"%d", kamRec.firstLock];
    }
    else if (pickerView == secondLockPicker) {
        kamRec.secondLock = (int)[secondLockPicker selectedRowInComponent:0];
        self.secondLockField.text = [NSString stringWithFormat:@"%d", kamRec.secondLock];
    }
}

#pragma UITextField

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString*)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray  *arrayOfString = [newString componentsSeparatedByString:@"."];
    
    if (newString.length > 0) {
        if (arrayOfString.count > 2)
            return NO;
        
        if (arrayOfString.count == 2) {
            NSString *decStr = [arrayOfString objectAtIndex:1];
            if (decStr.length > 2)
                return NO;
            else if (decStr.length > 1) {
                if ([decStr characterAtIndex:0] == '5')
                    return NO;
            }
            else if (decStr.length > 0) {
                if ([decStr characterAtIndex:0] == '0' || [decStr characterAtIndex:0] == '1' || [decStr characterAtIndex:0] == '2' || [decStr characterAtIndex:0] == '3' || [decStr characterAtIndex:0] == '4' || [decStr characterAtIndex:0] == '6' || [decStr characterAtIndex:0] == '7' || [decStr characterAtIndex:0] == '8' || [decStr characterAtIndex:0] == '9')
                    return NO;
            }
        }
        else if (arrayOfString.count == 1) {
            NSString *decStr = [arrayOfString objectAtIndex:0];
            if (decStr.length > 1) {
                if ([decStr characterAtIndex:0] == '0')
                    return NO;
                else if ([decStr characterAtIndex:0] > '3')
                    return NO;
            }
            if (decStr.length > 2)
                return NO;
        }
    }
    return YES;
}

#pragma UIView

- (void)viewDidLoad
{
    [super viewDidLoad];
    recRed = [UIColor colorWithRed:232.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f];
    self.firstLockField.tintColor = [UIColor redColor];
    self.secondLockField.tintColor = [UIColor redColor];
    self.resPointField.tintColor = [UIColor redColor];
    pickArray = [KamkarReduction zeroToTen];
    [self setKeyboards];
    kamRec = [[KamkarReduction alloc] init];
}

- (void)setKeyboards {
    if (toolbar == nil) {
        toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32)];
        [toolbar setBarStyle:UIBarStyleDefault];
        toolbar.barTintColor = recRed;
        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard:)];
        doneBtn.tintColor = [UIColor whiteColor];
        [toolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, doneBtn, nil]];
    }

    firstLockPicker = [[UIPickerView alloc] init];
    firstLockPicker.dataSource = self;
    firstLockPicker.delegate = self;
    firstLockPicker.backgroundColor = [UIColor whiteColor];
    self.firstLockField.inputAccessoryView = toolbar;
    self.firstLockField.inputView = firstLockPicker;
    self.firstLockField.inputView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 162);
    
    secondLockPicker = [[UIPickerView alloc] init];
    secondLockPicker.dataSource = self;
    secondLockPicker.delegate = self;
    secondLockPicker.backgroundColor = [UIColor whiteColor];
    self.secondLockField.inputAccessoryView = toolbar;
    self.secondLockField.inputView = secondLockPicker;
    self.secondLockField.inputView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 162);
    
    self.resPointField.delegate = self;
    self.resPointField.inputAccessoryView = toolbar;
    
    [firstLockPicker selectRow:0 inComponent:0 animated:NO];
    [firstLockPicker reloadAllComponents];
    [secondLockPicker selectRow:0 inComponent:0 animated:NO];
    [secondLockPicker reloadAllComponents];
}

- (IBAction)clearPressed:(id)sender {
    self.firstLockField.text = @"";
    self.secondLockField.text = @"";
    self.resPointField.text = @"";
    kamRec = [[KamkarReduction alloc] init];
}

- (IBAction)getCombosPressed:(id)sender {
    if ([self.firstLockField.text isEqual:@""])
        [self alert1];
    else if ([self.secondLockField.text isEqual:@""])
        [self alert2];
    else if ([self.resPointField.text isEqual:@""])
        [self alert3];
    else if (self.firstLockField.text.intValue == self.secondLockField.text.intValue)
        [self alert5];
    else {
        [self resignAllKeyboards];
        kamRec = [[KamkarReduction alloc] init];
        kamRec.firstLock = self.firstLockField.text.intValue;
        kamRec.secondLock = self.secondLockField.text.intValue;
        kamRec.resistantPoint = self.resPointField.text.doubleValue;
        [kamRec findFirstAndSecondNumbers];
        [self alertLogic];
    }
}

- (void)alertLogic {
    if (kamRec.possibleThirdNumbers.count == 1) {
        kamRec.thirdNumber = [[kamRec.possibleThirdNumbers objectAtIndex:0] intValue];
        [kamRec findCombinations];
        [self performSegueWithIdentifier:@"kamkarSegue" sender:self];
    }
    else
        [self alert4];
}

- (void)alert1 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"Please enter the first lock number of the lock."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert2 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"Please enter the second lock number of the lock."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert3 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"Please enter the resistance point of the lock."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert4 {
    NSString *firstNum = [NSString stringWithFormat:@"%@",[kamRec.possibleThirdNumbers objectAtIndex:0]];
    NSString *secondNum = [NSString stringWithFormat:@"%@",[kamRec.possibleThirdNumbers objectAtIndex:1]];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Select a Third Number"
                                            message:@"Apply outward pressure to the shackle and check the range at each number. Select the number with the greater range."
                                            preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:firstNum style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        self->kamRec.thirdNumber = [[self->kamRec.possibleThirdNumbers objectAtIndex:0] intValue];
        [self->kamRec findCombinations];
        [self performSegueWithIdentifier:@"kamkarSegue" sender:self];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:secondNum style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        self->kamRec.thirdNumber = [[self->kamRec.possibleThirdNumbers objectAtIndex:1] intValue];
        [self->kamRec findCombinations];
        [self performSegueWithIdentifier:@"kamkarSegue" sender:self];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert5 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"The first and second lock numbers cannot be the same number."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)resignAllKeyboards {
    [self.firstLockField resignFirstResponder];
    [self.secondLockField resignFirstResponder];
    [self.resPointField resignFirstResponder];
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
    if([segue.identifier isEqualToString:@"kamkarSegue"]) {
        CRTableViewController *controller = (CRTableViewController *)segue.destinationViewController;
        controller.kamRec = (KamkarReduction *) kamRec;
        controller.isKamkar = YES;
    }
}

@end
