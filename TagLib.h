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
    BOOL validTags;
    BOOL validAudioProperties;
    
    NSString *path;

    NSString *title;
    NSString *artist;
    NSString *album;
    NSString *comment;
    NSString *genre;
    NSNumber *track;
    NSNumber *year;
    
    NSNumber *length;
    NSNumber *sampleRate;
    NSNumber *bitRate;
}

@property (nonatomic, copy) NSString *path;

@property (nonatomic) BOOL validTags;
@property (nonatomic) BOOL validAudioProperties;

// Tags
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *album;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *genre;
@property (nonatomic, retain) NSNumber *track;
@property (nonatomic, retain) NSNumber *year;

// Audio properties
@property (nonatomic, retain) NSNumber *length;
@property (nonatomic, retain) NSNumber *sampleRate;
@property (nonatomic, retain) NSNumber *bitRate;

@end
