//
//  DetailViewCell.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import "DetailViewCell.h"
#import "FileHelper.h"

@implementation DetailViewCell

@synthesize cellKey = _cellKey;
@synthesize cellValue = _cellValue;

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (UIButton *) makeMailButton:(SEL)selector target:(UIViewController *)target
{
    UIImage *image = [[UIImage alloc] initWithData:[FileHelper getFileFromSupportingFiles:@"email.png"]];
    return [self makeButton:selector target:target image:image positionTwo:NO];
}

- (UIButton *) makeCallButton:(SEL)selector target:(UIViewController *)target
{
    UIImage *image = [[UIImage alloc] initWithData:[FileHelper getFileFromSupportingFiles:@"call.png"]];
    return [self makeButton:selector target:target image:image positionTwo:NO];
}

- (UIButton *) makeMessageButton:(SEL)selector target:(UIViewController *)target
{
    UIImage *image = [[UIImage alloc] initWithData:[FileHelper getFileFromSupportingFiles:@"message.png"]];
    return [self makeButton:selector target:target image:image positionTwo:NO];
}

- (UIView *) makeCallAndMessageButton:(SEL)callSelector messageSelector:(SEL)messageSelector target:(UIViewController *)target
{
    UIView *accView = [[UIView alloc] init];
    CGRect frame = CGRectMake(0.0, 0.0, 80, 30);
    accView.frame = frame;
    
    UIImage *callImage = [[UIImage alloc] initWithData:[FileHelper getFileFromSupportingFiles:@"call.png"]];
    UIImage *messageImage = [[UIImage alloc] initWithData:[FileHelper getFileFromSupportingFiles:@"message.png"]];
    
    [accView addSubview:[self makeButton:messageSelector target:target image:messageImage positionTwo:NO]];
    [accView addSubview:[self makeButton:callSelector target:target image:callImage positionTwo:YES]];
    
    return accView;
}

- (UIButton *) makeButton:(SEL) selector target:(UIViewController *)target image:(UIImage *)image positionTwo:(BOOL)posTwo
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = posTwo ? CGRectMake(50.0, 0.0, 30, 30) : CGRectMake(0.0, 0.0, 30, 30);
    button.frame = frame;
    
    if (image != nil) {
        [button setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end
