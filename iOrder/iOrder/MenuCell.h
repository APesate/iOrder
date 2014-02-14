//
//  MenuCell.h
//  iOrder
//
//  Created by Andrés Pesate on 2/10/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *description;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (assign, nonatomic) BOOL isCellSelected;

- (void)displayContentForSelectedRow;
- (void)hideContentForSelectedRow;

@end
