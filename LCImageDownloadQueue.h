//  JSON Flickr
//  Created by David Nolen on 4/2/09.
//  Copyright David Nolen 2009. All rights reserved.

#import <UIKit/UIKit.h>
#import "LCURLConnection.h"

@class LCImageDownloadQueue;

@protocol LCImageDownloadQueueRequester <NSObject>
@required
- (void) queueDidLoadImage:(UIImage*)image;
- (void) queueDidFailToLoadImage:(NSString*)imageUrl withError:(NSError*)error;
@end

@interface LCImageDownloadQueue : NSObject <LCURLConnectionDelegate>
{
  BOOL                        isDownloading;
  NSMutableArray              *queue;
}

+ (LCImageDownloadQueue *) sharedQueue;

- (void) queueImage:(NSString*)imageURL forRequester:(id)requester;

@end
