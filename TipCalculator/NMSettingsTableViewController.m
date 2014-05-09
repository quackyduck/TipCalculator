//
//  NMSettingsTableViewController.m
//  TipCalculator
//
//  Created by Nicolas Melo on 5/4/14.
//  Copyright (c) 2014 melo. All rights reserved.
//

#import "NMSettingsTableViewController.h"
#import "NMSettingsToggleTableViewCell.h"
#import "NMDefaultPercentageTableViewCell.h"

@interface NMSettingsTableViewController ()

@property (strong, nonatomic) NMSettingsToggleTableViewCell *toggleTableViewCell;
@property (strong, nonatomic) NMDefaultPercentageTableViewCell *defaultPercentageCell;
@property NSInteger defaultPercentageIndex;
@property BOOL defaultUseLastPercentage;

@end

@implementation NMSettingsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Settings";
    
    self.toggleTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"lastUsedCell"];
    if (!self.toggleTableViewCell) {
        [self.tableView registerNib:[UINib nibWithNibName:@"NMSettingsToggleTableViewCell" bundle:nil] forCellReuseIdentifier:@"lastUsedCell"];
        self.toggleTableViewCell = [self.tableView dequeueReusableCellWithIdentifier:@"lastUsedCell"];
        [self.toggleTableViewCell.previousTipSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
    
    self.defaultPercentageCell = [self.tableView dequeueReusableCellWithIdentifier:@"defaultPercentageCell"];
    if (!self.defaultPercentageCell) {
        [self.tableView registerNib:[UINib nibWithNibName:@"NMDefaultPercentageTableViewCell" bundle:nil] forCellReuseIdentifier:@"defaultPercentageCell"];
        self.defaultPercentageCell = [self.tableView dequeueReusableCellWithIdentifier:@"defaultPercentageCell"];
        [self.defaultPercentageCell.defaultPercentageSegmentControl addTarget:self action:@selector(segmentControlValueChanged:) forControlEvents:UIControlEventValueChanged];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // One section of settings right now.
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
        return self.toggleTableViewCell;
    }
    
    if (indexPath.section == 1) {
        return self.defaultPercentageCell;
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
        NSLog(@"ON!");
        self.defaultPercentageCell.defaultPercentageSegmentControl.enabled = NO;
        self.defaultUseLastPercentage = YES;
    } else {
        self.defaultPercentageCell.defaultPercentageSegmentControl.enabled = YES;
        self.defaultUseLastPercentage = NO;
    }
}

- (IBAction)segmentControlValueChanged:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.defaultPercentageIndex = [segmentedControl selectedSegmentIndex];
}

@end
