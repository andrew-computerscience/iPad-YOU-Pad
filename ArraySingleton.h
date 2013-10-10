//
//  ArraySingleton.h
//  attempt2
//
//  Created by Samuel Hall on 10/10/13.
//  Copyright (c) 2013 Samuel Hall. All rights reserved.
//

@interface ArraySingleton : NSObject {
  
  NSMutableArray *arrGlobal;
  
}

@property(nonatomic,retain)NSMutableArray *arrGlobal;

+(ArraySingleton*)getInstance;

@end

