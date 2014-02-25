//
//  MenuCell.h
//  iOrder
//
//  Created by Andrés Pesate on 2/21/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelHeaders.h"

@interface MenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) Producto* producto;
@property (assign, nonatomic) BOOL isSelected;

@end
