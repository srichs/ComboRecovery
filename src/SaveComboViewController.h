//
//  SaveComboViewController.h
//  Combo Recovery
//
//  Created by srich on 7/5/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveComboViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIAlertViewDelegate> {
    
    UIPickerView *comboPicker;
    UIToolbar *pickerToolbar;
    UIColor *recRed;
    NSArray *digitArray;
    int firstDigit;
    int secondDigit;
    int thirdDigit;
}

@property (strong,nonatomic) NSString *comboString;
@property (strong,nonatomic) NSString *nameString;
@property (strong,nonatomic) NSString *locationString;
@property (nonatomic) BOOL isNew;
@property (nonatomic) BOOL isFromList;
@property (nonatomic) int index;

@property (strong,nonatomic) IBOutlet UITextField *nameField;
@property (strong,nonatomic) IBOutlet UITextField *comboField;
@property (strong,nonatomic) IBOutlet UITextField *locationField;

- (IBAction)resetPressed:(id)sender;
- (IBAction)savePressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;

@end
