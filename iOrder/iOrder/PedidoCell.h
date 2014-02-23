//
//  PedidoCell.h
//  iOrder
//
//  Created by Andrés Pesate on 2/21/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PedidoCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* title;
@property (weak, nonatomic) IBOutlet UILabel* precio;
@property (weak, nonatomic) IBOutlet UIImageView* image;
@property (weak, nonatomic) IBOutlet UIButton* comentariosButton;
@property (weak, nonatomic) IBOutlet UILabel *cantidad;

@end
