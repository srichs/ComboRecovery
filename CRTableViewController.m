//
//  CRTableViewController.m
//  Combo Recovery
//
//  Created by srich on 11/7/14.
//  Copyright (c) 2014 Scott Richards. All rights reserved.
//

#import "KamkarReduction.h"
#import "ComboRecovery.h"
#import "CRTableViewCell.h"
#import "CRTableViewController.h"
#import "SaveComboViewController.h"

@interface CRTableViewController ()

@end

@implementation CRTableViewController

#define debug 0

#pragma UIView

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.savePress = NO;
    if (self.isKamkar) {
        self.comboArray = self.kamRec.combinations;
    }
    else {
        if ([self.recover combinationsArray] == nil) {
            self.recover = [[ComboRecovery alloc] init];
            [self.recover fillAllCombosArray];
            self.comboArray = [self.recover allCombosArray];
        }
        else {
            self.comboArray = [self.recover combinationsArray];
        }
    }
    
    self.checkArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.comboArray count]; i++) {
        [self.checkArray addObject:@"NO"];
    }
    [comboCount setTitle:[[NSString stringWithFormat:@"%i",(int)[self.comboArray count]] stringByAppendingString:@" Combos"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)savePressed:(id)sender {
    if (self.savePress == NO) {
        [self actionSheet];
    }
    else {
        self.savePress = NO;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(savePressed:)];
    }
}

#pragma UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.comboArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CRTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CRTableCell"];
    if (cell == nil) {
        cell = [[CRTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CRTableCell"];
    }
    cell.comboLabel.text = [self.comboArray objectAtIndex:indexPath.row];
    
    if ([[self.checkArray objectAtIndex:indexPath.row] isEqual:@"YES"])
        cell.imageView.image = [UIImage imageNamed:@"checkmark2.png"];
    else
        cell.imageView.image = [UIImage imageNamed:@"checkmark_box.png"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.savePress) {
        ind = (int)[[comboTable indexPathForSelectedRow] row];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *comboArr = [defaults objectForKey:@"comboArray"];
        
        BOOL sameCombo = NO;
        
        for (int i = 0; i < comboArr.count; i++) {
            if ([[comboArr objectAtIndex:i] isEqualToString:[self.comboArray objectAtIndex:ind]]) {
                sameCombo = YES;
            }
        }
        
        if (sameCombo)
            [self alert3];
        else {
            [self performSegueWithIdentifier:@"saveCombo" sender:self];
        }
    }
    else if ([[self.checkArray objectAtIndex:indexPath.row] isEqual:@"YES"]) {
        cell.imageView.image = [UIImage imageNamed:@"checkmark_box.png"];
        [self.checkArray replaceObjectAtIndex:indexPath.row withObject:@"NO"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"checkmark2.png"];
        [self.checkArray replaceObjectAtIndex:indexPath.row withObject:@"YES"];
    }
    
    cell.selected = NO;
}

#pragma UIAlertView

- (void)alert {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Save Combination"
                                            message:@"Please tap the combination you wish to save or press Cancel to edit list."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert3 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"This combination has already been saved. Combinations must be unique. Please select a different combination or edit the existing saved combination."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)alert4 {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                            message:@"There is a limit of 20 saved combinations. Please remember your combination and delete or edit an existing saved entry."
                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction* action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma UIActionSheet

- (void)actionSheet {
    UIAlertController* actionSheet = [UIAlertController alertControllerWithTitle:nil
                                                                         message:nil
                                                                  preferredStyle:UIAlertControllerStyleActionSheet];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Help" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        [self performSegueWithIdentifier:@"crTableHelp" sender:self];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Save Combination" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        [self saveCombo];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Check All" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        [self checkAll];
    }]];
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Uncheck All" style:UIAlertActionStyleDefault handler:^(UIAlertAction* action) {
        [self uncheckAll];
    }]];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (void)saveList {
    
}

- (void)saveCombo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *comboArr = [defaults objectForKey:@"comboArray"];
    if (comboArr.count > 19) {
        [self alert4];
    }
    else {
        self.savePress = YES;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(savePressed:)];
        [self alert];
    }
}

- (void)checkAll {
    for (int i = 0; i < self.checkArray.count; i++) {
        [self.checkArray replaceObjectAtIndex:i withObject:@"YES"];
        [comboTable reloadData];
    }
}

- (void)uncheckAll {
    for (int i = 0; i < self.checkArray.count; i++) {
        [self.checkArray replaceObjectAtIndex:i withObject:@"NO"];
        [comboTable reloadData];
    }
}

#pragma UIStoryboardSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"saveCombo"]) {
        SaveComboViewController *controller = (SaveComboViewController *)segue.destinationViewController;
        controller.isFromList = YES;
        controller.comboString = [self.comboArray objectAtIndex:ind];
        [controller.nameField isFirstResponder];
        if (debug == 1) {
            NSLog(@"Add Component Segue");
        }
    }
}

@end
