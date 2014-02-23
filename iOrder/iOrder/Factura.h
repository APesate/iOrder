//
//  Factura.h
//  iOrder
//
//  Created by Andrés Pesate on 2/22/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FacturaHasProducto;

typedef enum {
    SinOrdenar = 0,
    Enviada = 1,
    Recibida = 2,
    EnPreparacion = 3,
    Lista = 4
} kEstadoFactura;

@interface Factura : NSManagedObject

@property (nonatomic, retain) NSNumber * estado;
@property (nonatomic, retain) NSDate * fecha_creacion;
@property (nonatomic, retain) NSSet *factura;
@end

@interface Factura (CoreDataGeneratedAccessors)

- (void)addFacturaObject:(FacturaHasProducto *)value;
- (void)removeFacturaObject:(FacturaHasProducto *)value;
- (void)addFactura:(NSSet *)values;
- (void)removeFactura:(NSSet *)values;

@end
