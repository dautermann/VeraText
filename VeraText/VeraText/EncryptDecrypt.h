//
//  EncryptDecrypt.h
//  VeraText
//
//  Created by Michael Dautermann on 9/2/15.
//  Copyright © 2015 Michael Dautermann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EncryptDecrypt : NSObject

#if DUH
+ (NSString *) decryptThis: (NSString *)encryptedString;

+ (NSString *) encryptThis: (NSString *)originalString;
#else
+ (NSString *) encryptDecryptThis:(NSString *)input;

#endif
@end
