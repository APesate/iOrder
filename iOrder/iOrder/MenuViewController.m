//
//  ViewController.m
//  iOrder
//
//  Created by Andrés Pesate on 2/21/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuCell.h"
#import "ModelHeaders.h"
#import "PedidoViewController.h"

@interface MenuViewController (){
    APTModelFactory* modelFactory;
    NSArray* categories;
    
    NSIndexPath* selectedCell;
    __weak IBOutlet UITableView* menuTableView;
}

@end

@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    modelFactory = [APTModelFactory sharedInstance];
    
    //[self initBDD];
    
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nombre"
                                                                   ascending:YES];
    categories = [NSArray arrayWithArray:[modelFactory fetchEntity:@"Categoria"
                                                withSortDescriptor:sortDescriptor]];
    
    //[self fillCategories];
    
    [menuTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initBDD{
    NSError* error;
    
    for (int i = 0; i < 5; i++) {
        Categoria* categoria = [[Categoria alloc] initWithEntity:[NSEntityDescription entityForName:@"Categoria" inManagedObjectContext:[modelFactory managedObjectContext]] insertIntoManagedObjectContext:[modelFactory managedObjectContext]];
        
        categoria.nombre = [NSString stringWithFormat:@"Categoria %i", i];
    }
    
    
    if (![[modelFactory managedObjectContext] save:&error]) {
        NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, error);
    }
    
}

- (void)fillCategories {
    NSError* error;
    
    for (Categoria* categorie in categories) {
        for (int i = 0; i < arc4random()%10 + 1; i++) {
            Producto* producto = [[Producto alloc] initWithEntity:[NSEntityDescription entityForName:@"Producto" inManagedObjectContext:[modelFactory managedObjectContext]] insertIntoManagedObjectContext:[modelFactory managedObjectContext]];
            
            producto.nombre = [NSString stringWithFormat:@"Producto %i", i];
            producto.precio = @((arc4random() % 100000) + 100000);
            producto.descripcion = @"Y, viéndole don Quijote de aquella manera, con muestras de tanta tristeza, le dijo: Sábete, Sancho, que no es un hombre más que otro si no hace más que otro. Todas estas borrascas que nos suceden son señales de que presto ha de serenar el tiempo y han de sucedernos bien las cosas; porque no es posible que el mal ni el bien sean durables, y de aquí se sigue que, habiendo durado mucho el mal, el bien está ya cerca. Así que, no debes congojarte por las desgracias que a mí me suceden, pues a ti no te cabe parte dellas.Y, viéndole don Quijote de aquella manera, con muestras de tanta tristeza, le dijo: Sábete, Sancho, que no es un hombre más que otro si no hace más que otro. Todas estas borrascas que nos suceden son señales de que presto ha de serenar el tiempo y han de sucedernos bien las cosas; porque no es posible que el mal ni el bien sean durables, y de aquí se sigue que, habiendo durado mucho el mal, el bien está ya cerca. Así que, no debes congojarte por las desgracias que a mí me suceden, pues a ti no";
            producto.fecha_creacion = [NSDate date];
            producto.fecha_actualizacion = [NSDate date];
            producto.belongsCategoria = categorie;
            producto.image =  UIImagePNGRepresentation([UIImage imageNamed:[NSString stringWithFormat:@"hamburguesa%i.png", (arc4random()%6 + 1)]]);
            
            [categorie addHasProductosObject:producto];
        }
        
        if (![[modelFactory managedObjectContext] save:&error]) {
            NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, error);
        }
        
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([selectedCell isEqual:indexPath]) {
        selectedCell = nil;
    }else{
        selectedCell = indexPath;
    }
    
    [tableView beginUpdates];
    [tableView endUpdates];
}

#pragma mark UITableViewDataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //Return the numbers of rows in each Section of the Table View
    return [[[(Categoria*)categories[section] hasProductos] allObjects] count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    //Return the number of Sections in the Table View
    return [categories count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cellID = @"MenuCell";
    
    MenuCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        //cell = [[MenuCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
        
    cell.producto = (Producto*)[[[(Categoria*)categories[indexPath.section] hasProductos] allObjects] objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [(Categoria*)categories[section] nombre];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath isEqual:selectedCell]) {
        return 200;
    }else{
        return 80;
    }
}
@end
