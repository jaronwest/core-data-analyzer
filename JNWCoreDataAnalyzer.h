//
//  JNWCoreDataAnalyzer.h
//  My Money
//
//  Created by Jaron West on 8/29/16.
//  Copyright © 2016 Jaron West. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNWCoreDataAnalyzer : NSObject

- (id)initWithArrayOfEntityNames:(NSArray *)entities
                     withContext:(NSManagedObjectContext *)context
                       withModel:(NSManagedObjectModel *)model;

// overridden to describe all instances in given entities
- (NSString *)description;

@end
