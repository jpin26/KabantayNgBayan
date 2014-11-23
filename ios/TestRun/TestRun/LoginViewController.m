//
//  LoginViewController.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import "LoginViewController.h"
#import "MasterViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
bool passThrough = NO;
-(void)viewDidLoad
{
    self.uscActivationCode.hidden = YES;
    
    self.uscOrganizationId.hidden = YES;
    self.uscEmail.hidden = YES;
    self.uscMobile.hidden = YES;
    self.uscActivationCode.hidden = YES;
   
}

-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *activationKey = [prefs stringForKey:@"activationCode"];
    
    if (activationKey != nil) {
        //passThrough = YES;
        //[self performSegueWithIdentifier:@"activateSegue" sender:self];
    }
    
    
    
    [prefs setValue:@"18287" forKey:@"organizationId"];
    [prefs setValue:self.uscEmail.text forKey:@"email"];
    [prefs setValue:self.uscMobile.text forKey:@"mobile"];
    [prefs setValue:self.uscActivationCode.text forKey:@"activationCode"];
    
    [prefs synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)uscRegister_Click:(id)sender {
    if ([self.uscRegister.titleLabel.text isEqualToString:@"Register"]) {
        self.uscOrganizationId.hidden = YES;
        self.uscEmail.hidden = YES;
        self.uscMobile.hidden = YES;
        self.uscActivationCode.hidden = YES;
        [self.uscRegister setTitle:@"Activate" forState:UIControlStateNormal];
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"activateSegue"]) {
        
        if ([self.uscRegister.titleLabel.text isEqualToString:@"Activate"] || passThrough) {
            UINavigationController *navigationController = (UINavigationController *)[segue destinationViewController];
            MasterViewController *controller = (MasterViewController *)navigationController.topViewController;
            controller.managedObjectContext = self.managedObjectContext;
            
            if (!passThrough) {
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                
                [prefs setValue:@"18287" forKey:@"organizationId"];
                [prefs setValue:self.uscEmail.text forKey:@"email"];
                [prefs setValue:self.uscMobile.text forKey:@"mobile"];
                [prefs setValue:self.uscActivationCode.text forKey:@"activationCode"];
                
                [prefs synchronize];
            }
            
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
