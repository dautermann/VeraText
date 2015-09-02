//
//  NSString.m
//  VeraText
//
//  Created by Michael Dautermann on 9/1/15.
//  Copyright © 2015 Michael Dautermann. All rights reserved.
//

#import "NSDataSwizzleWrite.h"
#import "EncryptDecrypt.h"
#import <objc/runtime.h>

@implementation NSString (SwizzleWrites)

- (BOOL)swizzle_writeToURL:(NSURL *)url atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc error:(NSError **)error;
{
    NSString *encryptedText = [EncryptDecrypt encryptDecryptThis:self];
#if TESTING

    NSString *newText = [EncryptDecrypt encryptDecryptThis:encryptedText];
    
    NSLog(@"writing out %ld %ld %@", [encryptedText length], [newText length], newText);
    
#endif
    // Call original method with the new encrypted string
    BOOL success = [encryptedText swizzle_writeToURL:url atomically:useAuxiliaryFile encoding:enc error:error];
    
    return success;
}

// Executed once on startup, before anything in NSString is called.
+ (void)load
{
    Class c = (id)self;
    
    if (self == [NSString class])
    {
        // Use class_getInstanceMethod for "normal" methods
        Method m1 = class_getInstanceMethod(c, @selector(writeToURL:atomically:encoding:error:));
        Method m2 = class_getInstanceMethod(c, @selector(swizzle_writeToURL:atomically:encoding:error:));
        
        // Swap the two methods.
        method_exchangeImplementations(m1, m2);
        NSLog(@"NSString swizzling installed");
    } else {
        NSLog(@"NSString swizzling failed");
    }
}

@end

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
        Method m1 = class_getInstanceMethod(c, @selector(writeToURL:options:error:));
        Method m2 = class_getInstanceMethod(c, @selector(swizzle_writeToURL:options:error:));
        
        // Swap the two methods.
        method_exchangeImplementations(m1, m2);
        NSLog(@"NSData swizzling installed");
    } else {
        NSLog(@"NSData swizzling failed");
    }
}

@end

__attribute__((constructor))
static void initialize()
{

}
