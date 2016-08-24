//
//  UIImageView+AsynDownloadImage.h
//  OCLearning
//
//  Created by antdlxding on 8/12/16.
//  Copyright © 2016 antdlxding. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIImageView (AsynDownloadImage)

-(void)SetImageWithURLString:(NSString*) url;
+(void)SuspendQueue;
+(void)RestartQueue;
-(NSOperationQueue *)getQueue;
-(NSMutableDictionary *)getOperations;
-(NSMutableDictionary *)getImages;

@end
