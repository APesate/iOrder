//
//  WebServicesObject.m
//  iOrder
//
//  Created by Andrés Pesate on 3/16/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#import "WebServicesObject.h"
#import "APTModelFactory.h"

@implementation WebServicesObject

static WebServicesObject* sWebServices;

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sWebServices = [[WebServicesObject alloc] init];
    });
    
    return sWebServices;
}

- (instancetype)init{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

- (void)getAllCategories{
    NSURL* url = [NSURL URLWithString:kGET_ALL_CATEGORIES];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSArray* jsonArray;
        
        if ([self isValidResponse:data]) {
            jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (error) {
                NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, [error localizedDescription]);
            } else {
                [[APTModelFactory sharedInstance] addCategories:jsonArray];
                
                [jsonArray enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
                    dispatch_async(dispatch_queue_create("Request", nil), ^{
                        [self getProductsForCategorie:(int)[[obj objectForKey:@"id"] integerValue]];
                    });
                }];
            }
        }
        
        if (error) {
            NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, [error localizedDescription]);
        }
    
    }];
}

- (void)getProductsForCategorie:(int)categorieId {
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:kGET_PRODUCTOS_FOR_CATEGORIE, categorieId]];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSArray* jsonArray;
        
        if ([self isValidResponse:data]) {
            jsonArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            if (error) {
                NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, [error localizedDescription]);
            } else {
                [[APTModelFactory sharedInstance] addProducts:jsonArray ForCategorie:categorieId];
            }
        }
        
        if (error) {
            NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, [error localizedDescription]);
        } else {
            NSLog(@"Categorie %i Done", categorieId);
        }
        
    }];
}

- (void)addNewOrderWithProducts:(NSArray *)products {
    NSError* error;
    NSString* token = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
    NSDictionary* postDict = @{@"deviceToken": token,
                               @"products": products,
                               @"appKey": kAPP_KEY};
    
    NSData* postData = [NSJSONSerialization dataWithJSONObject:postDict options:0 error:&error];
    
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:kADD_NEW_ORDER_FOR_USER, [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"]]];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];

    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSLog(@"DATA: %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        if ([self isValidResponse:data]) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Orden Enviada" message:@"Su Orden ha sido enviada" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        }
        
        if (error) {
            NSLog(@"Error [%s, %d]: %@", __PRETTY_FUNCTION__, __LINE__, [error localizedDescription]);
        }
        
    }];
}

- (BOOL)isValidResponse:(NSData *)data {
    
    char response = '\0';
    
    if (data.length > 0) {
        response = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] characterAtIndex:0];
    } else {
        response = eCONECTION_ERROR;
    }
    
    
    switch (response) {
        case eMISSING_PARAMTER:
            NSLog(@"Missing Parameter");
            break;
        case eCONECTION_ERROR:
            NSLog(@"Conection Error");
            break;
        case eQUERY_ERROR:
            NSLog(@"Query Error");
            break;
        case eNON_ROWS:
            NSLog(@"Non Rows Fetched");
            break;
        default:
            return YES;
    }
    
    return NO;
}

@end
