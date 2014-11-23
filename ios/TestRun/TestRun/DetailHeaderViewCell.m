//
//  DetailHeaderViewCell.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import "DetailHeaderViewCell.h"

@implementation DetailHeaderViewCell
@synthesize cellFullName = _cellFullName;
@synthesize cellInitials = _cellInitials;
@synthesize cellImage = _cellImage;

- (void)awakeFromNib
{
    self.cellImage.layer.cornerRadius = 10;
    self.cellImage.clipsToBounds = YES;
    self.cellImage.layer.borderColor = [UIColor blackColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
