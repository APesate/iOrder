//
//  FacturaHasProducto.h
//  iOrder
//
//  Created by Andrés Pesate on 2/22/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Factura, Producto;

@interface FacturaHasProducto : NSManagedObject

@property (nonatomic, retain) NSNumber * cantidad;
@property (nonatomic, retain) Factura *factura;
@property (nonatomic, retain) Producto *productos;

@end
