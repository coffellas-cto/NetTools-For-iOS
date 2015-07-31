//
//  f.m
//  NetTools
//
//  Created by Alex G on 31.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import "CHelpers.h"

#include <netdb.h>

NSString *getaddrinfoStringFromErrorCode(int code) {
    switch (code) {
        case EAI_ADDRFAMILY:
            return @"The specified network host does not have any network addresses in the requested address family.";
            
        case EAI_AGAIN:
            return @"The name server returned a temporary failure indication.  Try again later.";
            
        case EAI_FAIL:
            return @"The name server returned a permanent failure indication.";
            
        case EAI_FAMILY:
            return @"The requested address family is not supported.";
            
        case EAI_MEMORY:
            return @"Out of memory.";
            
        case EAI_NODATA:
            return @"The specified network host exists, but does not have any network addresses defined.";
            
        case  EAI_NONAME:
            return @"The node or service is not known.";
            
        case EAI_SERVICE:
            return @"The requested service is not available for the requested socket type.";
            
        case EAI_SOCKTYPE:
            return @"The requested socket type is not supported.";
            
        default:
            return @"Unknown Error.";
    }
}

