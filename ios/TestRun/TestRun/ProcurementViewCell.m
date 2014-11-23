//
//  ContactViewCell.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import "ProcurementViewCell.h"

@implementation ProcurementViewCell
@synthesize cellName = _cellName;
@synthesize cellDescription = _cellDescription;
@synthesize cellImage = _cellImage;

- (void)awakeFromNib
{
    // Initialization code
    //self.cellImage.layer.cornerRadius = self.cellImage.frame.size.width / 2;
    self.cellImage.layer.cornerRadius = 10;
    self.cellImage.clipsToBounds = YES;
    //self.cellImage.layer.borderWidth = 1.0f;
    //self.cellImage.layer.borderColor = [UIColor blackColor].CGColor;    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
