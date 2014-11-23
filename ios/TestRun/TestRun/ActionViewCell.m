//
//  ActionViewCell.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import "ActionViewCell.h"

@implementation ActionViewCell

@synthesize favoritesButton = _favoritesButton;
@synthesize moreActionsButton = _moreActionsButton;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}
@end
