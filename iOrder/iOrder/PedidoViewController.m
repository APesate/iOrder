//
//  PedidoViewController.m
//  iOrder
//
//  Created by Andrés Pesate on 2/21/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import "PedidoViewController.h"
#import "PedidoCell.h"
#import "ModelHeaders.h"
#import "WebServicesObject.h"

@interface PedidoViewController (){
    
    __weak IBOutlet UILabel *totalOrden;
    __weak IBOutlet UITableView* pedidoTableView;
    __weak IBOutlet UIImageView* statusImage;
    __weak IBOutlet UILabel* statusLabel;
    
    NSMutableArray* ordenActual;
    APTModelFactory* modelFactory;
    WebServicesObject* webServicesObject;
    
}
- (IBAction)realizarOrden:(id)sender;

@end

@implementation PedidoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    modelFactory = [APTModelFactory sharedInstance];
    webServicesObject = [WebServicesObject sharedInstance];
}

- (void)viewWillAppear:(BOOL)animated{
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"fecha_creacion" ascending:NO];
    Factura* factura = (Factura*)[modelFactory fetchRecentObjectInEntity:@"Factura" withSort:sortDescriptor];
    
    ordenActual = [NSMutableArray arrayWithArray:[[factura factura] allObjects]];
    

    switch (factura.estado.integerValue) {
        case SinOrdenar:
            statusLabel.text = @"Sin Ordenar";
            break;
        case Enviada:
            statusLabel.text = @"Enviada";
            break;
        case Recibida:
            statusLabel.text = @"Recibida";
            break;
        case EnPreparacion:
            statusLabel.text = @"EnPreparacion";
            break;
        case Lista:
            statusLabel.text = @"Lista";
            break;
            
        default:
            break;
    }
    int total = 0;
    for (FacturaHasProducto* producto in ordenActual) {
        total += (producto.productos.precio.integerValue * producto.cantidad.integerValue);
    }
    
    totalOrden.text = [NSString stringWithFormat:@"Bs. %i", total];
    
    [pedidoTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)realizarOrden:(id)sender {
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"fecha_creacion" ascending:NO];
    
    Factura* factura = (Factura*)[modelFactory fetchRecentObjectInEntity:@"Factura" withSort:sortDescriptor];
    
    if (factura.estado.integerValue != Lista) {
        factura.estado = @(Lista);
        statusLabel.text = @"Lista";
        [webServicesObject addNewOrderForUser:1];
        
        NSError* error;
        if (![[modelFactory managedObjectContext] save:&error]) {
            NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, error);
        }
    }
}

#pragma mark - UITableViewDataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //Return the numbers of rows in each Section of the Table View
    return [ordenActual count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    //Return the number of Sections in the Table View
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cellID = @"pedidoCell";
    
    PedidoCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[PedidoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    FacturaHasProducto* producto = ordenActual[indexPath.row];
    
    cell.title.text = [[producto productos] nombre];
    cell.image.image = [UIImage imageWithData:[[producto productos] image]];
    cell.precio.text = [NSString stringWithFormat:@"Bs. %li", (long)[[[producto productos] precio] integerValue]];
    cell.cantidad.text = [NSString stringWithFormat:@"%li", (long)[[producto cantidad] integerValue]];
    
    return cell;
}
@end
