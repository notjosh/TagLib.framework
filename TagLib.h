//
//  TagLib.h
//  TagLibBundle
//
//  A simple Obj-C wrapper around the C functions that TagLib exposes
//
//  Created by Nick Ludlam on 21/07/2010.
//

#import <Foundation/Foundation.h>

@interface TagLib : NSObject {
    NSDictionary *tags;
}

@property (nonatomic, retain) NSDictionary *tags;

@end
