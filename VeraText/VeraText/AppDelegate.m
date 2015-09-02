//
//  AppDelegate.m
//  VeraText
//
//  Created by Michael Dautermann on 9/1/15.
//  Copyright © 2015 Michael Dautermann. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


- (IBAction) saveAs:(id)sender
{
    NSLog(@"saveAs");
    NSArray *orderedWindowArray = [NSApp orderedWindows];
    if([orderedWindowArray count] > 0)
    {
        NSWindow *frontWindow = [orderedWindowArray objectAtIndex:0];
        
        ViewController *currentVC = (ViewController *)[frontWindow contentViewController];

        if([currentVC respondsToSelector:@selector(saveAs:)])
        {
            [currentVC saveAs:sender];
        }
    }
}

- (IBAction) save:(id)sender
{
    NSLog(@"save");
    NSArray *orderedWindowArray = [NSApp orderedWindows];
    if([orderedWindowArray count] > 0)
    {
        NSWindow *frontWindow = [orderedWindowArray objectAtIndex:0];
        
        ViewController *currentVC = (ViewController *)[frontWindow contentViewController];
        
        if([currentVC respondsToSelector:@selector(saveButtonTouched:)])
        {
            [currentVC saveButtonTouched:sender];
        }
    }
}

@end
