//
//  JNWCoreDataAnalyzer.m
//  My Money
//
//  Created by Jaron West on 8/29/16.
//  Copyright © 2016 Jaron West. All rights reserved.
//

#import "JNWCoreDataAnalyzer.h"
#import <CoreData/CoreData.h>


@interface JNWCoreDataAnalyzer ()

@property NSManagedObjectContext *context;
@property NSManagedObjectModel *model;
@property NSArray *entities;
@property NSString *dbDescription;

@end


@implementation JNWCoreDataAnalyzer

- (id)initWithArrayOfEntityNames:(NSArray *)entities
                     withContext:(NSManagedObjectContext *)context
                       withModel:(NSManagedObjectModel *)model
{
    self = [super init];

    if (self) {
        self.context = context;
        self.model = model;
        self.entities = entities;
        [self setupDescription];
    }
    return self;
}

- (void)setupDescription {
    __block NSMutableString *desc;
    desc = [[NSMutableString alloc] initWithString:@""];
    [self.entities enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entDesc = [[self.model entitiesByName] objectForKey:obj];
        [request setEntity:entDesc];
        
        NSError *error = nil;
        NSArray *results = [self.context executeFetchRequest:request
                                                       error:&error];
        
        if (error) {
            desc = [@"Error" mutableCopy];
            return;
        }
        [results enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [desc appendString:[obj description]];
        }];
    }];
    self.dbDescription = [desc copy];
}

- (NSString *)description {
    return self.dbDescription;
}

@end
