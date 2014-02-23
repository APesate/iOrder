//
//  Producto.h
//  iOrder
//
//  Created by Andrés Pesate on 2/22/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categoria;

@interface Producto : NSManagedObject

@property (nonatomic, retain) NSString * descripcion;
@property (nonatomic, retain) NSDate * fecha_actualizacion;
@property (nonatomic, retain) NSDate * fecha_creacion;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * nombre;
@property (nonatomic, retain) NSNumber * precio;
@property (nonatomic, retain) Categoria *belongsCategoria;
@property (nonatomic, retain) NSSet *factura;
@end

@interface Producto (CoreDataGeneratedAccessors)

- (void)addFacturaObject:(NSManagedObject *)value;
- (void)removeFacturaObject:(NSManagedObject *)value;
- (void)addFactura:(NSSet *)values;
- (void)removeFactura:(NSSet *)values;

@end
