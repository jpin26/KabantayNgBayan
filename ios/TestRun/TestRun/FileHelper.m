//
//  FileHelper.m
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import "FileHelper.h"

#import "Constants.h"

@implementation FileHelper

+(bool)createFileFromUrl:(NSString *)fileName url:(NSString *)url async:(BOOL)async
{
    __block bool hasError = NO;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    NSURL *fileUrl = [NSURL URLWithString:url];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.allowsCellularAccess = YES;
    config.timeoutIntervalForRequest = 10.0;
    config.timeoutIntervalForResource = 10.0;
    config.HTTPMaximumConnectionsPerHost = 1;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
    NSURLSessionDataTask *jsonData = [session dataTaskWithURL:fileUrl completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if(error == nil)
        {
            NSData *testData = data;
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSError *error;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            
            if (![fileManager fileExistsAtPath:documentsDirectory]) {
                
                [fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:&error];
            }
            
            NSString *writeFilePath = [documentsDirectory stringByAppendingPathComponent:[fileName lowercaseString]];
            
            [testData writeToFile:writeFilePath atomically:YES];
        }
        else
        {
            hasError = YES;
            NSLog(@"Error getting file from url : %@ \r\n with error %@", url, error.description);
        }
        
        dispatch_semaphore_signal(semaphore);
    }];
    
    [jsonData resume];
    
    dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 20.0 * NSEC_PER_SEC));
    return hasError;
}

+(void)createFileFromData:(NSString *)fileName data:(NSData *)data async:(BOOL)async
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if (![fileManager fileExistsAtPath:documentsDirectory]) {
        [fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:NO attributes:nil error:&error];
    }
    
    NSString *writeFilePath = [documentsDirectory stringByAppendingPathComponent:[fileName lowercaseString]];
    
    [data writeToFile:writeFilePath atomically:YES];
}

+(NSData *)getFileFromSupportingFiles:(NSString *)fileName
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    return [NSData dataWithContentsOfFile:filePath];
}

+(NSData *)getFileFromCreatedFiles:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[fileName lowercaseString]];
    return [NSData dataWithContentsOfFile:filePath];
}

+(UIImage *)getEmployeeImageForInitials:(NSString *)initials
{
    NSData *imageData = [self getFileFromCreatedFiles:[NSString stringWithFormat:@"%@.jpg", [initials lowercaseString]]];
    UIImage *image = [UIImage imageWithData:imageData];
    
    if(image == nil)
    {
        imageData = [self getFileFromSupportingFiles:[NSString stringWithFormat:@"%@.jpg", [initials uppercaseString]]];
        image = [UIImage imageWithData:imageData];
    }
    
    if(image == nil)
    {
        return [self getDefaultImageForContact];
    }
    
    return image;
}

@end
