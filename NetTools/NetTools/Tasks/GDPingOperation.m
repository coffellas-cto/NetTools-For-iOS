//
//  GDPingOperation.m
//  NetTools
//
//  Created by Alex G on 27.07.15.
//  Copyright (c) 2015 Alexey Gordiyenko. All rights reserved.
//

#import "GDPingOperation.h"
#include <sys/types.h>
#include <sys/socket.h>
#include <netdb.h>
#include <arpa/inet.h>

#import "CHelpers.h"

@implementation GDPingOperation

#pragma mark - Accessors

- (void)setHostString:(NSString *)hostString {
    if (self.executing) {
        return;
    }
    
    _hostString = hostString;
}

#pragma mark - Main

- (void)main {
    // (0) Check internet connection.
    
    // (1) Resolve domain
    struct addrinfo *p_addrinfo;
    int error = getaddrinfo([self.hostString cStringUsingEncoding:NSUTF8StringEncoding], NULL, NULL, &p_addrinfo);
    if (error) {
        [self.logger logLine:[NSString stringWithFormat:@"Can't resolve host \"%@\". %@", self.hostString, getaddrinfoStringFromErrorCode(error)]];
        [self logDone];
        return;
    }
    
    // (2) Loop through addresses and get internet address
    NSString *IPAddressString = nil;
    do {
        if (p_addrinfo->ai_family == AF_INET || p_addrinfo->ai_family == AF_INET6) {
            char host_string[NI_MAXHOST];
            struct sockaddr *sockaddr = p_addrinfo->ai_addr;
            int res = getnameinfo(sockaddr, sockaddr->sa_len, host_string, sizeof(host_string), NULL, 0, NI_NUMERICHOST);
            if (res == 0) {
                IPAddressString = @(host_string);
                break;
            }
        }
        p_addrinfo = p_addrinfo->ai_next;
    } while (p_addrinfo);
    
    if (!IPAddressString) {
        [self.logger logLine:@"None of the resolved interfaces are IPv4 or IPv6"];
        [self logDone];
    }
    
    // (3) Start sending packets
    int i = 0;
    do {
        [self.logger logLine:[NSString stringWithFormat:@"%@ (%@) seq=%@", IPAddressString, _hostString, @(i)]];
        usleep(1000 * 1000 * 1);
        i++;
    } while (!self.cancelled);
    
    [self logDone];
}

@end
