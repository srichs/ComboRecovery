//
//  MainTableViewController.m
//  Combo Recovery
//
//  Created by srich on 6/21/15.
//  Copyright (c) 2015 Scott Richards. All rights reserved.
//

#import <sys/utsname.h>
#import "MainTableViewController.h"

@implementation MainTableViewController : UIViewController

- (IBAction)bugPressed:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController * emailController = [[MFMailComposeViewController alloc] init];
        emailController.mailComposeDelegate = self;
        
        NSString *appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        NSString *appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        NSString *versionBuildString = [NSString stringWithFormat:@"Combo Recovery v%@ (%@)", appVersionString, appBuildString];
        
        NSString *iosVersion = [[UIDevice currentDevice] systemVersion];
        NSString *iosVerString = [NSString stringWithFormat:@"iOS v%@", iosVersion];
        
        NSString *deviceType = [self deviceName];
        
        NSString *subject = @"Bug Report";
        
        [emailController setSubject:subject];
        [emailController setMessageBody:[[[[[@"<br /><br /><br /><br />" stringByAppendingString:versionBuildString] stringByAppendingString:@"<br />"] stringByAppendingString:iosVerString] stringByAppendingString:@"<br />"] stringByAppendingString:deviceType] isHTML:YES];
        [emailController setToRecipients:@[@"combo.recovery@gmail.com"]];
        
        [self presentViewController:emailController animated:YES completion:nil];
    }
    else {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                message:@"You must have a mail account in order to send an email."
                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction* action) {}];
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)enterPressed:(id)sender {
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.toolbarHidden = NO;
    firstView.hidden = YES;
}

- (IBAction)unwindToMainTableVCWithSave:(UIStoryboardSegue *)segue {
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (NSString *) deviceName {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.toolbarHidden = YES;
    firstView.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    if (self.fromSavedCombo) {
        self.fromSavedCombo = NO;
        [self performSelector:@selector(loadSavedCombos) withObject:nil afterDelay:0];
    }
}

- (void)loadSavedCombos {
    [self performSegueWithIdentifier:@"savedCombosVC" sender:self];
}

@end
