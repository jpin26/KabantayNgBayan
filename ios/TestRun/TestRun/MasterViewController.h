//
//  MasterViewController.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface MasterViewController : UITabBarController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
