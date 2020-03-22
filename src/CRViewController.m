//
//  CRViewController.m
//  Combo Recovery
//
//  Created by srich on 11/7/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import "ComboRecovery.h"
#import "CRViewController.h"
#import "CRTableViewController.h"
#import "ThirdNumViewController.h"
#import "RPViewController.h"

@interface CRViewController ()

@end

@implementation CRViewController

- (void)setKeyboards {
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 32)];
    [toolbar setBarStyle:UIBarStyleDefault];
    toolbar.barTintColor = recRed;
    UIBarButtonItem *nextBtn = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextField:)];
    nextBtn.tintColor = [UIColor whiteColor];
    UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard:)];
    doneBtn.tintColor = [UIColor whiteColor];
    [toolbar setItems:[[NSArray alloc] initWithObjects: nextBtn, extraSpace, doneBtn, nil]];
    
    self.stickyOne.delegate = self;
    self.stickyTwo.delegate = self;
    self.stickyThree.delegate = self;
    self.stickyFour.delegate = self;
    self.stickyFive.delegate = self;
    self.stickySix.delegate = self;
    self.stickySeven.delegate = self;
    self.stickyEight.delegate = self;
    self.stickyNine.delegate = self;
    self.stickyTen.delegate = self;
    self.stickyEleven.delegate = self;
    self.stickyTwelve.delegate = self;
    
    self.stickyOne.inputAccessoryView = toolbar;
    self.stickyTwo.inputAccessoryView = toolbar;
    self.stickyThree.inputAccessoryView = toolbar;
    self.stickyFour.inputAccessoryView = toolbar;
    self.stickyFive.inputAccessoryView = toolbar;
    self.stickySix.inputAccessoryView = toolbar;
    self.stickySeven.inputAccessoryView = toolbar;
    self.stickyEight.inputAccessoryView = toolbar;
    self.stickyNine.inputAccessoryView = toolbar;
    self.stickyTen.inputAccessoryView = toolbar;
    self.stickyEleven.inputAccessoryView = toolbar;
    self.stickyTwelve.inputAccessoryView = toolbar;
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
                else if ([decStr characterAtIndex:0] == '2' || ([decStr characterAtIndex:0] == '7'))
                    if ([decStr characterAtIndex:1] == '0' || [decStr characterAtIndex:1] == '1' || [decStr characterAtIndex:1] == '2' || [decStr characterAtIndex:1] == '3' || [decStr characterAtIndex:1] == '4' || [decStr characterAtIndex:1] == '6' || [decStr characterAtIndex:1] == '7' || [decStr characterAtIndex:1] == '8' || [decStr characterAtIndex:1] == '9')
                        return NO;
            }
            else if (decStr.length > 0) {
                if ([decStr characterAtIndex:0] == '0' || [decStr characterAtIndex:0] == '1' || [decStr characterAtIndex:0] == '3' || [decStr characterAtIndex:0] == '4' || [decStr characterAtIndex:0] == '6' || [decStr characterAtIndex:0] == '8' || [decStr characterAtIndex:0] == '9')
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

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    if (self.view.bounds.size.height > 660) {
        [self.view setFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
    }
    else if (self.view.bounds.size.height > 560) {
        [self.view setFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
    }
    else {
        if (self.stickySix.isFirstResponder || self.stickyFive.isFirstResponder || self.stickyTwelve.isFirstResponder || self.stickyEleven.isFirstResponder)
            [self.view setFrame:CGRectMake(0,-64,self.view.bounds.size.width,self.view.bounds.size.height)];
        else
            [self.view setFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
    }
}

-(void)keyboardDidHide:(NSNotification *)notification {
    [self.view setFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
}

#pragma UIView

- (void)viewDidLoad {
    [super viewDidLoad];
    recRed = [UIColor colorWithRed:232.0/255.0f green:0.0/255.0f blue:0.0/255.0f alpha:1.0f];
    self.stickyOne.tintColor = [UIColor redColor];
    self.stickyTwo.tintColor = [UIColor redColor];
    self.stickyThree.tintColor = [UIColor redColor];
    self.stickyFour.tintColor = [UIColor redColor];
    self.stickyFive.tintColor = [UIColor redColor];
    self.stickySix.tintColor = [UIColor redColor];
    self.stickySeven.tintColor = [UIColor redColor];
    self.stickyEight.tintColor = [UIColor redColor];
    self.stickyNine.tintColor = [UIColor redColor];
    self.stickyTen.tintColor = [UIColor redColor];
    self.stickyEleven.tintColor = [UIColor redColor];
    self.stickyTwelve.tintColor = [UIColor redColor];
    [self setKeyboards];
    recover = [[ComboRecovery alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)clearPressed:(id)sender {
    self.stickyOne.text = @"";
    self.stickyTwo.text = @"";
    self.stickyThree.text = @"";
    self.stickyFour.text = @"";
    self.stickyFive.text = @"";
    self.stickySix.text = @"";
    self.stickySeven.text = @"";
    self.stickyEight.text = @"";
    self.stickyNine.text = @"";
    self.stickyTen.text = @"";
    self.stickyEleven.text = @"";
    self.stickyTwelve.text = @"";
    recover = [[ComboRecovery alloc] init];
}

- (IBAction)getCombosPressed:(id)sender {
    [self resignAllKeyboard];
    recover = [[ComboRecovery alloc] init];
    
    if ([self.stickyOne.text isEqualToString:@""] || [self.stickyTwo.text isEqualToString:@""] || [self.stickyThree.text isEqualToString:@""] || [self.stickyFour.text isEqualToString:@""] || [self.stickyFive.text isEqualToString:@""] || [self.stickySix.text isEqualToString:@""] || [self.stickySeven.text isEqualToString:@""] || [self.stickyEight.text isEqualToString:@""] || [self.stickyNine.text isEqualToString:@""] || [self.stickyTen.text isEqualToString:@""] || [self.stickyEleven.text isEqualToString:@""] || [self.stickyTwelve.text isEqualToString:@""]) {
        [recover setAlert3:YES];
    }
    
    [recover setStickyOne:[[self.stickyOne text] doubleValue]];
    [recover setStickyTwo:[[self.stickyTwo text] doubleValue]];
    [recover setStickyThree:[[self.stickyThree text] doubleValue]];
    [recover setStickyFour:[[self.stickyFour text] doubleValue]];
    [recover setStickyFive:[[self.stickyFive text] doubleValue]];
    [recover setStickySix:[[self.stickySix text] doubleValue]];
    [recover setStickySeven:[[self.stickySeven text] doubleValue]];
    [recover setStickyEight:[[self.stickyEight text] doubleValue]];
    [recover setStickyNine:[[self.stickyNine text] doubleValue]];
    [recover setStickyTen:[[self.stickyTen text] doubleValue]];
    [recover setStickyEleven:[[self.stickyEleven text] doubleValue]];
    [recover setStickyTwelve:[[self.stickyTwelve text] doubleValue]];
    
    if ([recover stickyOne] >= 40 || [recover stickyTwo] >= 40 || [recover stickyThree] >= 40 || [recover stickyFour] >= 40 || [recover stickyFive] >= 40 || [recover stickySix] >= 40 || [recover stickySeven] >= 40 || [recover stickyEight] >= 40 || [recover stickyNine] >= 40 || [recover stickyTen] >= 40 || [recover stickyEleven] >= 40 || [recover stickyTwelve] >= 40) {
        [recover setAlert4:YES];
    }
    
    [recover fillStickyNums];
    [recover findThirdNumber];
    [recover fillFirstNumberArray];
    [recover fillSecondNumberArray];
    [recover fillCombinationsArray];
    [self alertLogic];
}

- (IBAction)useRPPressed:(id)sender {
    [self resignAllKeyboard];
    recover = [[ComboRecovery alloc] init];
    
    if ([self.stickyOne.text isEqualToString:@""] || [self.stickyTwo.text isEqualToString:@""] || [self.stickyThree.text isEqualToString:@""] || [self.stickyFour.text isEqualToString:@""] || [self.stickyFive.text isEqualToString:@""] || [self.stickySix.text isEqualToString:@""] || [self.stickySeven.text isEqualToString:@""] || [self.stickyEight.text isEqualToString:@""] || [self.stickyNine.text isEqualToString:@""] || [self.stickyTen.text isEqualToString:@""] || [self.stickyEleven.text isEqualToString:@""] || [self.stickyTwelve.text isEqualToString:@""]) {
        [recover setAlert3:YES];
    }
    
    [recover setStickyOne:[[self.stickyOne text] doubleValue]];
    [recover setStickyTwo:[[self.stickyTwo text] doubleValue]];
    [recover setStickyThree:[[self.stickyThree text] doubleValue]];
    [recover setStickyFour:[[self.stickyFour text] doubleValue]];
    [recover setStickyFive:[[self.stickyFive text] doubleValue]];
    [recover setStickySix:[[self.stickySix text] doubleValue]];
    [recover setStickySeven:[[self.stickySeven text] doubleValue]];
    [recover setStickyEight:[[self.stickyEight text] doubleValue]];
    [recover setStickyNine:[[self.stickyNine text] doubleValue]];
    [recover setStickyTen:[[self.stickyTen text] doubleValue]];
    [recover setStickyEleven:[[self.stickyEleven text] doubleValue]];
    [recover setStickyTwelve:[[self.stickyTwelve text] doubleValue]];
    
    if ([recover stickyOne] >= 40 || [recover stickyTwo] >= 40 || [recover stickyThree] >= 40 || [recover stickyFour] >= 40 || [recover stickyFive] >= 40 || [recover stickySix] >= 40 || [recover stickySeven] >= 40 || [recover stickyEight] >= 40 || [recover stickyNine] >= 40 || [recover stickyTen] >= 40 || [recover stickyEleven] >= 40 || [recover stickyTwelve] >= 40) {
        [recover setAlert4:YES];
    }
    
    [recover fillStickyNums];
    [recover findThirdNumber];
    [recover fillFirstNumberArray];
    [recover fillSecondNumberArray];
    [self alertLogic2];
}

- (void)alertLogic {
    if ([recover alert3] == YES)
        [self alert3];
    else if ([recover alert4] == YES)
        [self alert4];
    else if ([recover alert1] == YES)
        [self alert1];
    else if ([recover alert2] == YES)
        [self alert2];
    else {
        [self alert5];
        [self performSegueWithIdentifier:@"crTableSegue" sender:self];
    }
}

- (void)alertLogic2 {
    if ([recover alert3] == YES)
        [self alert3];
    else if ([recover alert4] == YES)
        [self alert4];
    else if ([recover alert1] == YES)
        [self alert1];
    else if ([recover alert2] == YES)
        [self alert2];
    else {
        [self performSegueWithIdentifier:@"useRPSegue" sender:self];
    }
}

- (void)alert1 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"There should be only 4 or 5 stick points that are whole integers. Check the lock again and adjust the entered numbers as needed."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert2 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"The whole integers entered did not provide a definitive third combination number. If there are only 4 whole integers and they have the same digit in the 1's place, then check each whole integer again and find the number that has a range of 2. Enter that number as the third combination number. Otherwise, check the lock again and adjust the entered numbers as needed."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert3 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"One or more stick points are missing. Please enter all 12 stick points."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert4 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"A stick point should not be greater than 39.75. Check the lock again and ensure that the entered numbers are lower than 40."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert5 {
    NSString *partOne = @"The third combination number of this lock is ";
    NSString *thirdNum = [NSString stringWithFormat:@"%i",recover.thirdNumber];
    NSString *partTwo = @". Write this number down or remember it in case you need it later.";
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Third Combination Number"
                                            message:[[partOne stringByAppendingString:thirdNum] stringByAppendingString:partTwo]
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)nextField:(id)sender {
    if (self.stickyOne.isEditing == YES) {
        [self.stickyOne resignFirstResponder];
        [self.stickyTwo becomeFirstResponder];
    }
    else if (self.stickyTwo.isEditing == YES) {
        [self.stickyTwo resignFirstResponder];
        [self.stickyThree becomeFirstResponder];
    }
    else if (self.stickyThree.isEditing == YES) {
        [self.stickyThree resignFirstResponder];
        [self.stickyFour becomeFirstResponder];
    }
    else if (self.stickyFour.isEditing == YES) {
        [self.stickyFour resignFirstResponder];
        [self.stickyFive becomeFirstResponder];
    }
    else if (self.stickyFive.isEditing == YES) {
        [self.stickyFive resignFirstResponder];
        [self.stickySix becomeFirstResponder];
    }
    else if (self.stickySix.isEditing == YES) {
        [self.stickySix resignFirstResponder];
        [self.stickySeven becomeFirstResponder];
    }
    else if (self.stickySeven.isEditing == YES) {
        [self.stickySeven resignFirstResponder];
        [self.stickyEight becomeFirstResponder];
    }
    else if (self.stickyEight.isEditing == YES) {
        [self.stickyEight resignFirstResponder];
        [self.stickyNine becomeFirstResponder];
    }
    else if (self.stickyNine.isEditing == YES) {
        [self.stickyNine resignFirstResponder];
        [self.stickyTen becomeFirstResponder];
    }
    else if (self.stickyTen.isEditing == YES) {
        [self.stickyTen resignFirstResponder];
        [self.stickyEleven becomeFirstResponder];
    }
    else if (self.stickyEleven.isEditing == YES) {
        [self.stickyEleven resignFirstResponder];
        [self.stickyTwelve becomeFirstResponder];
    }
    else if (self.stickyTwelve.isEditing == YES) {
        [self.stickyTwelve resignFirstResponder];
        [self.stickyOne becomeFirstResponder];
    }
}

- (void)resignAllKeyboard {
    if (self.view.bounds.size.height < 485)
        [self.view setFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
    [self.stickyOne resignFirstResponder];
    [self.stickyTwo resignFirstResponder];
    [self.stickyThree resignFirstResponder];
    [self.stickyFour resignFirstResponder];
    [self.stickyFive resignFirstResponder];
    [self.stickySix resignFirstResponder];
    [self.stickySeven resignFirstResponder];
    [self.stickyEight resignFirstResponder];
    [self.stickyNine resignFirstResponder];
    [self.stickyTen resignFirstResponder];
    [self.stickyEleven resignFirstResponder];
    [self.stickyTwelve resignFirstResponder];
}

- (IBAction)dismissKeyboard:(id)sender {
    [self resignAllKeyboard];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"crTableSegue"]) {
        CRTableViewController *controller = (CRTableViewController *)segue.destinationViewController;
        controller.recover = (ComboRecovery *) recover;
        controller.isKamkar = NO;
    }
    else if([segue.identifier isEqualToString:@"useRPSegue"]) {
        RPViewController *controller = (RPViewController *)segue.destinationViewController;
        controller.recover = (ComboRecovery *) recover;
    }
}

@end
