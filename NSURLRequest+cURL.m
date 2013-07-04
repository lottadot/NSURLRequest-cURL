//
//  NSURLRequest+cURL.m
//  temp
//
//  Created by Andrew Carter on 3/22/12.

#import "NSURLRequest+cURL.h"

@implementation NSURLRequest (cURL)

- (NSString *)cURLCommand {
    
    NSMutableString *string = [NSMutableString string];
    
    [string appendString:@"curl -k -i "];
    
    if ([self.HTTPMethod isEqualToString:@"POST"]) {
        
        NSString *params = [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding];
        [string appendFormat:@"-d \"%@\" ",params];
#if !__has_feature(objc_arc)
        [params release];
#endif
        
    }
    
    for (NSString *headerKey in [self.allHTTPHeaderFields allKeys]) {
        
        NSString *value = [self.allHTTPHeaderFields objectForKey:headerKey];
        [string appendFormat:@"-H \"%@\":\"%@\" ", headerKey, value];
        
    }
    
    [string appendString:[NSString stringWithFormat:@"\"%@\"",self.URL.absoluteString]];
    
    return [NSString stringWithString:string];
    
}

@end
