//
//  Survey.m
//  iPad-YOU-Pad
//
//  Created by Pangpang.i.Lily on 13-10-8.
//  Copyright (c) 2013年 Andrew Edwards. All rights reserved.
//

#import "Survey.h"


@implementation Survey

@dynamic file_name;
@dynamic kid_id;
@dynamic kid_name;
@dynamic researcher_name;
@dynamic uploaded;
- (NSString *)sectionPath {
    if(self.uploaded){
        return @"Uploaded";
    }
    else{
        return @"UnUploaded";
    }
    
    //return [self.acctPeriod substringToIndex:4];
}
@end
