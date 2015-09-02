//
//  ViewController.m
//  VeraText
//
//  Created by Michael Dautermann on 9/1/15.
//  Copyright © 2015 Michael Dautermann. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)saveAs:(id)sender
{
    // create the save panel
    NSSavePanel *panel = [NSSavePanel savePanel];
    
    // set a new file name
#if FOR_NSDATA
    [panel setNameFieldStringValue:@"VeraText.rtf"];
#else
    [panel setNameFieldStringValue:@"VeraText.txt"];
#endif
    
    // display the panel
    [panel beginWithCompletionHandler:^(NSInteger result) {
        
        if (result == NSFileHandlingPanelOKButton) {
            
            textURL = [panel URL];

            NSLog(@"saveURL is %@", [textURL absoluteString]);
            
            [self saveButtonTouched:sender];
        }
    }];
}

- (IBAction)saveButtonTouched:(id)sender
{
    if(!textURL)
    {
        [self saveAs:sender];
    } else {
        NSError *error;
        BOOL success;
#if FOR_NSDATA
        NSData *rtfFromTextView = [textView RTFFromRange:NSMakeRange(0, textView.textStorage.length)];
        
        success = [rtfFromTextView writeToURL:textURL options:NSDataWritingAtomic error:&error];
#else
        NSString *stringFromTextView = [textView string];
        success = [stringFromTextView writeToURL:textURL atomically:YES encoding:NSUTF8StringEncoding error:&error];
#endif
        if(!success)
        {
            NSLog(@"error in writeToURL:atomically:encoding:error: - %@", [error localizedDescription]);
        }
    }
}

@end
