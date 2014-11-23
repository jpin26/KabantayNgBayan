//
//  Constants.h
//  TestRun
//
//  Created by Andrew Zubiri on 11/22/14.
//  Copyright (c) 2014 ZAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

#define MERCHANT @"Merchant"
#define PROCUREMENT @"Procurements"

#define SERVICE_QUERY @"http://192.168.43.183:50097/ProxyService.svc/sqlrecord/%@"
#define SERVICE_LOOKUP @"http://192.168.43.183:50097/ProxyService.svc/lookup/%@"
#define SERVICE_ACTIVEBIDS @"http://192.168.43.183:50097/ProxyService.svc/list_by_org_id/ACTIVE_BIDS_SUPPLIER/%@/30"
#define SERVICE_BY_CATEGORY_ALL @"http://192.168.43.183:50097/ProxyService.svc/list_by_category/ACTIVE_BIDS_CATEGORY/%@/100"
#define SERVICE_BY_CATEGORY @"http://192.168.43.183:50097/ProxyService.svc/list_by_org_id_category/ACTIVE_BIDS_SUPPLIER_CATEGORY/%@/%@/30"
#define SERVICE_BID_DETAILS @"http://192.168.43.183:50097/ProxyService.svc/list_by_org_id/BID_DETAILS/%@/1"

@end
