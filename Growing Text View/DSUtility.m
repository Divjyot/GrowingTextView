//
//  DSUtility.m
//  Growing Text View
//
//  Created by Divjyot Singh on 04/07/16.
//  Copyright © 2016 Divjyot Singh. All rights reserved.
//

#import "DSUtility.h"

@interface DSUtility()
@property (nonatomic) CGRect previousRect;
@property (nonatomic) CGRect currentRect;

@end

@implementation DSUtility

- (id)init{
   self.previousRect = CGRectZero;
    return self;
}


/*
    Returns frame of text view with 'n' number of lines in it typed with uifont 'font'; height of that returned frame will be height upon which you will pause/unpause scrolling, height increasing/decresing.
*/

+(CGRect)getTextViewSizeForLines:(int)n
              inTextView:(UITextView*)textView
                withFont:(UIFont*)font{
    
    NSString *saveText = textView.text, *newText = @"-";
    for (int i = 1; i < n; ++i){
        newText = [newText stringByAppendingString:@"\n|W|"];
    }
    
    textView.text = newText;
    
    CGRect maximumHeight = [self sizeOfTextInTextView:textView withFont:font];
    
    textView.text = saveText;
    
    return maximumHeight;
}

/*
 Returns frame of text view with 'n' number of lines in it typed with uifont 'font'
*/


+(CGRect)sizeOfTextInTextView:(UITextView*)textView withFont:(UIFont*)font
{
    
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine |
    NSStringDrawingUsesLineFragmentOrigin;
    NSDictionary *attr = @{NSFontAttributeName:textView.font};
    CGRect rectMadeAfterText = [textView.text boundingRectWithSize:CGSizeMake(CGRectGetMaxY(textView.frame)-20.0, FLT_MAX)
                                           options:options
                                        attributes:attr
                                           context:nil];
    return rectMadeAfterText;
}



/* 
    Detecting if the typing cursor moves up/down i.e. is Line Changed or not
*/

-(BOOL)isLineChanged:(UITextView *)textView{
    
    BOOL flag = NO;
    UITextPosition* pos = textView.endOfDocument;
    self.currentRect = [textView caretRectForPosition:pos];
    
    if (self.currentRect.origin.y != self.previousRect.origin.y){
        flag = YES;
    }
    self.previousRect = self.currentRect;
    
    return flag;
    
}


@end
