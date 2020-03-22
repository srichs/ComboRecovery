//
//  CRTableViewController.h
//  Combo Recovery
//
//  Created by srich on 11/7/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComboRecovery.h"
#import "KamkarReduction.h"

@interface CRTableViewController : UITableViewController <UIActionSheetDelegate> {
    
    IBOutlet UIBarButtonItem *comboCount;
    IBOutlet UIBarButtonItem *saveBtn;
    IBOutlet UITableView *comboTable;
    IBOutlet UIActivityIndicatorView *activityView;
    int ind;
}

@property (strong,nonatomic) ComboRecovery *recover;
@property (strong,nonatomic) KamkarReduction *kamRec;
@property (nonatomic) NSArray *comboArray;
@property (nonatomic) NSMutableArray *checkArray;
@property (nonatomic) BOOL savePress;
@property (nonatomic) BOOL isKamkar;

- (IBAction)savePressed:(id)sender;

@end
