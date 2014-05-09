//
//  NMSettingsToggleTableViewCell.h
//  TipCalculator
//
//  Created by Nicolas Melo on 5/4/14.
//  Copyright (c) 2014 melo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NMSettingsToggleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *previousTipLabel;
@property (weak, nonatomic) IBOutlet UISwitch *previousTipSwitch;

@end
