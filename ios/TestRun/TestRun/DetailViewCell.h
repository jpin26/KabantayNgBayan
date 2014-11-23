//
//  DetailViewCell.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellKey;
@property (weak, nonatomic) IBOutlet UILabel *cellValue;

@property (assign, nonatomic) BOOL messageAble;
@property (assign, nonatomic) BOOL emailAble;
@property (assign, nonatomic) BOOL drillAble;
@property (assign, nonatomic) BOOL callAble;

- (UIButton *) makeMailButton:(SEL) selector target:(UIViewController *)target;

- (UIButton *) makeMessageButton:(SEL) selector target:(UIViewController *)target;

- (UIButton *) makeCallButton:(SEL) selector target:(UIViewController *)target;

- (UIView *) makeCallAndMessageButton:(SEL)callSelector messageSelector:(SEL)messageSelector target:(UIViewController *)target;
@end
