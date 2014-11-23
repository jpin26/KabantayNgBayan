//
//  DataHelper.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Merchant.h"
#import "MerchantJSON.h"

@interface DataHelper : NSObject
+(BOOL)createJSONDataFromPhonebook:(NSString *)query;
+(NSData *)queryJSONData:(NSString *)query;

+(void)deleteObjectsByEntityName:(NSString *)entityName managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(NSMutableArray *)getObjectsFromLocalJsonByEntityName:(NSString *)entityName jsonPath:(NSString *)jsonPath;

+(void)addFavoritesByFields:(NSString *)initials fullName:(NSString *)fullName managedObjectContext:(NSManagedObjectContext *)managedObjectContext;
+(Merchant *)getFavoriteByInitials:(NSString *)initials managedObjectContext:(NSManagedObjectContext *)managedObjectContext;

+(MerchantJSON *)getMerchantByOrgId:(NSString *)orgId;

@end
