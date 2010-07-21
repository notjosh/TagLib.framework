//
//  TagLib.h
//  TagLibBundle
//
//  Created by Nick Ludlam on 21/07/2010.
//

#import <Foundation/Foundation.h>

@interface TagLib : NSObject {
    NSDictionary *tags;
}

@property (nonatomic, retain) NSDictionary *tags;

@end
