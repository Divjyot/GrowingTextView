//
//  DSTextView.h
//  Growing Text View
//
//  Created by Divjyot Singh on 04/07/16.
//  Copyright © 2016 Divjyot Singh. All rights reserved.
//

/*
 
 */

#import <UIKit/UIKit.h>

@interface DSTextView : UITextView  
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomConstraint;

-(void)setupTextViewHeightValues:(UITextView *)textView
                        minLines:(NSInteger*)minLines
                        maxLines:(NSInteger*)maxLines;

@property (nonatomic) CGRect maxFrame;
@property (nonatomic) CGRect minFrame;

@end
