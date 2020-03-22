//
//  SaveComboTableViewController.m
//  Combo Recovery
//
//  Created by srich on 7/5/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import "SCTableViewCell.h"
#import "SaveComboViewController.h"
#import "SaveComboTableViewController.h"

@implementation SaveComboTableViewController : UITableViewController

#define debug 0

#pragma UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"scTableCell";
    SCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.nameLabel.text = [self.nameArray objectAtIndex:indexPath.row];
    cell.locationLabel.text = [self.locationArray objectAtIndex:indexPath.row];
    cell.comboLabel.text = [self.comboArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.comboTable deselectRowAtIndexPath:indexPath animated:NO];
    ind = (int)indexPath.row;
    [self performSegueWithIdentifier:@"editLock" sender:self];
    if (debug == 1) {
        NSLog(@"Row Selected: %i",(int)indexPath.row);
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [self.nameArray removeObjectAtIndex:indexPath.row];
        [self.locationArray removeObjectAtIndex:indexPath.row];
        [self.comboArray removeObjectAtIndex:indexPath.row];
        
        [defaults setObject:self.nameArray forKey:@"nameArray"];
        [defaults setObject:self.locationArray forKey:@"locationArray"];
        [defaults setObject:self.comboArray forKey:@"comboArray"];
        [defaults synchronize];
        
        [self.comboTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if (debug == 1) {
            NSLog(@"Row Deleted: %i",(int)indexPath.row);
        }
    }
}

#pragma UIView

- (void)viewDidLoad {
    [self setDefaults];
    if (debug == 1) {
        NSLog(@"View Load Complete");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addPressed:(id)sender {
    [self alertLogic];
}

- (IBAction)unwindToTableVCWithSave:(UIStoryboardSegue *)segue {
    
}

#pragma Setup

- (void)setDefaults {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.nameArray = [[defaults objectForKey:@"nameArray"] mutableCopy];
    self.locationArray = [[defaults objectForKey:@"locationArray"] mutableCopy];
    self.comboArray = [[defaults objectForKey:@"comboArray"] mutableCopy];
    
    [self.comboTable reloadData];
    if (debug == 1) {
        NSLog(@"Set Defaults Complete");
    }
}

#pragma UIAlertView

- (void)alertLogic {
    if (self.nameArray.count > 19)
        [self alert];
    else
        [self performSegueWithIdentifier:@"addLock" sender:self];
    if (debug == 1) {
        NSLog(@"Alert Logic Complete");
    }
}

- (void)alert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"There is a limit of 20 saved combinations. Please delete or edit an existing entry."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma UIStoryboardSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"addLock"]) {
        SaveComboViewController *controller = (SaveComboViewController *)segue.destinationViewController;
        controller.navigationController.navigationBar.barStyle = self.navigationController.navigationBar.barStyle;
        controller.isNew = YES;
        if (debug == 1) {
            NSLog(@"Add Component Segue");
        }
    }
    else if ([segue.identifier isEqualToString:@"editLock"]) {
        SaveComboViewController *controller = (SaveComboViewController *)segue.destinationViewController;
        controller.navigationController.navigationBar.barStyle = self.navigationController.navigationBar.barStyle;
        controller.isNew = NO;
        controller.index = ind;
        controller.comboString = [self.comboArray objectAtIndex:ind];
        controller.nameString = [self.nameArray objectAtIndex:ind];
        controller.locationString = [self.locationArray objectAtIndex:ind];
        
        if (debug == 1) {
            NSLog(@"Edit Component Segue");
        }
    }
}

@end
