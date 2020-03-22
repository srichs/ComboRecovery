//
//  SaveComboViewController.m
//  Combo Recovery
//
//  Created by srich on 7/5/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "SaveComboTableViewController.h"
#import "SaveComboViewController.h"
#import "MainTableViewController.h"

@implementation SaveComboViewController : UIViewController

#define debug 0

#pragma UITextField

- (BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString*)string {
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newString.length > 0) {
        if ((textField.text.length + string.length - range.length) > 19)
            return NO;
    }
    return YES;
}

#pragma UIPickerView

- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 7;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 1)
        return digitArray.count;
    else if (component == 2)
        return 1;
    else if (component == 3)
        return digitArray.count;
    else if (component == 4)
        return 1;
    else if (component == 5)
        return digitArray.count;
    else
        return 0;
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 1)
        return [digitArray objectAtIndex:row];
    else if (component == 2)
        return @"-";
    else if (component == 3)
        return [digitArray objectAtIndex:row];
    else if (component == 4)
        return @"-";
    else if (component == 5)
        return [digitArray objectAtIndex:row];
    else
        return nil;
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 1) {
        firstDigit = (int)[comboPicker selectedRowInComponent:1];
    }
    else if (component == 3) {
        secondDigit = (int)[comboPicker selectedRowInComponent:3];
    }
    else if (component == 5) {
        thirdDigit = (int)[comboPicker selectedRowInComponent:5];
    }
    self.comboString = [[[[NSString stringWithFormat:@"%i",firstDigit] stringByAppendingString:@" - "] stringByAppendingString:[[NSString stringWithFormat:@"%i",secondDigit] stringByAppendingString:@" - "]] stringByAppendingString:[NSString stringWithFormat:@"%i",thirdDigit]];
    self.comboField.text = self.comboString;
}

#pragma UIView

- (void)viewDidLoad
{
    [super viewDidLoad];
    recRed = [UIColor colorWithRed:232.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f];
    self.comboField.tintColor = [UIColor redColor];
    self.nameField.tintColor = [UIColor redColor];
    self.locationField.tintColor = [UIColor redColor];
    
    digitArray = [self zeroToForty];
    [self setupPickers];
    [self setDefaults];
    
    if (self.isNew == YES || self.isFromList == YES) {
        self.navigationItem.title = @"New Combo";
    }
    else {
        self.navigationItem.title = @"Edit Combo";
    }
    if (debug == 1) {
        NSLog(@"View Load Complete");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
        
    }
}

#pragma User Interface

- (IBAction)dismissKeyboard:(id)sender {
    [self.comboField resignFirstResponder];
    [self.nameField resignFirstResponder];
    [self.locationField resignFirstResponder];
    if (debug == 1) {
        NSLog(@"Keyboard Dismissed");
    }
}

- (IBAction)resetPressed:(id)sender {
    self.nameField.text = @"";
    self.locationField.text = @"";
    self.comboField.text = @"0 - 0 - 0";
    self.comboString = @"";
    
    [comboPicker reloadAllComponents];
    [comboPicker selectRow:0 inComponent:1 animated:NO];
    [comboPicker selectRow:0 inComponent:3 animated:NO];
    [comboPicker selectRow:0 inComponent:5 animated:NO];
}

- (IBAction)savePressed:(id)sender {
    self.nameString = self.nameField.text;
    self.locationString = self.locationField.text;
    if ([self.nameString isEqualToString:@""])
        [self alert];
    else if ([self.locationString isEqualToString:@""])
        [self alert2];
    else if ([self.comboString isEqualToString:@"0 - 0 - 0"])
        [self alert3];
    else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *nameArr = [[defaults objectForKey:@"nameArray"] mutableCopy];
        NSMutableArray *locationArr = [[defaults objectForKey:@"locationArray"] mutableCopy];
        NSMutableArray *comboArr = [[defaults objectForKey:@"comboArray"] mutableCopy];
        
        BOOL sameName = NO;
        BOOL sameCombo = NO;
        
        for (int i = 0; i < nameArr.count; i++) {
            if ([[nameArr objectAtIndex:i] isEqualToString:self.nameString]) {
                if (self.isNew) {
                    sameName = YES;
                }
                else if (self.isFromList) {
                    sameName = YES;
                }
                else if (!self.isNew) {
                    if (i != self.index) {
                        sameName = YES;
                    }
                }
            }
        }
        
        for (int i = 0; i < comboArr.count; i++) {
            if ([[comboArr objectAtIndex:i] isEqualToString:self.comboString]) {
                if (self.isNew) {
                    sameCombo = YES;
                }
                else if (self.isFromList) {
                    sameCombo = YES;
                }
                else if (!self.isNew) {
                    if (i != self.index) {
                        sameCombo = YES;
                    }
                }
            }
        }
        
        if (sameName)
            [self alert4];
        else if (sameCombo)
            [self alert5];
        else {
            if (self.isNew == YES || self.isFromList == YES) {
                [nameArr addObject:self.nameString];
                [locationArr addObject:self.locationString];
                [comboArr addObject:self.comboString];
                
                if (debug == 1) {
                    NSLog(@"New Combo Save");
                }
            }
            else {
                [nameArr replaceObjectAtIndex:self.index withObject:self.nameString];
                [locationArr replaceObjectAtIndex:self.index withObject:self.locationString];
                [comboArr replaceObjectAtIndex:self.index withObject:self.comboString];
                
                if (debug == 1) {
                    NSLog(@"Edit Combo Save");
                }
            }
            
            [defaults setObject:nameArr forKey:@"nameArray"];
            [defaults setObject:locationArr forKey:@"locationArray"];
            [defaults setObject:comboArr forKey:@"comboArray"];
            [defaults synchronize];
            
            if (self.isFromList)
                [self performSegueWithIdentifier:@"savedCombo" sender:self];
            else
                [self performSegueWithIdentifier:@"savedLock" sender:self];
        }
        
        if (debug == 1) {
            NSLog(@"Save Complete");
        }
    }
}

- (IBAction)cancelPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma Setup

- (void)setDefaults {
    if (self.isNew) {
        self.comboString = @"0 - 0 - 0";
        self.nameString = @"";
        self.locationString = @"";
        
        self.nameField.text = self.nameString;
        self.locationField.text = self.locationString;
        self.comboField.text = self.comboString;
        
        [comboPicker reloadAllComponents];
        [comboPicker selectRow:0 inComponent:1 animated:NO];
        [comboPicker selectRow:0 inComponent:3 animated:NO];
        [comboPicker selectRow:0 inComponent:5 animated:NO];
    }
    else if (self.isFromList) {
        NSArray *comboArray = [self.comboString componentsSeparatedByString:@" - "];
        firstDigit = [[comboArray objectAtIndex:0] intValue];
        secondDigit = [[comboArray objectAtIndex:1] intValue];
        thirdDigit = [[comboArray objectAtIndex:2] intValue];
        
        self.nameString = @"";
        self.locationString = @"";
        
        self.nameField.text = self.nameString;
        self.locationField.text = self.locationString;
        self.comboField.text = self.comboString;
        
        [comboPicker reloadAllComponents];
        [comboPicker selectRow:firstDigit inComponent:1 animated:NO];
        [comboPicker selectRow:secondDigit inComponent:3 animated:NO];
        [comboPicker selectRow:thirdDigit inComponent:5 animated:NO];
    }
    else {
        NSArray *comboArray = [self.comboString componentsSeparatedByString:@" - "];
        firstDigit = [[comboArray objectAtIndex:0] intValue];
        secondDigit = [[comboArray objectAtIndex:1] intValue];
        thirdDigit = [[comboArray objectAtIndex:2] intValue];
        
        self.nameField.text = self.nameString;
        self.locationField.text = self.locationString;
        self.comboField.text = self.comboString;
        
        [comboPicker reloadAllComponents];
        [comboPicker selectRow:firstDigit inComponent:1 animated:NO];
        [comboPicker selectRow:secondDigit inComponent:3 animated:NO];
        [comboPicker selectRow:thirdDigit inComponent:5 animated:NO];
    }
}

- (NSArray *)zeroToForty {
    NSMutableArray *dArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 40; i++) {
        [dArray addObject:[NSString stringWithFormat:@"%i",i]];
    }
    return dArray;
}

- (void)setupPickers {
    if (pickerToolbar == nil) {
        pickerToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32)];
        [pickerToolbar setBarStyle:UIBarStyleDefault];
        pickerToolbar.barTintColor = recRed;
        pickerToolbar.translucent = NO;
        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard:)];
        doneBtn.tintColor = [UIColor whiteColor];
        [pickerToolbar setItems:[[NSArray alloc] initWithObjects: extraSpace, doneBtn, nil]];
    }
    
    self.nameField.delegate = self;
    self.locationField.delegate = self;
    
    self.nameField.inputAccessoryView = pickerToolbar;
    self.locationField.inputAccessoryView = pickerToolbar;
    
    comboPicker = [[UIPickerView alloc] init];
    comboPicker.dataSource = self;
    comboPicker.delegate = self;
    comboPicker.backgroundColor = [UIColor whiteColor];
    self.comboField.inputAccessoryView = pickerToolbar;
    self.comboField.inputView = comboPicker;
    self.comboField.inputView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 162);
    
    if (debug == 1) {
        NSLog(@"UIPickerView Complete");
    }
}

#pragma UIAlertView

- (void)alert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"Please enter a lock name that is at least one character long."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert2 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"Please enter a location that is at least one character long."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert3 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"Please enter a combination."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert4 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"This lock name already exists. Lock names must be unique. Please enter a different lock name."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert5 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"This combination has already been saved. Combinations must be unique. Please enter a different combination or edit the existing saved combination."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma UIStoryboardSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"savedLock"]) {
        SaveComboTableViewController *controller = (SaveComboTableViewController *)segue.destinationViewController;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        controller.comboArray = [[defaults objectForKey:@"comboArray"] mutableCopy];
        controller.nameArray = [[defaults objectForKey:@"nameArray"] mutableCopy];
        controller.locationArray = [[defaults objectForKey:@"locationArray"] mutableCopy];
        [controller.comboTable reloadData];
        if (debug == 1) {
            NSLog(@"Saved Lock Segue");
        }
    }
    else if([segue.identifier isEqualToString:@"savedCombo"]) {
        MainTableViewController *controller = (MainTableViewController *)segue.destinationViewController;
        controller.fromSavedCombo = (BOOL) YES;
        if (debug == 1) {
            NSLog(@"Saved Combo Segue");
        }
    }
}

@end
