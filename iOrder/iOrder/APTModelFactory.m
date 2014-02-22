//
//  APTModelFactory.m
//  iOrder
//
//  Created by Andrés Pesate on 2/21/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import "APTModelFactory.h"
#import "AppDelegate.h"
#import "Producto.h"
#import "Categoria.h"

@implementation APTModelFactory{
    NSFileManager* fileManager;
    NSURL* documentsDirectory;
}

@synthesize managedObjectContext = _managedObjectContext, managedObjectModel = _managedObjectModel, persistentStoreCoordinator = _persistentStoreCoordinator;

static APTModelFactory* sModelFactory;

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sModelFactory = [[APTModelFactory alloc] init];
    });
    
    return sModelFactory;
}

-(id)init{
    self = [super init];
    
    if(self){
        _managedObjectModel = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectModel;
        _managedObjectContext = ((AppDelegate*)[UIApplication sharedApplication].delegate).managedObjectContext;
        _persistentStoreCoordinator = ((AppDelegate*)[UIApplication sharedApplication].delegate).persistentStoreCoordinator;
        fileManager = [NSFileManager defaultManager];
        documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    }
    
    return self;
}

- (NSArray*)fetchEntity:(NSString*)entityName withSortDescriptor:(NSSortDescriptor*)sortDescriptor {
        if ([fileManager fileExistsAtPath:[[documentsDirectory URLByAppendingPathComponent:@"Model.sqlite"] path]]) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                                  inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        NSError *error = nil;
        NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if (fetchedObjects == nil) {
            NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, error);
        } else {
            return fetchedObjects;
        }

        
    } else {
        NSLog(@"Error [%s, %d]: No se encontro el archivo solicitado", __PRETTY_FUNCTION__, __LINE__);
    }
    
    return 0;
}

- (NSInteger)numberOfElementsForEntity:(NSString*)entityName withSortDescriptor:(NSSortDescriptor*)sortDescriptor{
    if ([fileManager fileExistsAtPath:[[documentsDirectory URLByAppendingPathComponent:@"Model.sqlite"] path]]) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                                  inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        NSError *error = nil;
        NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if (fetchedObjects == nil) {
            NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, error);
        } else {
            return [fetchedObjects count];
        }

        
    } else {
        NSLog(@"Error [%s, %d]: No se encontro el archivo solicitado", __PRETTY_FUNCTION__, __LINE__);
    }
    
    return 0;
}

- (id)fetchRecentObjectInEntity:(NSString*)entityName withSort:(NSSortDescriptor*)sortDescriptor{
    if ([fileManager fileExistsAtPath:[[documentsDirectory URLByAppendingPathComponent:@"Model.sqlite"] path]]) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                                  inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
        
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        NSError *error = nil;
        NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:fetchRequest error:&error];
        
        if (fetchedObjects == nil) {
            NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, error);
        }else{
            return [fetchedObjects firstObject];
        }
    }
    
    return nil;
}
@end
