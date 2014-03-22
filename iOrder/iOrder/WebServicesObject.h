//
//  WebServicesObject.h
//  iOrder
//
//  Created by Andrés Pesate on 3/16/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebServices.h"

@interface WebServicesObject : NSObject

@property (nonatomic, assign) void(^completitionHandler)(id data);
+ (instancetype)sharedInstance;

- (void)getAllCategories;
- (void)getProductsForCategorie:(int)categorieId;
- (void)addNewOrder;

@end
