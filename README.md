# NSStrine+KeyPathReplace

A simple NSString cateogory that gives you the ability to interpolate values
into a string taken from a given NSDictionary. It also allows you to specify
default values to be used if the dictionary does not contain a value for
a keypath. Default values can be provided inline with the keypath or in a
separate dictionary.

Note that keypaths don't support arrays so everything must be structured as
a dictionary (or at least anything that you reference with a keypath).

## Examples

### Simple Example

```objective-c
    NSDictionary *dict = @{
                           @"value": @"World"
                           };
    NSString *result = [@"Hello {value}!" stringByReplacingKeyPathBindingsWithDictionaryValues:dict];
    // result should now contain "Hello World!"

```

### Example with a hierarchy

```objective-c
    NSDictionary *dict = @{
                           @"planet": @"World",
                           @"person": @{
                                   @"firstname": @"Joe",
                                   @"lastname": @"Bloggs"
                                   }
                           };
    NSString *result = [@"Hello {planet}! Welcome {person.firstname} {person.lastname}." stringByReplacingKeyPathBindingsWithDictionaryValues:dict];
    // result should now contain "Hello World! Welcome Joe Bloggs."
```

### Example with defaults

```objective-c
    NSDictionary *dict = nil;
    NSDictionary *defaultValues = @{
                                    @"value": @"World"
                                    };
    NSString *result = [@"Hello {value}! Welcome {person.name:friend}." stringByReplacingKeyPathBindingsWithDictionaryValues:dict
                                                                                 defaultValues:defaultValues];
    // result should now contain "Hello World! Welcome friend."
```

