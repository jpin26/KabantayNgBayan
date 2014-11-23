//
//  ActiveBidsViewController.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import "ActiveBidsViewController.h"
#import "DetailViewController.h"

#import "Constants.h"
#import "DataHelper.h"
#import "FileHelper.h"

#import "Procurements.h"
#import "ProcurementJSON.h"
#import "BusinessCategoryJSON.h"

#import "ProcurementViewCell.h"

#import <MMPopLabel/MMPopLabel.h>
#import <DejalActivityView/DejalActivityView.h>

@implementation NSString (FetchedGroupByString)
- (NSString *)stringGroupByFirstInitial {
    if (!self.length || self.length == 1)
        return self;
    return [self substringToIndex:1];
}
@end

@implementation ActiveBidsViewController

//MONActivityIndicatorView *indicatorView;
UIActivityIndicatorView *activityIndicator;
bool willIndex = NO;
NSMutableArray *procurementArray;
- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)viewWillAppear:(BOOL)animated
{
    ((UINavigationController *)self.parentViewController).title = @"My Bids";
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(synchPhonebook:)];
    ((UINavigationController *)self.parentViewController).navigationItem.rightBarButtonItem = addButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSError *error;
    NSString *query = [NSString stringWithFormat:SERVICE_BY_CATEGORY, [prefs valueForKey:@"organizationId"],[prefs valueForKey:@"settingsCategory"]];
    
    if ([prefs valueForKey:@"settingsCategory"] == nil || [[prefs valueForKey:@"settingsCategory"] isEqualToString:@""]) {
        query = [NSString stringWithFormat:SERVICE_ACTIVEBIDS, [prefs valueForKey:@"organizationId"]];
    }
    
    procurementArray = nil;
    NSData *procurementData = [DataHelper queryJSONData:query];
    if (procurementData != nil) {
        NSString *string = [[NSString alloc] initWithData:procurementData encoding:NSUTF8StringEncoding];
        procurementArray = [ProcurementJSON arrayOfModelsFromData:procurementData error:&error];
    }
    
    [self.procurementsTable reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:168.0/255 green:0 blue:0 alpha:1]];
}

- (BOOL)createEvent:(NSString *)title
                 at:(NSString *)location
           starting:(NSDate *)startDate
             ending:(NSDate *)endDate
           withBody:(NSString *)body
             andUrl:(NSURL *)url
{
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        // handle access here
    }];
    
    EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
    event.title     = title;
    event.location  = location;
    event.startDate = startDate;
    event.endDate   = endDate;
    event.notes     = body;
    if (url)
        event.URL   = url;
    
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    
    EKEventEditViewController *eventViewController = [[EKEventEditViewController alloc] init];
    eventViewController.event = event;
    eventViewController.eventStore = eventStore;
    eventViewController.editViewDelegate = self;
    
    [self presentModalViewController:eventViewController animated:YES];
    
    return TRUE;
}

-(void)eventEditViewController:(EKEventEditViewController *)controller didCompleteWithAction:(EKEventEditViewAction)action
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Sync events

- (void)synchPhonebook:(id)sender
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Filter data" message:@"Are you sure you want to filter the data?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        willIndex = YES;
        [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading"];
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if(willIndex)
        {
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            NSError *error;
            NSString *query = [NSString stringWithFormat:SERVICE_BY_CATEGORY, [prefs valueForKey:@"organizationId"],[prefs valueForKey:@"settingsCategory"]];
            
            if ([prefs valueForKey:@"settingsCategory"] == nil || [[prefs valueForKey:@"settingsCategory"] isEqualToString:@""]) {
                query = [NSString stringWithFormat:SERVICE_ACTIVEBIDS, [prefs valueForKey:@"organizationId"]];
            }
            
            procurementArray = nil;
            NSData *procurementData = [DataHelper queryJSONData:query];
            if (procurementData != nil) {
                NSString *string = [[NSString alloc] initWithData:procurementData encoding:NSUTF8StringEncoding];
                procurementArray = [ProcurementJSON arrayOfModelsFromData:procurementData error:&error];
            }
            
            [DejalBezelActivityView removeViewAnimated:YES];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            
            [self.procurementsTable reloadData];
        }
    }
}

#pragma mark - TableView Events



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [procurementArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINib *nibItem = [UINib nibWithNibName:@"ProcurementViewCell" bundle:nil];
    [tableView registerNib:nibItem forCellReuseIdentifier:@"Cell"];
    ProcurementViewCell *cell = (ProcurementViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProcurementViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //Employee *object = [tmpFRC objectAtIndexPath:indexPath];
    Procurements *object = (Procurements *)[procurementArray objectAtIndex:indexPath.row];
    cell.cellName.text = object.title;
    cell.cellDescription.text = object.title;
    //cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showDetailSegue" sender:self];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"showDetailSegue"]) {
        NSIndexPath *selectedIndexPath = [self.searchDisplayController isActive] ? [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow] : [self.procurementsTable indexPathForSelectedRow];
        
        if (selectedIndexPath == nil) {
            return NO;
        }
    }
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedIndexPath = [self.searchDisplayController isActive] ? [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow] : [self.procurementsTable indexPathForSelectedRow];
    if ([[segue identifier] isEqualToString:@"showDetailSegue"]) {
        Procurements *object = (Procurements *)[procurementArray objectAtIndex:selectedIndexPath.row];
        [((DetailViewController *)[segue destinationViewController]) setDetailItem:object fetchedResultsController:self.fetchedResultsController managedObjectContext:self.managedObjectContext];
    }
}

@end

