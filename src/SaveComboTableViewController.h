//
//  SaveComboTableViewController.h
//  Combo Recovery
//
//  Created by srich on 7/5/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveComboTableViewController : UITableViewController <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate> {
    
    int ind;
}

@property (strong,nonatomic) IBOutlet UITableView *comboTable;
@property (strong,nonatomic) NSMutableArray *nameArray;
@property (strong,nonatomic) NSMutableArray *locationArray;
@property (strong,nonatomic) NSMutableArray *comboArray;

- (IBAction)addPressed:(id)sender;
- (IBAction)unwindToTableVCWithSave:(UIStoryboardSegue *)segue;

@end
