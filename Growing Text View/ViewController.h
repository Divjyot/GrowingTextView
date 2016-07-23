//
//  ViewController.h
//  Growing Text View
//
//  Created by Divjyot Singh on 22/06/16.
//  Copyright © 2016 Divjyot Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSTextView.h"

@interface ViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet DSTextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomConstraint;

@end

