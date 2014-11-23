//
//  DetailViewController.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcurementJSON.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#import <RHAddressBook/AddressBook.h>

@interface DetailViewController : UIViewController <NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *employeeDetailsTableView;

@property (strong, nonatomic) ProcurementJSON *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (assign, nonatomic) BOOL employeeIsAlreadyInFavorite;

@property (assign, nonatomic)BOOL isGrantedIphoneContacts;
@property (strong, nonatomic) RHAddressBook *addressBook;

- (void)setDetailItem:(ProcurementJSON *)newDetailItem fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

@end
