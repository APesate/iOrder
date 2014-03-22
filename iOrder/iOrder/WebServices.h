//
//  WebServices.h
//  iOrder
//
//  Created by Andrés Pesate on 3/16/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#define kHOST @"http://192.168.2.124/iOrder/Controller/"
#define kAPP_KEY @"i0rD3r44DPc5"

#define kGET_ALL_CATEGORIES kHOST @"CategorieServices/AllCategories.php?appKey=" kAPP_KEY
#define kGET_PRODUCTOS_FOR_CATEGORIE kHOST @"CategorieServices/ProductsForCategorie.php?appKey=" kAPP_KEY @"&categorie_id=%i"

#define kADD_NEW_ORDER_FOR_USER kHOST @"FacturaServices/AddNewOrder.php?appKey=" kAPP_KEY @"&deviceToken=%@"

typedef enum{
    eMISSING_PARAMTER,
    eCONECTION_ERROR,
    eQUERY_ERROR,
    eNON_ROWS
} kServerResponses;