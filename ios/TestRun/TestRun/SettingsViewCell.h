//
//  SettingsViewCell.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/23/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *settingName;
@property (weak, nonatomic) IBOutlet UISwitch *settingToggle;

@end
