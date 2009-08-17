//  Make
//  Created by Peter Horvath.
//  Copyright 2009 O'Reilly Media. All rights reserved.

#import <UIKit/UIKit.h>
#import "TouchXML.h"

@interface TalkViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    // This is the outlet for the blog view, it will allow the data from the controller to be used in a view
    IBOutlet UITableView *blogTable;
	
    // blogEntries is used to store the data retrieved from the RSS feed before being added to the view
    NSMutableArray *blogEntries;
	
    // loadSwirlie will display a loading overlay while the data is downloaded from the RSS feed.
    UIActivityIndicatorView *loadSwirlie;
}

@property (nonatomic, retain) UITableView *blogTable;
@end