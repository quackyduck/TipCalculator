//
//  NMSettingsToggleTableViewCell.h
//  TipCalculator
//
//  Created by Nicolas Melo on 5/4/14.
//  Copyright (c) 2014 melo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMSettingsUseLastTipPercentageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *useLastTipPercentageLabel;
@property (weak, nonatomic) IBOutlet UISwitch *useLastTipPercentageSwitch;

@end
