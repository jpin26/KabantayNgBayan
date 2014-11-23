//
//  DataHelper.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//


#import "DataHelper.h"

#import "Constants.h"

#import "Merchant.h"
#import "MerchantJSON.h"

//#import "DepartmentJSON.h"
//#import "EmployeeJSON.h"
//#import "SeatLocationCoordinateJSON.h"


#import <JSONModel/JSONHTTPClient.h>

@implementation DataHelper

#pragma mark JSON data


+(BOOL)createJSONDataFromPhonebook:(NSString *)query
{
    @try {
        
        [JSONHTTPClient getJSONFromURLWithString:query completion:^(id json, JSONModelError *err) {
            if (json == nil) {
                return;
            }
        }];
        
        /*
        [FileHelper createFileFromUrl:@"employee_transit.json" url:SERVICE_GET_EMPLOYEES async:NO];
        NSData *contactsTransitData = [FileHelper getFileFromCreatedFiles:@"employee_transit.json"];
        
        if (contactsTransitData != nil)
        {
            contactsTransitData = [FileHelper getFileFromCreatedFiles:@"employee_transit.json"];
            [FileHelper createFileFromData:@"employee.json" data:contactsTransitData async:NO];
        }
        
        [FileHelper createFileFromUrl:@"department_transit.json" url:SERVICE_GET_DEPARTMENTS async:NO];
        NSData *departmentsTransitData = [FileHelper getFileFromCreatedFiles:@"department_transit.json"];
        
        if (departmentsTransitData != nil)
        {
            departmentsTransitData = [FileHelper getFileFromCreatedFiles:@"department_transit.json"];
            [FileHelper createFileFromData:@"department.json" data:departmentsTransitData async:NO];
        }
         */
        
        return YES;
    }
    @catch (NSException *exception) {
        NSLog(@"%@", [exception reason]);
    }
    @finally {
        return NO;
    }
}

+(NSData *)queryJSONData:(NSString *)query
{
    __block bool hasError = NO;
    __block NSData *resultData = NO;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURL *fileUrl = [NSURL URLWithString:[query stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.allowsCellularAccess = YES;
    config.timeoutIntervalForRequest = 10.0;
    config.timeoutIntervalForResource = 10.0;
    config.HTTPMaximumConnectionsPerHost = 1;
    
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    NSURLSessionDataTask *jsonData = [session dataTaskWithURL:fileUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error == nil)
        {
            NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            string = [[[[string stringByReplacingOccurrencesOfString:@"\"{[" withString:@"["] stringByReplacingOccurrencesOfString:@"]}\"" withString:@"]"] stringByReplacingOccurrencesOfString:@"\\" withString:@""] stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
            resultData = [string dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    [jsonData resume];
    
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 20.0 * NSEC_PER_SEC));
    return resultData;
}

+(void)deleteObjectsByEntityName:(NSString *)entityName managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSFetchRequest * fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext]];
    NSArray * result = [managedObjectContext executeFetchRequest:fetch error:nil];
    for (id entityItem in result)
    {
        [managedObjectContext deleteObject:entityItem];
    }
}

+(NSMutableArray *)getObjectsFromLocalJsonByEntityName:(NSString *)entityName jsonPath:(NSString *)jsonPath
{
    NSData *JSONData;// = [FileHelper getFileFromCreatedFiles:[[NSString stringWithFormat:@"%@.json", entityName] lowercaseString]];
    
    // fallback to the locally stored files if
    if (JSONData == nil) {
        //JSONData = [FileHelper getFileFromSupportingFiles:[[NSString stringWithFormat:@"%@.json", entityName] lowercaseString]];
    }
    
    NSError* err = nil;
    
    if([entityName isEqualToString:PROCUREMENT])
    {
        return nil;
        //return [EmployeeJSON arrayOfModelsFromData:JSONData error:&err];
    }
    else if([entityName isEqualToString:MERCHANT])
    {
        //NSString *t1 = @"[{ \"locationFileName\" : \"oea.d0\", \"seatLocation\" : \"OEA.A0.P00\", \"xPosition\" : 892.000000, \"yPosition\" : 402.500000 }]";
        //JSONData = [t1 dataUsingEncoding:NSUTF8StringEncoding];
        return nil;
        //return [SeatLocationCoordinateJSON arrayOfModelsFromData:JSONData error:&err];
    }
    
    return nil;
}

#pragma mark Favorites ManagedObject
+(void)addFavoritesByFields:(NSString *)initials fullName:(NSString *)fullName managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    Merchant *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:PROCUREMENT inManagedObjectContext:managedObjectContext];
    
    //newManagedObject.initials = [initials uppercaseString];
    //newManagedObject.fullName = fullName;
    
    // Save the context.
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

+(Merchant *)getFavoriteByInitials:(NSString *)initials managedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:PROCUREMENT inManagedObjectContext:managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSString *query = [NSString stringWithFormat:@"organizationId == '%@'", [initials uppercaseString]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:query];
    [request setPredicate:predicate];
    
    NSArray *queryResult = [managedObjectContext executeFetchRequest:request error:nil];
    if([queryResult count] == 1)
    {
        return queryResult[0];
    }
    return nil;
}

@end
