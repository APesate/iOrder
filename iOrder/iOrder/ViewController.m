//
//  ViewController.m
//  iOrder
//
//  Created by Andrés Pesate on 1/26/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import "ViewController.h"
#import "MenuCell.h"

@interface ViewController (){
    NSMutableArray* secciones;
    NSMutableArray* tituloSecciones;
    NSArray* images;
    __weak IBOutlet UITableView* menuTableView;
    NSIndexPath* selectedCell;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    tituloSecciones = [NSMutableArray arrayWithCapacity:5];
    [tituloSecciones addObject:@"Entradas"];
    [tituloSecciones addObject:@"Sopas"];
    [tituloSecciones addObject:@"Carnes"];
    [tituloSecciones addObject:@"Aves"];
    [tituloSecciones addObject:@"Postres"];
    
    secciones = [NSMutableArray arrayWithCapacity:5];
    
    for (int i = 0; i < [tituloSecciones count]; i++) {
        
        int num = arc4random() % 5 + 1;
        NSMutableArray* array = [NSMutableArray arrayWithCapacity:num];
        
        for (int j = 0; j < num; j++) {
            [array addObject:[NSString stringWithFormat:@"%@ %i", [tituloSecciones objectAtIndex:i], j]];
        }
        
        [secciones addObject:array];
    }
    
    images = [NSArray arrayWithObjects:@"Ham1.png", @"ham2.png", @"ham3.png", @"ham4.png", @"ham5.png", @"ham6.png", nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return tituloSecciones[section];
}

//- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
//    
//    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(22, 20, 320, 20)];
//    [title setTextColor:[UIColor colorWithRed:0.945 green:0.769 blue:0.059 alpha:1.000]];
//    [title setText:tituloSecciones[section]];
//    
//    [header addSubview:title];
//    
//    return header;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (selectedCell != nil) {
        [(MenuCell *)[tableView cellForRowAtIndexPath:selectedCell] setIsCellSelected:NO];
    }
    
    if (selectedCell == nil || selectedCell != indexPath) {
        [(MenuCell *)[tableView cellForRowAtIndexPath:indexPath] setIsCellSelected:YES];
        selectedCell = indexPath;
    }else{
        selectedCell = nil;
    }
    
    [tableView beginUpdates];
    [tableView endUpdates];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([selectedCell compare:indexPath] == NSOrderedSame && selectedCell != nil) {
        return 210;
    }else{
        return 80;
    }
    
}

#pragma mark UITableViewDataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //Return the numbers of rows in each Section of the Table View
    return [[secciones objectAtIndex:section] count];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    //Return the number of Sections in the Table View
    return [secciones count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* cellID = @"menuCell";
    
    MenuCell * cell = (MenuCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuCell" owner:nil options:nil] firstObject];
    }
    
    cell.title.text = secciones[indexPath.section][indexPath.row];
    cell.description.text = [NSString stringWithFormat:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur."];
    cell.price.text = [NSString stringWithFormat:@"%i Bs",(arc4random() % 100000) + 100000];
    cell.image.image = [UIImage imageNamed:[images objectAtIndex:arc4random()%[images count]]];
    
    return cell;
}

@end
