//
//  NSString.m
//  VeraText
//
//  Created by Michael Dautermann on 9/1/15.
//  Copyright © 2015 Michael Dautermann. All rights reserved.
//

#import "NSDataSwizzleWrite.h"
#import <objc/runtime.h>

@implementation NSData (SwizzleWrites)

- (BOOL)swizzle_writeToURL:(NSURL *)url options:(NSDataWritingOptions)writeOptionsMask error:(NSError **)errorPtr
{
    NSLog(@"writing out something");

    // this should appear in the RTF file written out
    NSString * something = @"some placeholder text to prove that swizzling the method actually worked";
    
    NSData * replaced = [something dataUsingEncoding:NSUTF8StringEncoding];
    // Call original method with new NSData
    BOOL success = [replaced swizzle_writeToURL:url options:writeOptionsMask error:errorPtr];

    return success;
}

// Executed once on startup, before anything in NSData is called.
+ (void)load
{
    Class c = (id)self;
    
    if (self == [NSData class])
    {
        // Use class_getInstanceMethod for "normal" methods
        Method m1 = class_getClassMethod(c, @selector(writeToURL:options:error:));
        Method m2 = class_getClassMethod(c, @selector(swizzle_writeToURL:options:error:));
        
        // Swap the two methods.
        method_exchangeImplementations(m1, m2);
        NSLog(@"swizzling installed");
    } else {
        NSLog(@"swizzling failed");
    }
}


@end

__attribute__((constructor))
static void initialize()
{
    [NSData load];
}
