//
//  TagLib.m
//  TagLibBundle
//
//  Created by Nick Ludlam on 21/07/2010.
//

#import "TagLib.h"
#include "tag_c.h"


void Init_TagLib(void) { }

@implementation TagLib

@synthesize tags;

- (id)init {
    if (self = [super init]) {
        self.tags = [NSDictionary dictionary];
    }
    
    return self;
}

- (id)initWithFileAtPath:(NSString *)filePath {
    if (self = [super init]) {
        // Initialisation
        TagLib_File *file;
        TagLib_Tag *tag;
        NSMutableDictionary *tempDictionary = [NSMutableDictionary dictionary];
        
        // We want UTF8 strings out of TagLib
        taglib_set_strings_unicode(TRUE);

        file = taglib_file_new([filePath cStringUsingEncoding:NSUTF8StringEncoding]);

        if (file != NULL) {
            tag = taglib_file_tag(file);

            // Collect title, artist, album, comment, genre, track and year in turn
            if (taglib_tag_title(tag) != NULL && strlen(taglib_tag_title(tag)) > 0) {
                [tempDictionary setObject:[NSString stringWithCString:taglib_tag_title(tag)
                                                             encoding:NSUTF8StringEncoding]
                                   forKey:@"title"];
            }
            
            if (taglib_tag_artist(tag) != NULL && strlen(taglib_tag_artist(tag)) > 0) {
                [tempDictionary setObject:[NSString stringWithCString:taglib_tag_artist(tag)
                                                             encoding:NSUTF8StringEncoding]
                             forKey:@"artist"];
            }
            
            if (taglib_tag_album(tag) != NULL && strlen(taglib_tag_album(tag)) > 0) {
                [tempDictionary setObject:[NSString stringWithCString:taglib_tag_album(tag)
                                                             encoding:NSUTF8StringEncoding]
                                   forKey:@"album"];
            }
            
            if (taglib_tag_comment(tag) != NULL && strlen(taglib_tag_comment(tag)) > 0) {
                [tempDictionary setObject:[NSString stringWithCString:taglib_tag_comment(tag)
                                                             encoding:NSUTF8StringEncoding]
                                   forKey:@"comment"];
            }
            
            if (taglib_tag_genre(tag) != NULL && strlen(taglib_tag_genre(tag)) > 0) {
                [tempDictionary setObject:[NSString stringWithCString:taglib_tag_genre(tag)
                                                             encoding:NSUTF8StringEncoding]
                                   forKey:@"genre"];
            }
            
            // Year and track are uints
            if (taglib_tag_year(tag) > 0) {
                [tempDictionary setObject:[NSNumber numberWithUnsignedInt:taglib_tag_year(tag)]
                                   forKey:@"year"];
            }
            
            if (taglib_tag_track(tag) > 0) {
                [tempDictionary setObject:[NSNumber numberWithUnsignedInt:taglib_tag_track(tag)]
                                   forKey:@"track"];
            }
            
            // Free up our used memory so far
            taglib_tag_free_strings();
            taglib_file_free(file);
            
        }

        self.tags = [NSDictionary dictionaryWithDictionary:tempDictionary];
        [tempDictionary release];
    }
    
    return self;
}


- (void)dealloc {
    [tags release]; tags = nil;
    [super dealloc];
}

@end
