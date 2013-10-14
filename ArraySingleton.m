//
//  ArraySingleton.m
//  attempt2
//
//  Created by Samuel Hall on 10/10/13.
//  Copyright (c) 2013 Samuel Hall. All rights reserved.
//

#import "ArraySingleton.h"

@implementation ArraySingleton

@synthesize arrGlobal;

+(ArraySingleton *)getInstance {
  static dispatch_once_t pred;
  static ArraySingleton *shared = nil;
  dispatch_once(&pred, ^{
    shared = [[ArraySingleton alloc] init];
    shared.arrGlobal = [[NSMutableArray alloc]init];
  });
  return shared;
}
@end
