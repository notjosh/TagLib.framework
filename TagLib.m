//
//  TagLib.m
//  TagLibBundle
//
//  A simple Obj-C wrapper around the C functions that TagLib exposes
//
//  Created by Nick Ludlam on 21/07/2010.
//

#import "TagLib.h"
#include "tag_c.h"

// Required in order to be able to use #require in Ruby to load this bundle
void Init_TagLib(void) { }

@implementation TagLib

@synthesize validTags, validAudioProperties;

@synthesize path;

@synthesize title;
@synthesize artist;
@synthesize album;
@synthesize comment;
@synthesize genre;
@synthesize track;
@synthesize year;

@synthesize length, sampleRate, bitRate;

- (id)initWithFileAtPath:(NSString *)filePath {
    if (self = [super init]) {

        // Initialisation as per the TagLib example C code
        TagLib_File *file;
        TagLib_Tag *tag;
        
        // We want UTF8 strings out of TagLib
        taglib_set_strings_unicode(TRUE);

        file = taglib_file_new([filePath cStringUsingEncoding:NSUTF8StringEncoding]);

        self.path = filePath;

        if (file != NULL) {
            tag = taglib_file_tag(file);
            
            if (tag != NULL) {
                // Collect title, artist, album, comment, genre, track and year in turn.
                // Sanity check them for presence, and length
                
                self.validTags = YES;
                
                if (taglib_tag_title(tag) != NULL &&
                    strlen(taglib_tag_title(tag)) > 0) {
                    self.title = [NSString stringWithCString:taglib_tag_title(tag)
                                                    encoding:NSUTF8StringEncoding];
                }
                
                if (taglib_tag_artist(tag) != NULL &&
                    strlen(taglib_tag_artist(tag)) > 0) {
                    self.artist = [NSString stringWithCString:taglib_tag_artist(tag)
                                                     encoding:NSUTF8StringEncoding];
                }
                
                if (taglib_tag_album(tag) != NULL &&
                    strlen(taglib_tag_album(tag)) > 0) {
                    self.album = [NSString stringWithCString:taglib_tag_album(tag)
                                                    encoding:NSUTF8StringEncoding];
                }
                
                if (taglib_tag_comment(tag) != NULL &&
                    strlen(taglib_tag_comment(tag)) > 0) {
                    self.comment = [NSString stringWithCString:taglib_tag_comment(tag)
                                                      encoding:NSUTF8StringEncoding];
                }
                
                if (taglib_tag_genre(tag) != NULL &&
                    strlen(taglib_tag_genre(tag)) > 0) {
                    self.genre = [NSString stringWithCString:taglib_tag_genre(tag)
                                                    encoding:NSUTF8StringEncoding];
                }
                
                // Year and track are uints
                if (taglib_tag_year(tag) > 0) {
                    self.year = [NSNumber numberWithUnsignedInt:taglib_tag_year(tag)];
                }
                
                if (taglib_tag_track(tag) > 0) {
                    self.track = [NSNumber numberWithUnsignedInt:taglib_tag_track(tag)];
                }
            } else {
                self.validTags = NO;
            }
            
            const TagLib_AudioProperties *properties = taglib_file_audioproperties(file);

            if (properties != NULL) {
                
                self.validAudioProperties = YES;

                if (taglib_audioproperties_length(properties) > 0) {
                    self.length = [NSNumber numberWithInt:taglib_audioproperties_length(properties)];
                }
            } else {
                self.validAudioProperties = NO;
            }
            
            // Free up our used memory so far
            taglib_tag_free_strings();
            taglib_file_free(file);
            
        }
    }
    
    return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@ - Path: %@", [super description], path];
}

- (NSString *)inspect {
	return [self description];
}

@end
