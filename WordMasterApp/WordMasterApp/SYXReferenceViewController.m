//
//  SYXReferenceViewController.m
//  WordMasterApp
//
//  Created by Ludwig on 15/12/18.
//  Copyright © 2015年 Ludwig. All rights reserved.
//

#import "SYXReferenceViewController.h"
#import "SYXDBManager.h"
#import "AppDelegate.h"

@interface SYXReferenceViewController ()

@property (strong, nonatomic) SYXDBManager *dbManager;

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) UITableViewController *tvc;

@property (weak, nonatomic) IBOutlet UILabel *labelEn;
@property (weak, nonatomic) IBOutlet UILabel *labelSymbol;
@property (weak, nonatomic) IBOutlet UILabel *labelCh;
@property (weak, nonatomic) IBOutlet UIButton *markStar;

@property NSInteger inList;

@end

@implementation SYXReferenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tvc = [[UITableViewController alloc] init];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.tvc];
    self.searchController.searchResultsUpdater = self;
    
    [self.searchController.searchBar sizeToFit];
    self.navigationItem.titleView = self.searchController.searchBar;
    
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.dimsBackgroundDuringPresentation = YES;
    
    self.definesPresentationContext = YES;
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.dbManager = appDelegate.dbManager;
    
    self.labelEn.text = nil;
    self.labelSymbol.text = nil;
    self.labelCh.text = nil;
    self.labelCh.lineBreakMode = NSLineBreakByWordWrapping;
    
    self.markStar.enabled = NO;
    
    self.inList = -1;
    
    //UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:self.searchBar];
    //self.navigationItem.leftBarButtonItem = searchBarItem;
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

#pragma mark - UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    NSString *text = [[NSString alloc] initWithString:[searchBar text]];
    SYXDictItem *dictItem = [self.dbManager dictItemForWord:text];
    self.labelEn.text = dictItem.en;
    self.labelSymbol.text = dictItem.symbol;
    self.labelCh.text = dictItem.ch;
    
    self.markStar.enabled = NO;
    self.inList = -1;
    if (self.labelEn.text != nil) {
        self.markStar.enabled = YES;
        [self.markStar setBackgroundImage:[UIImage imageNamed:@"Christmas Star-50"] forState:UIControlStateNormal];
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        NSInteger i;
        for (i = 0; i < appDelegate.wordList.count; i++) {
            NSString *word = (NSString *)[appDelegate.wordList objectAtIndex:i];
            if ([text isEqualToString:word]) {
                [self.markStar setBackgroundImage:[UIImage imageNamed:@"Christmas Star Filled-50"] forState:UIControlStateNormal];
                self.inList = i;
                break;
            }
        }
    }
    
    [self.tvc dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Event Handling

- (IBAction)addToList:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (self.inList < 0) {
        [appDelegate.wordList addObject:self.labelEn.text];
        self.inList = appDelegate.wordList.count - 1;
        [self.markStar setBackgroundImage:[UIImage imageNamed:@"Christmas Star Filled-50"] forState:UIControlStateNormal];
    } else {
        [appDelegate.wordList removeObjectAtIndex:self.inList];
        self.inList = -1;
        [self.markStar setBackgroundImage:[UIImage imageNamed:@"Christmas Star-50"] forState:UIControlStateNormal];
    }
}

@end
