//
//  NSString+KeyPathReplace.m
//  CamViewer
//
//  Created by John McKerrell on 16/07/2013.
//
//

#import "NSString+KeyPathReplace.h"

#import "RegexKitLite.h"

@implementation NSString (KeyPathReplace)

- (NSString*)stringByReplacingKeyPathBindingsWithDictionaryValues:(NSDictionary*)dict {
    return [self stringByReplacingKeyPathBindingsWithDictionaryValues:dict defaultValues:nil];
}

- (NSString*)stringByReplacingKeyPathBindingsWithDictionaryValues:(NSDictionary*)dict defaultValues:(NSDictionary*)defaultValues {
    return [self stringByReplacingOccurrencesOfRegex:@"\\\\?\\{([^}:]+)(:([^}]+))?\\}" usingBlock:^NSString *(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        NSString *keyPath = nil;
        NSString *defaultValue = nil;
        if (captureCount>1) {
            keyPath = capturedStrings[1];
        }
        if (captureCount>3 && [capturedStrings[3] length]) {
            defaultValue = capturedStrings[3];
        }
        if (![defaultValue length] && defaultValues && [defaultValues[keyPath] length]) {
            defaultValue = defaultValues[keyPath];
        }
        NSString *val = @"";
        if ([capturedStrings[0] characterAtIndex:0] == '\\') {
            val = [capturedStrings[0] substringFromIndex:1];
        } else if (keyPath) {
            @try {
                val = [dict valueForKeyPath:keyPath];
            }
            @catch (NSException *exception) {
                val = nil;
            }
            if (val == (id)[NSNull null]) {
                if (defaultValue) {
                    val = defaultValue;
                } else {
                    val = @"";
                }
            }
        }
        return val;
    }];
    
}

@end
