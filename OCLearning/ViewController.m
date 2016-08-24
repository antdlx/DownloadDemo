//
//  ViewController.m
//  OCLearning
//
//  Created by antdlxding on 8/10/16.
//  Copyright © 2016 antdlxding. All rights reserved.
//

#import "ViewController.h"
#import "StaticTest.h"

#define weakify(var) __weak typeof(var) AHKWeak_##var = var;
#define strongify(var) \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Wshadow\"") \
__strong typeof(var) var = AHKWeak_##var; \
_Pragma("clang diagnostic pop")

@interface ViewController (){
   }
@property(nonatomic,strong) NSURLSession *session;
@property(nonatomic,strong) NSURLSessionDownloadTask * task;
@property(nonatomic,strong) NSData * resumeData;

@end

@implementation ViewController

- (void)viewDidLoad {

    NSURL *url = [NSURL URLWithString:@"http://220.194.207.53/ws.acgvideo.com/7/f8/9169155-1hd.mp4?wsTime=1472038963&wsSecret2=d8a471f8d6f1d10d0ead58dfb89f2dde&oi=2015071171&wshc_tag=0&wsts_tag=57bd17b3&wsid_tag=3d87ac44&wsiphost=ipdbm"];
    self.session  = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    self.task = [self.session downloadTaskWithURL:url];
    
}

- (IBAction)StartHandle:(id)sender {
    [self.task resume];
}
- (IBAction)PauseHandle:(id)sender {
    
    weakify(self);
    [self.task cancelByProducingResumeData:^(NSData * resumeData){
        strongify(self);
        self.resumeData = resumeData;
        self.task = nil;
    }];
    
}
- (IBAction)RestartHandle:(id)sender {
    self.task = [self.session downloadTaskWithResumeData:self.resumeData];
    [self.task resume];
    self.resumeData = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark delegate
//每次写入沙盒完毕后会调用
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    self.progLabel.text = [NSString stringWithFormat:@"progress : %.2f %%",(double)totalBytesWritten/totalBytesExpectedToWrite*100];
    [self.prog setProgress:(double)totalBytesWritten/totalBytesExpectedToWrite animated:YES];
}

//恢复下载的时候调用
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    
    NSLog(@"RESUME");
}

//下载完毕的时候会调用
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    NSString * caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString * filename = [caches stringByAppendingString:@"/testVideo.mp4"];
    NSLog(@"cache document is %@",caches);
    NSFileManager * fg = [NSFileManager defaultManager];
    [fg moveItemAtPath:location.path toPath:filename error:nil];
}


@end
