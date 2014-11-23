//
//  MerchantJSON.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "JSONModel.h"
#import "Merchant.h"

@interface MerchantJSON : JSONModel

@property (strong, nonatomic) NSString * mobile;
@property (strong, nonatomic) NSString * email;
@property (strong, nonatomic) NSString * organizationname;
@property (strong, nonatomic) NSString * organizationid;
@property (strong, nonatomic) NSString * categories;
@property (strong, nonatomic) NSString * region;


-(void)MapToManagedObject:(Merchant *)merchant;

@end
