//
//  SYXDBManager.h
//  WordMasterApp
//
//  Created by Ludwig on 15/12/23.
//  Copyright © 2015年 Ludwig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SYXDictItem.h"

@interface SYXDBManager : NSObject
{
    sqlite3 *_db;
}

- (BOOL)open;
- (BOOL)close;
- (SYXDictItem *)dictItemForWord:(NSString *)word;

@end
