//
//  StaticTest.m
//  OCLearning
//
//  Created by antdlxding on 8/10/16.
//  Copyright © 2016 antdlxding. All rights reserved.
//

#import "StaticTest.h"

static NSString * str = @"aaa";

@implementation StaticTest

-(void)changeStr:(NSString *)string{
    
    NSLog(@"%@",str);
    str = string;
    
}

-(void)printStr{
    NSLog(@">>>%@",str);
}
@end
