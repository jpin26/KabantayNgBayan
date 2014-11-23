//
//  DetailViewController.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import "DetailViewController.h"

#import "Constants.h"
#import "DataHelper.h"
#import "FileHelper.h"

#import "ActionViewCell.h"
#import "DetailHeaderViewCell.h"
#import "DetailViewCell.h"

#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

#import <RHAddressBook/AddressBook.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

bool isDKContact = NO;

#pragma mark - Managing the detail item

- (void)setDetailItem:(ProcurementJSON *)newDetailItem fetchedResultsController:(NSFetchedResultsController *)fetchedResultsController managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        self.managedObjectContext = managedObjectContext;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.isGrantedIphoneContacts =([RHAddressBook authorizationStatus] == RHAuthorizationStatusAuthorized);
    self.addressBook = [[RHAddressBook alloc] init];
    
    self.employeeDetailsTableView.delegate = self;
    self.employeeDetailsTableView.dataSource = self;
    
    self.title = self.detailItem.title;
    
    /*
    Favorite *favorite = [DataHelper getFavoriteByInitials:self.detailItem.initials managedObjectContext:self.managedObjectContext];
    if(favorite != nil)
    {
        self.employeeIsAlreadyInFavorite = YES;
    }
     */
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self performSegueWithIdentifier:@"showOfficeLocationSegue" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView Events

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return isDKContact ? 8 : 7;
            break;
        default:
            return 1;
            break;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return [self configureHeaderCell:tableView indexPath:indexPath];
            break;
        case 1:
            return [self configureDetailCell:tableView indexPath:indexPath];
            break;
        default:
            return [self configureActionCell:tableView indexPath:indexPath];
            break;
    }
}

-(DetailHeaderViewCell *)configureHeaderCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DetailHeaderViewCell *cell = (DetailHeaderViewCell *)[tableView dequeueReusableCellWithIdentifier:@"HeaderCell" forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailHeaderViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.cellFullName.text = self.detailItem.title;
    cell.cellInitials.text = self.detailItem.item_description;
    
    return cell;
}

-(DetailViewCell *)configureDetailCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    DetailViewCell *cell = (DetailViewCell *)[tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    int adjustForDKFiveDigitMobile = isDKContact ? 1 : 0;
    
    if(indexPath.row == 0)
    {
        cell.cellKey.text = @"Reference number";
        cell.cellValue.text = self.detailItem.referencenumber;
    }
    else if(indexPath.row == 1)
    {
        cell.cellKey.text = @"Approved Budget";
        cell.cellValue.text = self.detailItem.bidamount;
    }
    else if(indexPath.row == 2)
    {
        cell.cellKey.text = @"Bid Category";
        cell.cellValue.text = self.detailItem.bidcategory;
    }
    else if(indexPath.row == 3)
    {
        cell.cellKey.text = @"Remarks";
        cell.cellValue.text = self.detailItem.remarks;
    }
    else if(indexPath.row == 4)
    {
        cell.cellKey.text = @"Location";
        cell.cellValue.text = self.detailItem.geotag;
        cell.drillAble = YES;
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if(cell.drillAble)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if(cell.callAble && cell.messageAble)
    {
        if([cell.cellValue.text isEqualToString:@""])
        {
            cell.accessoryView = UITableViewCellAccessoryNone;
        }
        else
        {
            cell.accessoryView = [cell makeCallAndMessageButton:@selector(clickCall:withEvent:) messageSelector:@selector(clickMessage:withEvent:) target:self];
        }
    }
    else
    {
        if(cell.callAble)
        {
            if([cell.cellValue.text isEqualToString:@""])
            {
                cell.accessoryView = UITableViewCellAccessoryNone;
            }
            else
            {
                cell.accessoryView = [cell makeCallButton:@selector(clickCall:withEvent:) target:self];
            }
            
        }
        else if(cell.messageAble)
        {
            cell.accessoryView = [cell makeMessageButton:@selector(clickMessage:withEvent:) target:self];
        }
    }
    
    if(cell.emailAble)
    {
        cell.accessoryView = [cell makeMailButton:@selector(clickEmail:withEvent:) target:self];
    }
    
    return cell;
}

- (void) clickMessage :(UIButton *) button withEvent:(UIEvent *) event
{
    CGPoint point = (CGPoint)[[[event touchesForView: button] anyObject] locationInView:self.employeeDetailsTableView];
    NSIndexPath *indexPath = [self.employeeDetailsTableView indexPathForRowAtPoint:point];
    
    DetailViewCell *detailCell = (DetailViewCell *)[self.employeeDetailsTableView cellForRowAtIndexPath:indexPath];
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    
    if ([MFMessageComposeViewController canSendText]) {
        messageController.recipients = [NSArray arrayWithObjects:detailCell.cellValue.text, nil];
        [messageController setMessageComposeDelegate:self];
        
        [self presentViewController:messageController animated:YES completion:nil];
    }
}

- (void) clickEmail :(UIButton *) button withEvent:(UIEvent *) event
{
    CGPoint point = (CGPoint)[[[event touchesForView: button] anyObject] locationInView:self.employeeDetailsTableView];
    NSIndexPath *indexPath = [self.employeeDetailsTableView indexPathForRowAtPoint:point];
    
    DetailViewCell *detailCell = (DetailViewCell *)[self.employeeDetailsTableView cellForRowAtIndexPath:indexPath];
    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
    
    if ([MFMailComposeViewController canSendMail] && detailCell.cellValue.text.length > 0) {
        [mailController setToRecipients:[NSArray arrayWithObjects:detailCell.cellValue.text, nil]];
        [mailController setMailComposeDelegate:self];
        
        [self presentViewController:mailController animated:YES completion:nil];
    }
}

- (void) clickCall :(UIButton *) button withEvent:(UIEvent *) event
{
    CGPoint point = (CGPoint)[[[event touchesForView: button] anyObject] locationInView:self.employeeDetailsTableView];
    NSIndexPath *indexPath = [self.employeeDetailsTableView indexPathForRowAtPoint:point];
    
    DetailViewCell *detailCell = (DetailViewCell *)[self.employeeDetailsTableView cellForRowAtIndexPath:indexPath];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        if ([detailCell.cellValue.text length] > 0) {
            NSURL *telUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", detailCell.cellValue.text]];
            
            [[UIApplication sharedApplication] openURL:telUrl];
        }
    }
}


-(ActionViewCell *)configureActionCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    ActionViewCell *cell = (ActionViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ActionCell" forIndexPath:indexPath];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ActionViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if(self.employeeIsAlreadyInFavorite)
    {
        [cell.favoritesButton setTitle:@"Remove from Favorites" forState:UIControlStateNormal];
        [cell.favoritesButton addTarget:self action:@selector(removeFromFavoritesClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [cell.favoritesButton setTitle:@"Add to Favorites" forState:UIControlStateNormal];
        [cell.favoritesButton addTarget:self action:@selector(addToFavoritesClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    [cell.moreActionsButton addTarget:self action:@selector(askToAddToContact:)  forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(void)addToFavoritesClick:(UIButton *)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
    ActionViewCell *cell = (ActionViewCell *)[self.employeeDetailsTableView cellForRowAtIndexPath:indexPath];
    
    [DataHelper addFavoritesByFields:cell.initials fullName:cell.fullName managedObjectContext:self.managedObjectContext];
    
    [sender setTitle:@"Remove from Favorites" forState:UIControlStateNormal];
    [sender removeTarget:self action:@selector(addToFavoritesClick:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(removeFromFavoritesClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)removeFromFavoritesClick:(UIButton *)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:2];
    ActionViewCell *cell = (ActionViewCell *)[self.employeeDetailsTableView cellForRowAtIndexPath:indexPath];
    
    //[DataHelper deleteFavoriteByInitials:cell.initials managedObjectContext:self.managedObjectContext];
    
    [sender setTitle:@"Add to Favorites" forState:UIControlStateNormal];
    [sender removeTarget:self action:@selector(removeFromFavoritesClick:) forControlEvents:UIControlEventTouchUpInside];
    [sender addTarget:self action:@selector(addToFavoritesClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)askToAddToContact:(UIButton *)sender
{
    CFErrorRef *error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    
    __block BOOL accessGranted = NO;
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    self.isGrantedIphoneContacts = accessGranted;
    
    if (!self.isGrantedIphoneContacts) {
        return;
    }
    
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Export Contact details" message:[NSString stringWithFormat:@"This will export the contact details of %@ to your device's phonebook. Proceed?", self.detailItem.initials] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    //[alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        [self addEmployeeToPhoneContacts];
    }
}

-(void)addEmployeeToPhoneContacts
{}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 120;
            break;
        case 1:
            return 67;
            break;
        default:
            return 125;
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"showDetailSegue"]) {
        NSIndexPath *indexPath = [self.employeeDetailsTableView indexPathForSelectedRow];
        DetailViewCell *selectedCell = (DetailViewCell *)[self.employeeDetailsTableView cellForRowAtIndexPath:indexPath];
        if(!selectedCell.drillAble)
        {
            return NO;
        }
    }
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.employeeDetailsTableView indexPathForSelectedRow];
    if ([[segue identifier] isEqualToString:@"showMapSegue"]) {
        DetailViewCell *selectedCell = (DetailViewCell *)[self.employeeDetailsTableView cellForRowAtIndexPath:indexPath];
        
        ProcurementJSON *subDetail = self.detailItem;
    }
}

#pragma mark Messaging modules
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:^{
        return;
    }];
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
