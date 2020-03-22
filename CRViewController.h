//
//  CRViewController.h
//  Combo Recovery
//
//  Created by srich on 11/7/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRViewController : UIViewController <UITextFieldDelegate> {
    
    ComboRecovery *recover;
    UIToolbar *toolbar;
    UIColor *recRed;
}

@property (nonatomic) IBOutlet UITextField *stickyOne;
@property (nonatomic) IBOutlet UITextField *stickyTwo;
@property (nonatomic) IBOutlet UITextField *stickyThree;
@property (nonatomic) IBOutlet UITextField *stickyFour;
@property (nonatomic) IBOutlet UITextField *stickyFive;
@property (nonatomic) IBOutlet UITextField *stickySix;
@property (nonatomic) IBOutlet UITextField *stickySeven;
@property (nonatomic) IBOutlet UITextField *stickyEight;
@property (nonatomic) IBOutlet UITextField *stickyNine;
@property (nonatomic) IBOutlet UITextField *stickyTen;
@property (nonatomic) IBOutlet UITextField *stickyEleven;
@property (nonatomic) IBOutlet UITextField *stickyTwelve;

- (IBAction)clearPressed:(id)sender;
- (IBAction)getCombosPressed:(id)sender;
- (IBAction)useRPPressed:(id)sender;
- (IBAction)nextField:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)keyboardDidShow:(id)sender;
- (IBAction)keyboardDidHide:(id)sender;

@end
