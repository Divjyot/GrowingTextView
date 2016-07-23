//
//  DSTextView.m
//  Growing Text View
//
//  Created by Divjyot Singh on 04/07/16.
//  Copyright © 2016 Divjyot Singh. All rights reserved.
//
#define DEFAULT_TEXT_VIEW_HEIGHT 32

#import "DSTextView.h"
#import "DSUtility.h"

@interface DSTextView() <UITextViewDelegate>
@property (nonatomic,strong) DSUtility * dsUtility;
@end


@implementation DSTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self setFrame:CGRectMake(0, 0, 10 , 20)];
}
*/

- (id)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
         [super setDelegate:self];
    }
    
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [super setDelegate:self];
    
}

-(void)setupTextViewHeightValues:(UITextView *)textView
                        minLines:(NSInteger*)minLines
                        maxLines:(NSInteger*)maxLines{
    self.minLines = minLines;
    self.maxLines = maxLines;
    self.minFrame = [DSUtility getSizeForLines:(int)self.minLines inTextView:self withFont:self.font];
    self.maxFrame = [DSUtility getSizeForLines:(int)self.maxLines inTextView:self withFont:self.font];
}

-(void)textViewDidChange:(UITextView *)textView{
    NSLog(@"TEXT VIEW HEIGHT DYN :%f",textView.frame.size.height);
    NSLog(@"Min:%f Max:%f",self.minFrame.size.height,self.maxFrame.size.height);
    
    [textView setScrollEnabled:NO];
    CGRect currentTextRect = [DSUtility sizeOfTextInTextView:textView withFont:textView.font];
    
//    if(currentTextRect.size.height <= self.minFrame.size.height){
//        NSLog(@"CASE : RETURN");
//        return ;
//    }
    
    if([textView.text isEqualToString:@""]){
        NSLog(@"CASE EMPTY");
        self.textViewHeightConstraint.constant =  DEFAULT_TEXT_VIEW_HEIGHT; // You can change to your own custom height
    }
    else if (currentTextRect.size.height <= self.maxFrame.size.height){
        NSLog(@"CASE : SET HEIGHT");
        
        //Set Dynamic height with disabled scrolling
        [UIView animateWithDuration:0.4 animations:^{
            [self setHeightOfTextViewDynamically];
        }];
         
    }
    else{
        //Enable scrolling
        NSLog(@"CASE : SCROLL");
        [self setScrollEnabled:YES];
        
        
        //If there is pre-text in textView which has outreached MAX Height then height is set to defaultMAX
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

@end
