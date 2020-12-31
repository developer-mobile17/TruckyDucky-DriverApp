//
//  LeaveFeedbackVC.h
//  TruckyDucky
//
//  Created by anil kumar on 11/03/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LeaveFeedbackVC : UIViewController
@property (weak, nonatomic) IBOutlet UIView *vwNotes;
@property (weak, nonatomic) IBOutlet UITextView *txvMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;

@end


