//  JSON Flickr
//  Created by David Nolen on 4/2/09. Modified by Peter Horvath.
//  Copyright David Nolen 2009. All rights reserved.

#import <UIKit/UIKit.h>
#import "LCURLConnection.h"
#import "LCImageDownloadQueue.h"

@interface FlickrViewController : UIViewController <LCURLConnectionDelegate, LCImageDownloadQueueRequester>
{
  NSInteger currentImage;
}

- (void) showPhotos:(NSArray*)photos;
- (NSString*) photoURL:(NSDictionary*)photo;

@end

