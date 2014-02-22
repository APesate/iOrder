//
//  Categoria.h
//  iOrder
//
//  Created by Andrés Pesate on 2/21/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Producto;

@interface Categoria : NSManagedObject

@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSSet *hasProductos;
@end

@interface Categoria (CoreDataGeneratedAccessors)

- (void)addHasProductosObject:(Producto *)value;
- (void)removeHasProductosObject:(Producto *)value;
- (void)addHasProductos:(NSSet *)values;
- (void)removeHasProductos:(NSSet *)values;

@end
