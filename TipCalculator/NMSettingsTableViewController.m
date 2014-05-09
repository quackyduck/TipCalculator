//
//  NMSettingsTableViewController.m
//  TipCalculator
//
//  Created by Nicolas Melo on 5/4/14.
//  Copyright (c) 2014 melo. All rights reserved.
//

#import "NMSettingsTableViewController.h"
#import "NMSettingsUseLastTipPercentageTableViewCell.h"
#import "NMDefaultTipPercentageTableViewCell.h"

@interface NMSettingsTableViewController ()

@property (strong, nonatomic) NMSettingsUseLastTipPercentageTableViewCell *useLastTipPercentageCell;
@property (strong, nonatomic) NMDefaultTipPercentageTableViewCell *defaultTipPercentageCell;
@property NSInteger defaultTipPercentageIndex;
@property BOOL useLastTipPercentage;

@end

@implementation NMSettingsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Settings";
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.useLastTipPercentage = [userDefaults integerForKey:@"USE_LAST_TIP_PERCENTAGE"];
    self.defaultTipPercentageIndex = [userDefaults integerForKey:@"DEFAULT_TIP_PERCENTAGE_INDEX"];
    
    self.useLastTipPercentageCell = [self.tableView dequeueReusableCellWithIdentifier:@"lastUsedCell"];
    if (!self.useLastTipPercentageCell) {
        [self.tableView registerNib:[UINib nibWithNibName:@"NMSettingsUseLastTipPercentageTableViewCell" bundle:nil] forCellReuseIdentifier:@"useLastCell"];
        self.useLastTipPercentageCell = [self.tableView dequeueReusableCellWithIdentifier:@"useLastCell"];
        [self.useLastTipPercentageCell.useLastTipPercentageSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
    self.useLastTipPercentageCell.useLastTipPercentageSwitch.on = self.useLastTipPercentage ? YES : NO;
    
    self.defaultTipPercentageCell = [self.tableView dequeueReusableCellWithIdentifier:@"defaultTipPercentageCell"];
    if (!self.defaultTipPercentageCell) {
        [self.tableView registerNib:[UINib nibWithNibName:@"NMDefaultTipPercentageTableViewCell" bundle:nil] forCellReuseIdentifier:@"defaultTipPercentageCell"];
        self.defaultTipPercentageCell = [self.tableView dequeueReusableCellWithIdentifier:@"defaultTipPercentageCell"];
        [self.defaultTipPercentageCell.defaultTipPercentageControl addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    [self.defaultTipPercentageCell.defaultTipPercentageControl setEnabled:!self.useLastTipPercentageCell.useLastTipPercentageSwitch.on];
    [self.defaultTipPercentageCell.defaultTipPercentageControl setSelectedSegmentIndex:self.defaultTipPercentageIndex];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Two sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return self.useLastTipPercentageCell;
    }
    
    if (indexPath.section == 1) {
        return self.defaultTipPercentageCell;
    }
    
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title;
    if (section == 0) {
        title = @"Default Tip Percentage";
    }
    
    return title;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSString *title;
    if (section == 0) {
        title = @"Use previous tip percentage.";
    }
    else {
        title = @"Always start with same tip percentage.";
    }
    return title;
}

- (IBAction)switchValueChanged:(id)sender {
    
    UISwitch *switchControl = (UISwitch *)sender;
    if (switchControl.on) {
        self.defaultTipPercentageCell.defaultTipPercentageControl.enabled = NO;
        self.useLastTipPercentage = YES;
    } else {
        self.defaultTipPercentageCell.defaultTipPercentageControl.enabled = YES;
        self.useLastTipPercentage = NO;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.useLastTipPercentage forKey:@"USE_LAST_TIP_PERCENTAGE"];
    [userDefaults synchronize];
}

- (IBAction)segmentControlValueChanged:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.defaultTipPercentageIndex = [segmentedControl selectedSegmentIndex];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.defaultTipPercentageIndex forKey:@"DEFAULT_TIP_PERCENTAGE_INDEX"];
    [userDefaults synchronize];
    
}

@end
