//
//  BookmarksViewController.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import "BookmarksViewController.h"
//#import "DetailViewController.h"

#import "Constants.h"
#import "DataHelper.h"
//#import "FileHelper.h"

#import "ProcurementViewCell.h"
#import "ProcurementJSON.h"


@interface BookmarksViewController ()

@end

@implementation BookmarksViewController
NSMutableArray *procurementArray;
- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)viewWillAppear:(BOOL)animated
{
    ((UINavigationController *)self.parentViewController).title = @"Opportunities";
    ((UINavigationController *)self.parentViewController).navigationItem.rightBarButtonItem = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSError *error;
    NSString *query = [NSString stringWithFormat:SERVICE_BY_CATEGORY_ALL,[prefs valueForKey:@"settingsCategory"]];
    
    if ([prefs valueForKey:@"settingsCategory"] == nil || [[prefs valueForKey:@"settingsCategory"] isEqualToString:@""]) {
        query = [NSString stringWithFormat:SERVICE_ACTIVEBIDS, [prefs valueForKey:@"organizationId"]];
    }
    
    procurementArray = nil;
    NSData *procurementData = [DataHelper queryJSONData:query];
    if (procurementData != nil) {
        NSString *string = [[NSString alloc] initWithData:procurementData encoding:NSUTF8StringEncoding];
        procurementArray = [ProcurementJSON arrayOfModelsFromData:procurementData error:&error];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetailSegue"]) {
        NSIndexPath *indexPath = [self.favoritesTableView indexPathForSelectedRow];
        ProcurementViewCell *selectedCell = (ProcurementViewCell *)[self.favoritesTableView cellForRowAtIndexPath:indexPath];
        }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
