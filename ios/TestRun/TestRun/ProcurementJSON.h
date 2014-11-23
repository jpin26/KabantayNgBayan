//
//  ProcurementJSON.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Procurements.h"


#import "JSONModel.h"

@interface ProcurementJSON  : JSONModel
@property (strong, nonatomic) NSString * item_description;
@property (strong, nonatomic) NSString * item_name;
@property (strong, nonatomic) NSString * referencenumber;
@property (strong, nonatomic) NSString * title;
@property (strong, nonatomic) NSString * procuringentity;
//@property (strong, nonatomic) NSString * dateofsubmission;
@property (strong, nonatomic) NSString * dateofpublication;
@property (strong, nonatomic) NSString * bidstatus;
@property (strong, nonatomic) NSString * remarks;
@property (strong, nonatomic) NSString * closingdate;
@property (strong, nonatomic) NSString * bidcategory;
@property (strong, nonatomic) NSString * geotag;
@property (strong, nonatomic) NSString * bidamount;
@property (strong, nonatomic) NSString * budget;
@property (strong, nonatomic) NSString * uom;
@property (strong, nonatomic) NSString * line_item_id;
@property (strong, nonatomic) NSString * awardedtoreference;
@property (strong, nonatomic) NSString * awardedtoname;
@property (strong, nonatomic) NSString * awardedtome;

-(void)MapToManagedObject:(Procurements *)procurement;

@end
