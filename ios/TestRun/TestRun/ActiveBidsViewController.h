//
//  ActiveBidsViewController.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>
#import <EventKitUI/EventKitUI.h>

#import <MMPopLabel/MMPopLabelDelegate.h>

@interface ActiveBidsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, EKEventEditViewDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchedResultsController *searchFetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (strong, nonatomic) MMPopLabel *popup;

@property (weak, nonatomic) IBOutlet UITableView *procurementsTable;
@property (weak, nonatomic) IBOutlet UINavigationItem *contactsNavigationItem;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabItem;
@end
