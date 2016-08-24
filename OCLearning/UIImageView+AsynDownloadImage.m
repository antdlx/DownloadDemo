//
//  UIImageView+AsynDownloadImage.m
//  OCLearning
//
//  Created by antdlxding on 8/12/16.
//  Copyright © 2016 antdlxding. All rights reserved.
//

#import "UIImageView+AsynDownloadImage.h"

static NSOperationQueue * queue = nil;
static NSMutableDictionary * operations = nil;
static NSMutableDictionary * images = nil;

@implementation UIImageView (AsynDownloadImage)

-(NSOperationQueue *)getQueue{
    if (queue == nil) {
        queue = [[NSOperationQueue alloc] init];
    }
    return queue;
}

-(NSMutableDictionary *)getImages{
    if (images == nil) {
        images = [NSMutableDictionary dictionary];
    }
    return images;
}

-(NSMutableDictionary *)getOperations{
    if (operations == nil) {
        operations = [NSMutableDictionary dictionary];
    }
    return operations;
}

-(void)SetImageWithURLString:(NSString *)url{
    queue = [self getQueue];
    images = [self getImages];
    operations = [self getOperations];
    
    UIImage *image = images[url];
    if (image) {
        self.image = image;
    }else{
        
        NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString * filePath = [cachesPath stringByAppendingPathComponent:[url lastPathComponent]];
        NSData * imageData = [NSData dataWithContentsOfFile:filePath];
        
        if (imageData) {
           self.image = [UIImage imageWithData:imageData];
        }else{
            self.image = [UIImage imageNamed:@"p.png"];
        }
    }
    
}

+(void)SuspendQueue{
    [queue setSuspended:YES];
}

+(void)RestartQueue{
    [queue setSuspended:NO];
}

@end
