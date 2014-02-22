//
//  Producto.h
//  iOrder
//
//  Created by Andrés Pesate on 2/22/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categoria, Factura;

@interface Producto : NSManagedObject

@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSDate * fecha_actualizacion;
@property (nonatomic, retain) NSDate * fecha_creacion;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSNumber * precio;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) Categoria *belongsCategoria;
@property (nonatomic, retain) NSSet *belongsToFacturas;
@end

@interface Producto (CoreDataGeneratedAccessors)

- (void)addBelongsToFacturasObject:(Factura *)value;
- (void)removeBelongsToFacturasObject:(Factura *)value;
- (void)addBelongsToFacturas:(NSSet *)values;
- (void)removeBelongsToFacturas:(NSSet *)values;

@end
