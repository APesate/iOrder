//
//  MenuHeader.m
//  iOrder
//
//  Created by Andrés Pesate on 3/13/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import "MenuHeader.h"

@implementation MenuHeader{
    UITapGestureRecognizer* tapGesture;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        _title = [[UILabel alloc] initWithFrame:CGRectMake(58, 11, 241, 21)];
        tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showSection:)];
        
        [self addGestureRecognizer:tapGesture];
        [self addSubview:_image];
        [self addSubview:_title];
    }
    return self;
}

- (void) showSection:(UITapGestureRecognizer *)touch{
    if (touch.state == UIGestureRecognizerStateEnded) {
        [_delegate showSection:_section];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
