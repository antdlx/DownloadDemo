//
//  ViewController.h
//  OCLearning
//
//  Created by antdlxding on 8/10/16.
//  Copyright © 2016 antdlxding. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLSessionDownloadDelegate>

@property(nonatomic,copy) NSString * pro;
@property (strong, nonatomic) IBOutlet UIButton *btnStat;
@property (strong, nonatomic) IBOutlet UIButton *btnpause;
@property (strong, nonatomic) IBOutlet UIButton *btnRestart;
@property (strong, nonatomic) IBOutlet UIProgressView *prog;
@property (strong, nonatomic) IBOutlet UILabel *progLabel;

@end

