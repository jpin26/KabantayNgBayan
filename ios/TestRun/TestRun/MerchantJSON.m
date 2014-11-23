//
//  MerchantJSON.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import "MerchantJSON.h"

@implementation MerchantJSON

-(void)MapToManagedObject:(Merchant *)merchant
{
    merchant.mobile = self.mobile;
    merchant.email = self.email;
    merchant.organization = self.organizationname;
    //merchant.organizationId = self.organizationid;
    merchant.categories = self.categories;
    merchant.region = self.region;
}

@end
