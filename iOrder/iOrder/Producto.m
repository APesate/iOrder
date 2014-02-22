//
//  Producto.m
//  iOrder
//
//  Created by Andrés Pesate on 2/22/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import "Producto.h"
#import "Categoria.h"
#import "Factura.h"


@implementation Producto

@dynamic descripcion;
@dynamic fecha_actualizacion;
@dynamic fecha_creacion;
@dynamic nombre;
@dynamic precio;
@dynamic image;
@dynamic belongsCategoria;
@dynamic belongsToFacturas;

@end
