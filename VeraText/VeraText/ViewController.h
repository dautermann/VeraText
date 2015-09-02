//
//  ViewController.h
//  VeraText
//
//  Created by Michael Dautermann on 9/1/15.
//  Copyright © 2015 Michael Dautermann. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
{
    IBOutlet NSTextView *textView;
    NSURL *textURL;
}

- (IBAction)saveAs:(id)sender;

- (IBAction)saveButtonTouched:(id)sender;

@end

