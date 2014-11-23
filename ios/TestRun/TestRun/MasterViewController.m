//
//  MasterViewController.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import "MasterViewController.h"
#import "ActiveBidsViewController.h"
#import "BookmarksViewController.h"
//#import "OppsViewController.h"
#import "SettingsViewController.h"

//#import "EmployeeJSON.h"

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSArray *array = [self viewControllers];
    ((ActiveBidsViewController *)array[0]).managedObjectContext = self.managedObjectContext;
    ((BookmarksViewController *)array[1]).managedObjectContext = self.managedObjectContext;
    //((OppsViewController *)array[2]).managedObjectContext = self.managedObjectContext;
    ((SettingsViewController *)array[2]).managedObjectContext = self.managedObjectContext;
    
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:255.0/255 green:136.0/255 blue:37.0/255 alpha:1]];
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
