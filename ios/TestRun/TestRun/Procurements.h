//
//  Procurements.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Procurements : NSManagedObject

@property (nonatomic, retain) NSString * referenceNumber;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * procuringEntity;
@property (nonatomic, retain) NSString * dateOfSubmission;
@property (nonatomic, retain) NSString * dateOfPublication;
@property (nonatomic, retain) NSString * bidStatus;
@property (nonatomic, retain) NSString * remarks;
@property (nonatomic, retain) NSString * closingDate;
@property (nonatomic, retain) NSString * bidCategory;
@property (nonatomic, retain) NSString * geotag;
@property (nonatomic, retain) NSDecimalNumber * bidAmount;
@property (nonatomic, retain) NSString * awardedToReference;
@property (nonatomic, retain) NSString * awardedToName;
@property (nonatomic, retain) NSNumber * awardedToMe;

@end
