#import <UIKit/UIKit.h>
#import "TouchXML.h"
#import "AsyncImageView.h"

@interface OnlineViewController : UITableViewController {
    // This is the outlet for the blog view, it will allow the data from the controller to be used in a view
    IBOutlet UITableView *blogTable;
	
    // blogEntries is used to store the data retrieved from the RSS feed before being added to the view
    NSMutableArray *blogEntries;
	
	NSMutableString *currentTitle, *currentSummary;
}

@property (nonatomic, retain) UITableView * blogTable;

@end