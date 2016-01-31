//
//  AppDelegate.h
//  WordMasterApp
//
//  Created by Ludwig on 15/12/12.
//  Copyright © 2015年 Ludwig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYXDBManager.h"
#import "SYXListItem.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) SYXDBManager *dbManager;
@property (strong, nonatomic) NSMutableArray *wordList;
@property (strong, nonatomic) NSMutableArray *listByDate;

@property (strong, nonatomic) NSDate *previousDate;

@property (strong, nonatomic) NSMutableArray *reviewList;

@end

