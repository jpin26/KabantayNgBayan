//
//  ActionViewCell.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *favoritesButton;
@property (weak, nonatomic) IBOutlet UIButton *moreActionsButton;

@property (weak, nonatomic) NSString *initials;
@property (weak, nonatomic) NSString *fullName;
@end
