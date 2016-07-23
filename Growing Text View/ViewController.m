//
//  ViewController.m
//  Growing Text View
//
//  Created by Divjyot Singh on 22/06/16.
//  Copyright © 2016 Divjyot Singh. All rights reserved.
//

#import "ViewController.h"
#import "DSTextView.h"

@interface ViewController ()

@end

@implementation ViewController{
    CGRect keyboardEndFrame;
    CGFloat navigationHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];

    // Navigation width is constant
    navigationHeight = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    
    //Set THIS CLASS as TEXTVIEW's DELEGATE
//    self.textView.delegate = self;
    
    self.textView.maxLines = (NSInteger*)5;
    self.textView.minLines = (NSInteger*)1;
    
    [self.textView setupTextViewHeightValues:self.textView minLines:(NSInteger*)2 maxLines:(NSInteger*)5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

// Setting up keyboard notifications.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}


//------------------------------------------------------------------------------------------------------------------
#pragma mark - Keyboard Post Notifications
//------------------------------------------------------------------------------------------------------------------

-(void) keyBoardWillShow:(NSNotification *) notification{
  
    NSString * theAnimationDuration = [self handleKeyboardNotification:notification];
    
    self.textViewBottomConstraint.constant = self.view.frame.size.height - keyboardEndFrame.origin.y;
    //(Add navigation height if navigation bar is in view)
    
    [UIView animateWithDuration:theAnimationDuration.doubleValue animations:^{
        [self.view layoutIfNeeded];
        
    }];

    NSLog(@"Keyboard Shown: %f",self.textViewBottomConstraint.constant);
}


-(void) keyBoardWillHide:(NSNotification *) notification{
    
    NSString * theAnimationDuration = [self handleKeyboardNotification:notification];
    self.textViewBottomConstraint.constant = 0;
    
    [UIView animateWithDuration:theAnimationDuration.doubleValue animations:^{
        [self.view layoutIfNeeded];
        
    }];
    
    NSLog(@"Keyboard Hide: %f",self.textViewBottomConstraint.constant);
}

-(NSString *)handleKeyboardNotification:(NSNotification *) notification{
    
    NSDictionary * theDictionary = notification.userInfo;
    NSString * theAnimationDuration = [theDictionary valueForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    keyboardEndFrame = [(NSValue *)[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
      return theAnimationDuration;
}


@end
