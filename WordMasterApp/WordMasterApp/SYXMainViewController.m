//
//  SYXMainViewController.m
//  WordMasterApp
//
//  Created by Ludwig on 15/12/18.
//  Copyright © 2015年 Ludwig. All rights reserved.
//

#import "SYXMainViewController.h"
#import "SYXResultsTableViewController.h"
#import "AppDelegate.h"

@interface SYXMainViewController ()

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) SYXResultsTableViewController *resultsTableViewController;

//@property (weak, nonatomic) IBOutlet UILabel *labelNew;
//@property (weak, nonatomic) IBOutlet UILabel *labelPlanned;
//@property (weak, nonatomic) IBOutlet UILabel *labelFinished;
//
//@property NSInteger numNew;
//@property NSInteger numPlanned;
//@property NSInteger numFinished;

@end

@implementation SYXMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSDate *GMTDate = [NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate:GMTDate];
//    NSDate *date = [GMTDate dateByAddingTimeInterval:interval];
//    NSTimeInterval interv = [date timeIntervalSince1970];
//    int daySeconds = 24 * 60 * 60;
//    NSInteger allDays = interv / daySeconds;
//    NSDate *currentDate = [NSDate dateWithTimeIntervalSince1970:allDays * daySeconds];
//    
//    self.numNew = 0;
//    for (int i = 0; i < appDelegate.wordList.count; ) {
//        SYXListItem *listItem = (SYXListItem *)[appDelegate.wordList objectAtIndex:i];
//        if ([listItem.saveDate isEqualToDate:currentDate]) {
//            self.numNew++;
//        }
//    }
//    self.labelNew.text = [[NSString alloc] initWithFormat:@"%d", self.numNew];
//    
//    if (![currentDate isEqualToDate:appDelegate.previousDate]) {
//        appDelegate.reviewList = [[NSMutableArray alloc] init];
//        for (int i = 0; i < appDelegate.wordList.count; i++) {
//            SYXListItem *listItem = (SYXListItem *)[appDelegate.reviewList objectAtIndex:i];
//            NSTimeInterval interval1 = [appDelegate.previousDate timeIntervalSince1970];
//            NSTimeInterval interval2 = [listItem.saveDate timeIntervalSince1970];
//            NSInteger delta = interval1 - interval2;
//            if (delta == 24 * 60 * 60 || delta == 3 * 24 * 60 * 60 || delta == 7 * 24 * 60 * 60) {
//                [appDelegate.reviewList addObject:listItem];
//            }
//        }
//        self.numPlanned = appDelegate.reviewList.count;
//    }
//    self.labelPlanned.text = [[NSString alloc] initWithFormat:@"%d", self.numPlanned];
//    
//    self.labelFinished.text = [[NSString alloc] initWithFormat:@"%d", self.numFinished];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
