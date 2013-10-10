//
//  Survey.h
//  iPad-YOU-Pad
//
//  Created by Pangpang.i.Lily on 13-10-8.
//  Copyright (c) 2013年 Andrew Edwards. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Survey : NSManagedObject

@property (nonatomic, retain) NSString * file_name;
@property (nonatomic, retain) NSString * kid_id;
@property (nonatomic, retain) NSString * kid_name;
@property (nonatomic, retain) NSString * researcher_name;
@property (nonatomic, retain) NSNumber * uploaded;

@end
