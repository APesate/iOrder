//
//  APTModelFactory.h
//  iOrder
//
//  Created by Andrés Pesate on 2/21/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APTModelFactory : NSObject

@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel* managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator;


+ (instancetype)sharedInstance;

- (NSArray*)fetchEntity:(NSString*)entityName withSortDescriptor:(NSSortDescriptor*)sortDescriptor;
- (NSArray *)fetchEntity:(NSString*)entityName withPredicate:(NSPredicate *)predicate;
- (NSInteger)numberOfElementsForEntity:(NSString*)entityName withSortDescriptor:(NSSortDescriptor*)sortDescriptor;
- (instancetype)fetchRecentObjectInEntity:(NSString*)entityName withSort:(NSSortDescriptor*)sortDescriptor;
- (void)addCategories:(NSArray *)categories;
- (void)addProducts:(NSArray *)products ForCategorie:(int)categorieId;
- (NSDictionary *)objectToDictionary:(id)object;

@end
