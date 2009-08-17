//  JSON Flickr
//  Created by David Nolen on 4/2/09. Modified by Peter Horvath.
//  Copyright David Nolen 2009. All rights reserved.

#import "FlickrViewController.h"
#import "JSON.h"
#import "LCURLConnection.h"
#import "LCImageDownloadQueue.h"

@implementation FlickrViewController


- (id) initWithCoder:(NSCoder*)coder
{
  self = [super initWithCoder:coder];
  if(self != nil)
  {
    currentImage = 0;
  }
  return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
  [super viewDidLoad];
  
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;	
	
  NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                              @"flickr.photos.search", @"method",
                              @"85ed84acf25a069386b7209a507ee811", @"api_key",
                              @"69453349@N00", @"group_id",
                              @"20", @"per_page",
                              @"1", @"page",
                              @"json", @"format", nil];
  
  NSString *requestString = [NSString stringWithFormat:@"http://api.flickr.com/services/rest/?%@", [params toURLParameters]];

  [[LCURLConnection alloc] initWithURL:requestString delegate:self];
		
}


- (void) showPhotos:(NSArray*)photos
{
  LCImageDownloadQueue *queue = [LCImageDownloadQueue sharedQueue];
  
  for(NSDictionary *photo in photos)
  {
    NSString *photoURL = [self photoURL:photo];
    NSLog(@"%@", photoURL);
    [queue queueImage:photoURL forRequester:self];
  }
}


- (NSString*) photoURL:(NSDictionary*)photo
{
  return [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg", 
          [photo objectForKey:@"farm"], 
          [photo objectForKey:@"server"],
          [photo objectForKey:@"id"],
          [photo objectForKey:@"secret"]];
}

#pragma mark -
#pragma mark LCURLConnection Delegate Methods

- (void) connectionDidFinishLoading:(LCURLConnection*)connection
{
  NSString *response = [connection response];
  
  // remove the surrounding JSONP style function call 
  NSString *jsonString = [response substringWithRange:NSMakeRange(14, [response length]-15)];
  NSDictionary *json = [jsonString JSONValue];
  
  [connection release];
  
  [self showPhotos:[[json objectForKey:@"photos"] valueForKey:@"photo"]];
	
}


- (void) connection:(LCURLConnection*)connection didFailWithError:(NSError*)error
{
  NSLog(@"error loading from Flickr, %@", error);
  [connection release];
}

#pragma mark -
#pragma mark LCImageDownloadQueue Delegate Methods


- (void)queueDidLoadImage:(UIImage*)image
{
  [(UIImageView*)[[self.view subviews] objectAtIndex:currentImage] setImage:image];
  currentImage++;
}


- (void)queueDidFailToLoadImage:(NSString*)imageURL withError:(NSError*)error
{
  NSLog(@"Failed to load image with error %@", error);
}


- (void)didReceiveMemoryWarning 
{
  [super didReceiveMemoryWarning];
}


- (void)viewDidUnload 
{
}


- (void)dealloc 
{
  [super dealloc];
}

@end
