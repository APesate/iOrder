//
//  WebServices.h
//  iOrder
//
//  Created by Andrés Pesate on 3/16/14.
//  Copyright (c) 2014 Andrés Pesate. All rights reserved.
//

#define kHOST @"http://192.168.2.124/iOrder/Controller/"
#define kAPP_KEY @"i0rD3r44DPc5"

#define kGET_ALL_CATEGORIES kHOST @"Categorie Services/AllCategories.php?appKey=" kAPP_KEY
#define kGET_PRODUCTOS_FOR_CATEGORIE kHOST @"Categorie Services/ProductsForCategorie.php?appKey=" kAPP_KEY @"&categorie_id=%i"

#define kADD_NEW_ORDER_FOR_USER kHOST @"Factura Services/AddNewOrder.php?appKey=" kAPP_KEY @"&user_id=%i"

typedef enum{
    eMISSING_PARAMTER,
    eCONECTION_ERROR,
    eQUERY_ERROR,
    eNON_ROWS
} kServerResponses;