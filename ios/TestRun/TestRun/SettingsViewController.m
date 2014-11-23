//
//  SettingsViewController.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import "SettingsViewController.h"
#import "BusinessCategoryJSON.h"
#import "LocationJSON.h"

#import "DataHelper.h"
#import "MerchantJSON.h"

#import "Constants.h"

#import "SettingsViewCell.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

NSMutableArray *businessCategories;
NSMutableArray *provinces;
NSMutableArray *merchantArray;
NSString *queryUser = @"SELECT * FROM \"ec10e1c4-4eb3-4f29-97fe-f09ea950cdf1\" WHERE org_id = %@ LIMIT 1";

- (void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)viewWillAppear:(BOOL)animated
{
    ((UINavigationController *)self.parentViewController).title = @"Settings";
    ((UINavigationController *)self.parentViewController).navigationItem.rightBarButtonItem = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSFetchedResultsController deleteCacheWithName:@"SettingsMaster"];
    NSError *error;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    NSString *queryUser = @"SELECT org_name as organizationname, org_id as organizationId, province as region, '' as mobile, '' as email, '' as categories FROM \"ec10e1c4-4eb3-4f29-97fe-f09ea950cdf1\" WHERE org_id = %@ LIMIT 1";
    NSString *query = [NSString stringWithFormat:queryUser, [prefs valueForKey:@"organizationId"]];
    NSData *merchantData = [DataHelper queryJSONData:[NSString stringWithFormat:SERVICE_QUERY, query]];
    NSString *string = [[NSString alloc] initWithData:merchantData encoding:NSUTF8StringEncoding];
    merchantArray = [MerchantJSON arrayOfModelsFromData:merchantData error:&error];
    
    NSData *categoryData = [DataHelper queryJSONData:[NSString stringWithFormat:SERVICE_LOOKUP, @"BUSINESS_CATEGORY"]];
    
    businessCategories = [BusinessCategoryJSON arrayOfModelsFromData:categoryData error:&error];
    
    NSData *locationData = [DataHelper queryJSONData:[NSString stringWithFormat:SERVICE_LOOKUP, @"LOCATION"]];
    
    
    provinces = [LocationJSON arrayOfModelsFromData:locationData error:&error];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    @try
    {
        if (section == 0) {
            return @"Filter Categories";
        }
        else if (section == 1) {
            return @"Filter Provinces";
        }    }
    @catch (NSException *exception) {
        NSLog(@"Custom Error : %@", exception.reason );
        return nil;
    }
    @finally {}
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [businessCategories count];
    }
    else if (section == 1) {
        return [provinces count];
    }
    
    return 0;
}

int toggledIndex = -1;
int toggledSection = -1;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UINib *nibItem = [UINib nibWithNibName:@"SettingsViewCell" bundle:nil];
    [tableView registerNib:nibItem forCellReuseIdentifier:@"Cell"];
    SettingsViewCell *cell = (SettingsViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SettingViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (indexPath.section == 0) {
        NSString *categoryText = ((BusinessCategoryJSON *)[businessCategories objectAtIndex:indexPath.row]).businesscategory;
        cell.settingName.text = categoryText;
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *storedBusinessCategory = [prefs valueForKey:@"settingsCategory"];
        if (storedBusinessCategory != nil && [storedBusinessCategory rangeOfString:categoryText].location != NSNotFound) {
            [cell.settingToggle setOn:YES animated:NO];
        }
        else
        {
            [cell.settingToggle setOn:NO];
        }
        
    }
    else if (indexPath.section == 1) {
        cell.settingName.text = ((LocationJSON *)[provinces objectAtIndex:indexPath.row]).location;
        [cell.settingToggle setOn:NO];
    }
    
    cell.settingToggle.tag = indexPath.row;
    [cell.settingToggle addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    //cell.settingName.text = favorite.title;
    
    return cell;
}

- (void) switchChanged:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    UISwitch* switchControl = sender;
    NSLog( @"The switch is %@", switchControl.on ? @"ON" : @"OFF" );
    toggledIndex = switchControl.tag;
    NSString *storedBusinessCategory = [prefs valueForKey:@"settingsCategory"];
    NSString *selectedBusinessCategory = ((BusinessCategoryJSON *)[businessCategories objectAtIndex:toggledIndex]).businesscategory;
    
    if (switchControl.on) {
        if (storedBusinessCategory == nil) {
            [prefs setObject:selectedBusinessCategory forKey:@"settingsCategory"];
        }
        else
        {
            storedBusinessCategory = [storedBusinessCategory stringByAppendingString:@","];
            storedBusinessCategory = [storedBusinessCategory stringByAppendingString:selectedBusinessCategory];
            [prefs setObject:storedBusinessCategory forKey:@"settingsCategory"];
        }
    }
    else
    {
        if (storedBusinessCategory != nil) {
            storedBusinessCategory = [storedBusinessCategory stringByReplacingOccurrencesOfString:[selectedBusinessCategory stringByAppendingString:@","] withString:@""];
            storedBusinessCategory = [storedBusinessCategory stringByReplacingOccurrencesOfString:selectedBusinessCategory withString:@""];
            [prefs setObject:storedBusinessCategory forKey:@"settingsCategory"];
        }
    }
    
    
    [prefs synchronize];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
