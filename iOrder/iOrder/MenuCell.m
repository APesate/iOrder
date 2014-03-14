//
//  MenuCell.m
//  iOrder
//
//  Created by Andrés Pesate on 2/21/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell{
    APTModelFactory* modelFactory;
}
@synthesize producto = _producto;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        modelFactory = [APTModelFactory sharedInstance];
        _isSelected = NO;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        modelFactory = [APTModelFactory sharedInstance];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    if (_isSelected) {
        CGSize size = [self resizeLabel];
        [UIView animateWithDuration:0.5f animations:^{
            [_description setFrame:CGRectMake(_description.frame.origin.x,
                                             _description.frame.origin.y,
                                             _description.frame.size.width,
                                              size.height)];
        }];
    } else {
        [UIView animateWithDuration:0.5f animations:^{
            [_description setFrame:CGRectMake(_description.frame.origin.x,
                                              _description.frame.origin.y,
                                              _description.frame.size.width,
                                              41)];
        }];
    }
    
    _isSelected = !_isSelected;
}

- (CGSize)resizeLabel
{
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"Helvetica Neue" size:12], NSFontAttributeName,
                                          nil];
    
    CGRect frame = [_description.text boundingRectWithSize:CGSizeMake(_description.frame.size.width, 2000.0)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributesDictionary
                                            context:nil];
    
    CGSize size = frame.size;
    NSLog(@"%.2f, %.2f", size.width, size.height);
    
    return size;
}

- (void)setProducto:(Producto *)producto{
    if (![_producto isEqual:producto]) {
        _producto = producto;
        _title.text = [producto nombre];
        _description.text = [producto descripcion];
        _price.text = [NSString stringWithFormat:@"Bs.%@", [producto precio]];
        _image.image = [UIImage imageWithData:[producto image]];
    }
}

- (IBAction)addToOrder:(UIButton *)sender {    
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"fecha_creacion" ascending:NO];
    
    Factura* factura = (Factura*)[modelFactory fetchRecentObjectInEntity:@"Factura" withSort:sortDescriptor];
    
    if (factura) {
        if (factura.estado.integerValue == SinOrdenar) {
            
            if (![self facturaContainsProduct:factura]) {
                [self addProductToFactura:factura];
            } else {
                [self incrementProductQuantityForFactura:factura];
            }
        } else {
            [self crearNuevaFactura];
        }
    } else {
        [self crearNuevaFactura];
    }
}

- (BOOL)facturaContainsProduct:(Factura*)factura{
    __block BOOL duplicate = NO;
    
    [[factura factura] enumerateObjectsUsingBlock:^(FacturaHasProducto* obj, BOOL *stop) {
                if ([[obj productos] isEqual:_producto]) {
                    duplicate = YES;
                    *stop = YES;
                }
    }];
    
    return duplicate;
}

- (void)incrementProductQuantityForFactura:(Factura*)factura{
    [[factura factura] enumerateObjectsUsingBlock:^(FacturaHasProducto* obj, BOOL *stop) {
        if ([[obj productos] isEqual:_producto]) {
            [obj setCantidad:@([[obj cantidad] integerValue] + 1)];
            *stop = YES;
        }
    }];
}

- (void)addProductToFactura:(Factura*)factura{
    FacturaHasProducto* newProduct = [[FacturaHasProducto alloc] initWithEntity:[NSEntityDescription entityForName:@"FacturaHasProducto" inManagedObjectContext:[modelFactory managedObjectContext]] insertIntoManagedObjectContext:[modelFactory managedObjectContext]];
    
    [newProduct setCantidad:@(1)];
    [newProduct setFactura:factura];
    [newProduct setProductos:_producto];
    
    [factura addFacturaObject:newProduct];
    
    NSError* error;
    if (![[modelFactory managedObjectContext] save:&error]){
        NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, [error localizedDescription]);
    }

}

- (void)crearNuevaFactura {
    Factura* factura = [[Factura alloc] initWithEntity:[NSEntityDescription entityForName:@"Factura" inManagedObjectContext:[modelFactory managedObjectContext]] insertIntoManagedObjectContext:[modelFactory managedObjectContext]];
    
    [factura setFecha_creacion:[NSDate date]];
    [factura setEstado:@(SinOrdenar)];
   
    [self addProductToFactura:factura];
}

@end
