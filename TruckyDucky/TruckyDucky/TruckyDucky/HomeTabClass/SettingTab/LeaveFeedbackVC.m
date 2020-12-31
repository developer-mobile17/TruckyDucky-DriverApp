//
//  LeaveFeedbackVC.m
//  TruckyDucky
//
//  Created by anil kumar on 11/03/20.
//  Copyright © 2020 Steve. All rights reserved.
//

#import "LeaveFeedbackVC.h"
#import "HCSStarRatingView.h"

@interface LeaveFeedbackVC () <UITextViewDelegate>
{
    bool isPlaceholder;
    NSString *placeholderText;
    
}

@end

@implementation LeaveFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
       isPlaceholder = YES;
       placeholderText = @"Leave notes.";
       self.txvMessage.text = placeholderText;
       self.txvMessage.textColor = [UIColor lightGrayColor];
       [self.txvMessage setSelectedRange:NSMakeRange(0, 0)];
       
       
       self.txvMessage.delegate = self;
    
    
    
    self.vwNotes.layer.borderColor = [(UIColor.lightGrayColor)CGColor];
    self.vwNotes.layer.borderWidth = 1;
    self.vwNotes.layer.cornerRadius = 5;
    self.btnSubmit.layer.cornerRadius = 5;
       
}

- (IBAction)didChangeValue:(HCSStarRatingView *)sender {
    NSLog(@"Changed rating to %.1f", sender.value);
}


- (void) textViewDidChange:(UITextView *)textView{

    if (textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
        textView.text = placeholderText;
        [textView setSelectedRange:NSMakeRange(0, 0)];
        isPlaceholder = YES;

    } else if (isPlaceholder && ![textView.text isEqualToString:placeholderText]) {
        textView.text = [textView.text substringToIndex:1];
        textView.textColor = [UIColor blackColor];
        isPlaceholder = NO;
    }

}


@end
