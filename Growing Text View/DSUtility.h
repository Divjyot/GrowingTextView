//
//  DSUtility.h
//  Growing Text View
//
//  Created by Divjyot Singh on 04/07/16.
//  Copyright © 2016 Divjyot Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DSUtility : NSObject
+(CGRect)getSizeForLines:(int)n inTextView:(UITextView*)textView withFont:(UIFont*)font;
+(CGRect)sizeOfTextInTextView:(UITextView*)textView withFont:(UIFont*)font;
@end
