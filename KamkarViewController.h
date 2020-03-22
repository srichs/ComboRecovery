//
//  KamkarViewController.h
//  Combo Recovery
//
//  Created by srich on 7/25/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KamkarViewController : UIViewController <UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIAlertViewDelegate> {
    
    KamkarReduction *kamRec;
    UIToolbar *toolbar;
    UIColor *recRed;
    NSArray *pickArray;
    UIPickerView *firstLockPicker;
    UIPickerView *secondLockPicker;
}

@property (nonatomic) IBOutlet UITextField *firstLockField;
@property (nonatomic) IBOutlet UITextField *secondLockField;
@property (nonatomic) IBOutlet UITextField *resPointField;

- (IBAction)clearPressed:(id)sender;
- (IBAction)getCombosPressed:(id)sender;
- (IBAction)dismissKeyboard:(id)sender;

@end
