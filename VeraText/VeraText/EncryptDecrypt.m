//
//  EncryptDecrypt.m
//  VeraText
//
//  Created by Michael Dautermann on 9/2/15.
//  Copyright © 2015 Michael Dautermann. All rights reserved.
//

#import "EncryptDecrypt.h"
#import <Foundation/Foundation.h>

@implementation EncryptDecrypt

// borrowed from https://github.com/KyleBanks/XOREncryption/blob/master/Objective-C/main.m

+(NSString *) encryptDecryptThis:(NSString *)input
{
    unichar key[] = {'K'}; // , 'C', 'Q'}; //Can be any chars, and any size array
    NSMutableString *output = [[NSMutableString alloc] init];
    
    for(int i = 0; i < input.length; i++) {
        unichar c = [input characterAtIndex:i];
        c ^= key[i % sizeof(key)/sizeof(unichar)];
        [output appendString:[NSString stringWithFormat:@"%C", c]];
    }
    
    return output;
}

+(NSData *) encryptDecryptThisData:(NSData *)input
{
    unichar key[] = {'K'};
    uint8_t * bytePtr = (uint8_t * )[input bytes];
    Byte *output = (Byte*)malloc(input.length);
    
    for(int i = 0; i < input.length; i++) {
        unichar c = bytePtr[i];
        c ^= key[i % sizeof(key)/sizeof(unichar)];
        output[i] = c;
    }
    
    NSData *outputData = [[NSData alloc] initWithBytes:output length:input.length];
    return outputData;
}


@end
