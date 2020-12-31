//
//  HelpCenterVC.h
//  TruckyDucky
//
//  Created by anil kumar on 14/12/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpCenterVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UIButton *btnChat;
- (IBAction)actoinBack:(id)sender;

- (IBAction)actionCall:(id)sender;
- (IBAction)actionChat:(id)sender;

@end

NS_ASSUME_NONNULL_END
