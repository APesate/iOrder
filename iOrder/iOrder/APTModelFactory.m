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
#import "FacturaHasProducto.h"

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

- (void)addCategories:(NSArray *)categories {
        NSError* error;
        for (NSDictionary* categorie in categories) {
            Categoria* categoria = [[Categoria alloc] initWithEntity:[NSEntityDescription entityForName:@"Categoria" inManagedObjectContext:_managedObjectContext] insertIntoManagedObjectContext:_managedObjectContext];
    
            categoria.nombre = [categorie objectForKey:@"name"];
            categoria.ident = @([[categorie objectForKey:@"id"] integerValue]);
        }
    
    
        if (![_managedObjectContext save:&error]) {
            NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, error);
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
        }
}

- (NSArray *)fetchEntity:(NSString*)entityName withPredicate:(NSPredicate *)predicate {
    if ([fileManager fileExistsAtPath:[[documentsDirectory URLByAppendingPathComponent:@"Model.sqlite"] path]]) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                                  inManagedObjectContext:_managedObjectContext];
        [fetchRequest setEntity:entity];
 
        [fetchRequest setPredicate:predicate];
        
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

- (void)addProducts:(NSArray *)products ForCategorie:(int)categorieId {
    NSError* error;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"ident = %i", categorieId];
    
    Categoria* categorie = (Categoria *)[[self fetchEntity:@"Categoria" withPredicate:predicate] firstObject];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    for (NSDictionary* obj in products) {
        
        Producto* product = [[Producto alloc] initWithEntity:[NSEntityDescription entityForName:@"Producto" inManagedObjectContext:_managedObjectContext] insertIntoManagedObjectContext:_managedObjectContext];
        
        product.ident = @([[obj objectForKey:@"id"] integerValue]);
        product.nombre = [obj objectForKey:@"name"];
        product.precio = @([[obj objectForKey:@"precio"] integerValue]);
        product.descripcion = [obj objectForKey:@"description"];
        
        NSString* urlString = [NSString stringWithFormat:@"http://127.0.0.1/iOrder/%@", [obj objectForKey:@"image"]];
        NSURL* url = [NSURL URLWithString:urlString];
        
        dispatch_async(dispatch_queue_create("image", nil), ^{
            product.image = [NSData dataWithContentsOfURL:url];
        });
        
        product.fecha_actualizacion = [df dateFromString:[obj objectForKey:@"update_date"]];
        product.fecha_creacion = [df dateFromString:[obj objectForKey:@"creation_date"]];
        product.belongsCategoria = categorie;
        
        [categorie addHasProductosObject:product];
    }
    
    if (![_managedObjectContext save:&error]) {
        NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, [error localizedDescription]);
    } else {
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadData" object:nil];
    }
}

- (NSDictionary *)objectToDictionary:(id)object {
    if ([object isKindOfClass: [Producto class]]) {
        NSDictionary* objectDict = @{@"name": [(Producto *)object nombre],
                                     @"id": [(Producto *)object ident]};
        
        return objectDict;
    }
    
    return nil;
}

@end
