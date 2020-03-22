//
//  MainTableViewController.h
//  Combo Recovery
//
//  Created by srich on 6/21/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

@import MessageUI;
#import <UIKit/UIKit.h>

@interface MainTableViewController : UIViewController <MFMailComposeViewControllerDelegate> {
    
    IBOutlet UIView *firstView;
}

@property (nonatomic) BOOL fromSavedCombo;

- (IBAction)enterPressed:(id)sender;
- (IBAction)bugPressed:(id)sender;
- (IBAction)unwindToMainTableVCWithSave:(UIStoryboardSegue *)segue;

@end
