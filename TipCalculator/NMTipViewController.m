//
//  NMTipViewController.m
//  TipCalculator
//
//  Created by Nicolas Melo on 5/4/14.
//  Copyright (c) 2014 melo. All rights reserved.
//

#import "NMTipViewController.h"
#import "NMSettingsTableViewController.h"

@interface NMTipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipSegmentedControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;

@end

@implementation NMTipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    // input from the user
    float billAmount = [self.billTextField.text floatValue];
    
    // get the values & calculate
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipSegmentedControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    // update the UI
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    
    // save the values
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:self.tipSegmentedControl.selectedSegmentIndex forKey:@"TIP_PERCENTAGE_INDEX"];
    [userDefaults synchronize];
}

- (void)onSettingsButton {
    // launch settings page
    NMSettingsTableViewController *settingsViewController = [[NMSettingsTableViewController alloc] init];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    // load the saved values
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger useLastTipPercentage = [userDefaults integerForKey:@"USE_LAST_TIP_PERCENTAGE"];
    NSInteger defaultTipPercentageIndex = [userDefaults integerForKey:@"DEFAULT_TIP_PERCENTAGE_INDEX"];
    NSInteger lastTipPercentageIndex = [userDefaults integerForKey:@"TIP_PERCENTAGE_INDEX"];
    
    // update the UI
    if (useLastTipPercentage) {
        [self.tipSegmentedControl setSelectedSegmentIndex:lastTipPercentageIndex];
    } else {
        [self.tipSegmentedControl setSelectedSegmentIndex:defaultTipPercentageIndex];
    }
    
    [self updateValues];
}

@end
