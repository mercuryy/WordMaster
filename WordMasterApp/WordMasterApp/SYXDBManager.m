//
//  SYXDBManager.m
//  WordMasterApp
//
//  Created by Ludwig on 15/12/23.
//  Copyright © 2015年 Ludwig. All rights reserved.
//

#import "SYXDBManager.h"

@implementation SYXDBManager

- (BOOL)open {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dict" ofType:@"db"];
    BOOL success = sqlite3_open([path UTF8String], &_db);
    if (success == SQLITE_OK) {
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL)close {
    BOOL success = sqlite3_close(_db);
    if (success == SQLITE_OK) {
        return YES;
    }
    else {
        return NO;
    }
}

- (SYXDictItem *)dictItemForWord:(NSString *)word {
    SYXDictItem *dictItem = [[SYXDictItem alloc] init];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM OXFORD WHERE en = '%@'", word];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_db, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *en = (char *)sqlite3_column_text(statement, 0);
            char *symbol = (char *)sqlite3_column_text(statement, 1);
            char *ch = (char *)sqlite3_column_text(statement, 2);
            dictItem.en = [[NSString alloc] initWithUTF8String:en];
            dictItem.symbol = [[NSString alloc] initWithUTF8String:symbol];
            dictItem.ch = [[NSString alloc] initWithUTF8String:ch];
        }
    }
    return dictItem;
}

@end
