//
//  ThirdNumViewController.h
//  Combo Recovery
//
//  Created by srich on 11/8/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdNumViewController : UIViewController <UITextFieldDelegate> {
    
    IBOutlet UIBarButtonItem *clearButton;
    ComboRecovery *recover;
    UIToolbar *toolbar;
    UIColor *recRed;
}

@property (nonatomic) IBOutlet UITextField *thirdNum;

- (IBAction)clearPressed:(id)sender;
- (IBAction)getCombosPressed:(id)sender;
- (IBAction)useRPPressed:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

@end
