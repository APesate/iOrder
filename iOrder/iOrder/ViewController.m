//
//  ViewController.m
//  iOrder
//
//  Created by Andrés Pesate on 1/26/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSMutableArray* secciones;
    NSMutableArray* tituloSecciones;
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

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    UILabel* title = [[UILabel alloc] initWithFrame:CGRectMake(22, 20, 320, 20)];
    [title setTextColor:[UIColor colorWithRed:0.945 green:0.769 blue:0.059 alpha:1.000]];
    [title setText:tituloSecciones[section]];
    
    [header addSubview:title];
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor colorWithRed:236 green:240 blue:241 alpha:1.0];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:0.928 green:0.937 blue:0.923 alpha:1.000];
    }
    
    cell.textLabel.text = secciones[indexPath.section][indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."];

    
    return cell;
}

@end
