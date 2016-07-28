//
//  ViewController.m
//  Growing Text View
//
//  Created by Divjyot Singh on 22/06/16.
//  Copyright © 2016 Divjyot Singh. All rights reserved.
//
#define DEFAULT_MIN_LINES 1
#define DEFAULT_MAX_LINES 5

#import "ViewController.h"
#import "DSTextView.h"

@interface ViewController ()
@property (nonatomic) CGRect keyboardEndFrame;
@property (nonatomic) NSInteger * maxLines;
@property (nonatomic) NSInteger * minLines;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    
    // Default Settings
    [self.textView setupTextViewHeightValues:self.textView
                                    minLines:(long*)DEFAULT_MIN_LINES
                                    maxLines:(long*)DEFAULT_MAX_LINES];
    [self.textView setUserInteractionEnabled:YES];
}


- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

// Add Keyboard Observers.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - Keyboard Post Notifications
//----------------------------------------

-(void) keyBoardWillShow:(NSNotification *) notification{
    NSString * theAnimationDuration = [self handleKeyboardNotification:notification];
    
    self.textViewBottomConstraint.constant = self.view.frame.size.height - self.keyboardEndFrame.origin.y;
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
    
    self.keyboardEndFrame = [(NSValue *)[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
      return theAnimationDuration;
}

#pragma mark -

- (IBAction)done:(id)sender {
    
     [self.textView setBackgroundColor:[UIColor clearColor]];
    [self.textView setUserInteractionEnabled:YES];
    self.maxLines = self.maxLinesTextField.text  ?(long*)self.maxLinesTextField.text.longLongValue
    :(long*)DEFAULT_MAX_LINES;
    
    self.minLines = self.maxLinesTextField.text  ?(long*)self.minLinesTextField.text.longLongValue
    :(long*)DEFAULT_MIN_LINES;
    
    [self.textView setupTextViewHeightValues:self.textView minLines:self.minLines maxLines:self.maxLines];

    
    if(self.maxLines == 0 ||self.minLines == 0){
        [self showAlert];
    }
    
}

-(void)showAlert{
    UIAlertController * alertController = [[UIAlertController alloc] init];
    UIAlertAction * alertAction = [UIAlertAction actionWithTitle:@"Seriously? Zero!!" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:alertAction];
    [self showViewController:alertController sender:nil];
    [self.textView setBackgroundColor:[UIColor orangeColor]];
    [self.textView setUserInteractionEnabled:NO];
    [self.textView setText:@"Change your settings man!!"];
}


@end
