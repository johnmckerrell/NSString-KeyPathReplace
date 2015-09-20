//
//  NSString+KeyPathReplace.h
//  CamViewer
//
//  Created by John McKerrell on 16/07/2013.
//
//

#import <Foundation/Foundation.h>

@interface NSString (KeyPathReplace)

- (NSString*)stringByReplacingKeyPathBindingsWithDictionaryValues:(NSDictionary*)dict;
- (NSString*)stringByReplacingKeyPathBindingsWithDictionaryValues:(NSDictionary*)dict defaultValues:(NSDictionary*)defaultValues;

@end
