//
//  LoginViewController.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITextField *uscOrganizationId;
@property (weak, nonatomic) IBOutlet UIButton *uscRegister;
@property (weak, nonatomic) IBOutlet UITextField *uscEmail;
@property (weak, nonatomic) IBOutlet UITextField *uscMobile;
@property (weak, nonatomic) IBOutlet UITextField *uscActivationCode;
@end
