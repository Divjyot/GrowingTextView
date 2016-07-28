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

//Text View Height Contraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeightConstraint;

// Text View Bottom Contraint (between TextView-Bottom & View-Bottom)
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomConstraint;

// Text-Field-Input Outlets
@property (weak, nonatomic) IBOutlet UITextField *minLinesTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxLinesTextField;

@end

