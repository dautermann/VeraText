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
    char key[] = {'K'}; // , 'C', 'Q'}; //Can be any chars, and any size array
    NSMutableString *output = [[NSMutableString alloc] init];
    
    for(int i = 0; i < input.length; i++) {
        char c = [input characterAtIndex:i];
        c ^= key[i % sizeof(key)/sizeof(char)];
        [output appendString:[NSString stringWithFormat:@"%c", c]];
    }
    
    return output;
}

@end