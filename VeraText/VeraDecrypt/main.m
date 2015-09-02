//
//  main.m
//  VeraDecrypt
//
//  Created by Michael Dautermann on 9/2/15.
//  Copyright © 2015 Michael Dautermann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EncryptDecrypt.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSString *pathOrURLOfFile = [[NSString alloc] initWithCString:argv[1] encoding:NSUTF8StringEncoding];
        
        NSURL *fileToDecryptURL = [[NSURL alloc] initWithString:pathOrURLOfFile];
        
        // let's see if this is a real file URL
        if([fileToDecryptURL isFileURL] == NO)
        {
            // no?  then maybe we were passed a POSIX path
            fileToDecryptURL = [[NSURL alloc] initFileURLWithPath:pathOrURLOfFile];
        }
        
        if([fileToDecryptURL isFileURL])
        {
            NSStringEncoding usedEncoding;
            NSError *error;
            NSString *encryptedString = [[NSString alloc] initWithContentsOfURL:fileToDecryptURL usedEncoding:&usedEncoding error:&error];
            
            if(encryptedString)
            {
                
                NSString *decryptedString = [EncryptDecrypt encryptDecryptThis:encryptedString];
                
                printf("%s\n",[decryptedString UTF8String]);
            } else {
                NSLog(@"could not get contents of %s - %@", [fileToDecryptURL fileSystemRepresentation], [error localizedDescription]);
            }
        } else {
            NSLog(@"%@ is incorrect -- usage: %s path_or_fileURL", pathOrURLOfFile, argv[0]);
        }
    }
    return 0;
}
