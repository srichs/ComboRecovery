//
//  RPViewController.h
//  Combo Recovery
//
//  Created by srich on 7/18/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RPViewController : UIViewController <UITextFieldDelegate> {
    
    IBOutlet UIBarButtonItem *clearButton;
    UIToolbar *toolbar;
    UIColor *recRed;
}

@property (nonatomic) IBOutlet UITextField *resPoint;
@property (nonatomic,strong) ComboRecovery *recover;

- (IBAction)clearPressed:(id)sender;
- (IBAction)getCombosPressed:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

@end
