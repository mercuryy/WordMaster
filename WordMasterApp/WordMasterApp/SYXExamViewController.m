//
//  SYXExamViewController.m
//  WordMasterApp
//
//  Created by Ludwig on 16/1/21.
//  Copyright © 2016年 Ludwig. All rights reserved.
//

#import "SYXExamViewController.h"
#import "AppDelegate.h"

@interface SYXExamViewController ()

@property (strong, nonatomic) SYXDBManager *dbManager;

@property NSInteger index;
@property NSMutableArray *customList;

@property (weak, nonatomic) IBOutlet UILabel *labelEn;
@property (weak, nonatomic) IBOutlet UILabel *labelSymbol;
@property (weak, nonatomic) IBOutlet UILabel *labelCh;

@property (weak, nonatomic) IBOutlet UIButton *buttonYes;
@property (weak, nonatomic) IBOutlet UIButton *buttonNo;
@property (weak, nonatomic) IBOutlet UIButton *buttonNext;

@end

@implementation SYXExamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.dbManager = appDelegate.dbManager;
    self.customList = [[NSMutableArray alloc] initWithArray:appDelegate.wordList];
    self.index = 0;
    self.labelEn.text = [self.customList objectAtIndex:self.index];
    self.labelSymbol.text = nil;
    self.labelCh.text = nil;
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

- (IBAction)touchYes:(id)sender {
    self.buttonYes.alpha = 0;
    self.buttonNo.alpha = 0;
    self.buttonNext.alpha = 1;
    SYXDictItem *dictItem = [self.dbManager dictItemForWord:[self.customList objectAtIndex:self.index]];
    self.labelEn.text = dictItem.en;
    self.labelSymbol.text = dictItem.symbol;
    self.labelCh.text = dictItem.ch;
}

- (IBAction)touchNo:(id)sender {
    self.buttonYes.alpha = 0;
    self.buttonNo.alpha = 0;
    self.buttonNext.alpha = 1;
    SYXDictItem *dictItem = [self.dbManager dictItemForWord:[self.customList objectAtIndex:self.index]];
    self.labelEn.text = dictItem.en;
    self.labelSymbol.text = dictItem.symbol;
    self.labelCh.text = dictItem.ch;
    [self.customList addObject:[self.customList objectAtIndex:self.index]];
}

- (IBAction)touchNext:(id)sender {
    self.buttonNext.alpha = 0;
    self.buttonYes.alpha = 1;
    self.buttonNo.alpha = 1;
    if (self.index < self.customList.count - 1) {
        self.index++;
        self.labelEn.text = [self.customList objectAtIndex:self.index];
        self.labelSymbol.text = nil;
        self.labelCh.text = nil;
    } else {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
