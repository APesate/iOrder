//
//  Factura.h
//  iOrder
//
//  Created by Andrés Pesate on 2/22/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Producto;

typedef enum {
    SinOrdenar = 0,
    Enviada = 1,
    Recibida = 2,
    EnPreparacion = 3,
    Lista = 4
} kEstadoFactura;

@interface Factura : NSManagedObject

@property (nonatomic, retain) NSDate * fecha_creacion;
@property (nonatomic, retain) NSNumber * estado;
@property (nonatomic, retain) NSSet *productos;
@end

@interface Factura (CoreDataGeneratedAccessors)

- (void)addProductosObject:(Producto *)value;
- (void)removeProductosObject:(Producto *)value;
- (void)addProductos:(NSSet *)values;
- (void)removeProductos:(NSSet *)values;

@end
