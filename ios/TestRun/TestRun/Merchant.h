//
//  Merchant.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Merchant : NSManagedObject

@property (nonatomic, retain) NSString * fullName;
@property (nonatomic, retain) NSString * mobile;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * organization;
@property (nonatomic, retain) NSString * organizationId;
@property (nonatomic, retain) NSString * categories;
@property (nonatomic, retain) NSString * region;

@end
