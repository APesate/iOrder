//
//  MenuCell.m
//  iOrder
//
//  Created by Andrés Pesate on 2/10/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell{

}
@synthesize isCellSelected = _isCellSelected;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
    if (_isCellSelected) {
        [UIView animateWithDuration:0.5f animations:^{
            [self displayContentForSelectedRow];
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            [self hideContentForSelectedRow];
        }];
    }

}

- (void)displayContentForSelectedRow{
    [_description setFrame:CGRectMake(_description.frame.origin.x,
                                      _description.frame.origin.y,
                                      _description.frame.size.width,
                                      179)];
}

- (void)hideContentForSelectedRow{
    [_description setFrame:CGRectMake(_description.frame.origin.x,
                                      _description.frame.origin.y,
                                      _description.frame.size.width,
                                      41)];
}

@end
