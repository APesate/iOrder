//
//  MenuHeader.h
//  iOrder
//
//  Created by Andrés Pesate on 3/13/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SectionDelegate <NSObject>

- (void)showSection:(NSInteger)section;

@end

@interface MenuHeader : UITableViewHeaderFooterView

@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UILabel *title;
@property (assign, nonatomic) NSInteger section;
@property (strong, nonatomic) id <SectionDelegate> delegate;

@end
