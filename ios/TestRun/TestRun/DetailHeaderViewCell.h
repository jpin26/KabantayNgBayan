//
//  DetailHeaderViewCell.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailHeaderViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellFullName;
@property (weak, nonatomic) IBOutlet UILabel *cellInitials;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@end
