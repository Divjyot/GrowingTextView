//
//  DSTextView.m
//  Growing Text View
//
//  Created by Divjyot Singh on 04/07/16.
//  Copyright © 2016 Divjyot Singh. All rights reserved.
//
#define DEFAULT_TEXT_VIEW_HEIGHT 32
#define TEXT_VIEW_PLACEHOLDER (@"Fill me, human! With your kind words...")

#import "DSTextView.h"
#import "DSUtility.h"

@interface DSTextView() <UITextViewDelegate>
@property (nonatomic,strong) DSUtility * dsUtility;
@end

@implementation DSTextView

- (id)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
         [super setDelegate:self];
    }
    [self setText:TEXT_VIEW_PLACEHOLDER];

    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [super setDelegate:self];
    
}

-(void)setupTextViewHeightValues:(UITextView *)textView
                        minLines:(NSInteger*)minLines
                        maxLines:(NSInteger*)maxLines{
    
    self.minFrame = [DSUtility getTextViewSizeForLines:(int)minLines inTextView:self withFont:self.font];
    self.maxFrame = [DSUtility getTextViewSizeForLines:(int)maxLines inTextView:self withFont:self.font];
}


-(void)textViewDidChange:(UITextView *)textView{
   
    NSLog(@"text view height: %f",textView.frame.size.height);
    
    [textView setScrollEnabled:NO];
    
    //Grab size of text view everytime it is edited!
    CGRect currentTextRect = [DSUtility sizeOfTextInTextView:textView withFont:textView.font];
    
    //Checks if its is empty
    if([textView.text isEqualToString:@""]){
        NSLog(@"Case: EMPTY");
        self.textViewHeightConstraint.constant =  DEFAULT_TEXT_VIEW_HEIGHT; // You can change to your own custom height
    }
    //Untill max height reaches, increase the size of text view ....
    else if (currentTextRect.size.height <= self.maxFrame.size.height){
        NSLog(@"Case: SET HEIGHT");
        [UIView animateWithDuration:0.4 animations:^{
            [self setHeightOfTextViewDynamically];
        }];
    }
    //Height of Text View goes beyond MAX then start scrolling
    else{
        NSLog(@"CASE: SCROLL");
        [self setScrollEnabled:YES];
        
        //If there is pre-text in textView which has outreached MAX Height then height is set to default-MAX instead of the height that pre-text caused...
        //try commenting below if-condition to understand pre-text case of height more than MAX
        if(self.frame.size.height <= self.maxFrame.size.height){
            NSLog(@"SUB CASE : MAX HEIGHT REACHED ");
            self.textViewHeightConstraint.constant =  self.maxFrame.size.height;
        }
    }
    

}

-(void)setHeightOfTextViewDynamically{
    
    CGSize sizeThatFitsTextView = [self sizeThatFits:CGSizeMake(self.frame.size.width, self.frame.size.height)];
    self.textViewHeightConstraint.constant =  sizeThatFitsTextView.height;
    [self layoutIfNeeded];
    
}
-(void)removePlaceholderFromTextView{
    if([self.text isEqualToString:TEXT_VIEW_PLACEHOLDER]){
        self.text =@"";
    }
    
}


@end
