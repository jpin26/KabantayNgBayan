//
//  FileHelper.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FileHelper : NSObject

+(bool)createFileFromUrl:(NSString *)fileName url:(NSString *)url async:(BOOL)async;
+(void)createFileFromData:(NSString *)fileName data:(NSData *)data async:(BOOL)async;

+(NSData *)getFileFromSupportingFiles:(NSString *)fileName;
+(NSData *)getFileFromCreatedFiles:(NSString *)fileName;

+(UIImage *)getEmployeeImageForInitials:(NSString *)initials;
+(UIImage *)getEmployeeImageFromPhonebookForInitials:(NSString *)initials;
+(UIImage *)getDefaultImageForContact;

@end
