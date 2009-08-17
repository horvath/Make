#import "MakeAppDelegate.h"
#import "OnlineViewController.h"

@implementation OnlineViewController

@synthesize blogTable;

// grabRSSFeed function that takes a string (blogAddress) as a parameter and
// fills the global blogEntries with the entries
-(void) grabRSSFeed:(NSString *)blogAddress {
	
    // Initialize the blogEntries MutableArray that we declared in the header
    blogEntries = [[NSMutableArray alloc] init];	
	
    // Convert the supplied URL string into a usable URL object
    NSURL *url = [NSURL URLWithString: blogAddress];
    // Create a new rssParser object based on the TouchXML "CXMLDocument" class, this is the
    // object that actually grabs and processes the RSS data
    CXMLDocument *rssParser = [[[CXMLDocument alloc] initWithContentsOfURL:url options:0 error:nil] autorelease];
	
    // Create a new Array object to be used with the looping of the results from the rssParser
    NSArray *resultNodes = NULL;
	
    // Set the resultNodes Array to contain an object for every instance of an  node in our RSS feed
    resultNodes = [rssParser nodesForXPath:@"//item" error:nil];
	
    // Loop through the resultNodes to access each items actual data
    for (CXMLElement *resultElement in resultNodes) {
		
        // Create a temporary MutableDictionary to store the items fields in, which will eventually end up in blogEntries
        NSMutableDictionary *blogItem = [[NSMutableDictionary alloc] init];
		
        // Create a counter variable as type "int"
        int counter;
		
        // Loop through the children of the current  node
        for(counter = 0; counter < [resultElement childCount]; counter++) {
			
            // Add each field to the blogItem Dictionary with the node name as key and node value as the value
            [blogItem setObject:[[resultElement childAtIndex:counter] stringValue] forKey:[[resultElement childAtIndex:counter] name]];
        }
		
        // Add the blogItem to the global blogEntries Array so that the view can access it.
        [blogEntries addObject:[blogItem copy]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [blogEntries count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSInteger titleTag = 1;
	static NSInteger descTag = 2;
	static NSInteger dateTag = 3;	
    
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];		

		CGRect frame;
		frame.origin.x = 8; frame.origin.y = 5;
		frame.size.height = 18; frame.size.width = 221;		
		
		UILabel *storyTitle = [[UILabel alloc] initWithFrame:frame];
		storyTitle.backgroundColor = [UIColor clearColor];
		storyTitle.tag = titleTag;
		[cell.contentView addSubview:storyTitle];
		[storyTitle release];
		
		frame.size.width = 293;
		frame.origin.y += 17; frame.size.height = 36;		
		UILabel *storyDesc = [[UILabel alloc] initWithFrame:frame];
		storyDesc.backgroundColor = [UIColor clearColor];
		storyDesc.tag = descTag;
		storyDesc.numberOfLines	= 2;
		[cell.contentView addSubview:storyDesc];
		[storyDesc release];    

		frame.size.width = 70;
		frame.origin.y -= 17; frame.origin.x += 230; frame.size.height = 18;		
		UILabel *storyDate = [[UILabel alloc] initWithFrame:frame];
		storyDate.backgroundColor = [UIColor clearColor];
		storyDate.tag = dateTag;
		[cell.contentView addSubview:storyDate];
		[storyDate release];	
	}
    
	
	UILabel *storyTitle = (UILabel *) [cell.contentView viewWithTag:titleTag];
	UILabel *storyDesc = (UILabel *) [cell.contentView viewWithTag:descTag];
	UILabel *storyDate = (UILabel *) [cell.contentView viewWithTag:dateTag];	
	
    // Set up the cell
	int blogEntryIndex = [indexPath indexAtPosition: [indexPath length] -1];

	//[cell setText:[[blogEntries objectAtIndex: blogEntryIndex] objectForKey: @"title"]];		
	
	storyTitle.text = [[blogEntries objectAtIndex: blogEntryIndex] objectForKey: @"title"];
	storyDesc.text = [[blogEntries objectAtIndex: blogEntryIndex] objectForKey: @"lofi"];

	
	// Clean up date
	NSString *storyDateText = [[blogEntries objectAtIndex: blogEntryIndex] objectForKey: @"pubDate"];	
	
	NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat: @"EEEE dd MMMM yyyy H:mm:ss"];		
    [df setLocale: [[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] autorelease]];
	NSDate *date = [df dateFromString:storyDateText];
	
    [df setDateFormat: @"dd MMM H:mm"];		
	
    NSString *formattedDateString = [df stringFromDate:date];
	
	storyDate.text = formattedDateString;	
	
	// Customize
	UIColor *liteGray= [UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1.0];  	
	
	storyTitle.font = [UIFont boldSystemFontOfSize:15];	
	storyDesc.font = [UIFont systemFontOfSize:13];	
	storyDate.font = [UIFont systemFontOfSize:11];
	storyDate.textColor = liteGray;	
	
	// Selection
	storyTitle.highlightedTextColor = [UIColor whiteColor];
	storyDesc.highlightedTextColor = [UIColor whiteColor];
	
	
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic -- create and push a new view controller
}


/*
 - (void)viewDidLoad {
 [super viewDidLoad];
 // Uncomment the following line to add the Edit button to the navigation bar.
 // self.navigationItem.rightBarButtonItem = self.editButtonItem;
 }
 */


/*
 // Override to support editing the list
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support conditional editing of the list
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support rearranging the list
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the list
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Check if blogEntries has already been filled, if not
    // then send the request
    if([blogEntries count] == 0) {
        // Create the feed string, in this case I have used dBlog
        NSString *blogAddress = @"http://blog.makezine.com/iphone.xml";
		
		
        // Call the grabRSSFeed function with the above
        // string as a parameter
        [self grabRSSFeed:blogAddress];
		
        // Call the reloadData function on the blogTable, this
        // will cause it to refresh itself with our new data
        [blogTable reloadData];
    }
}
/*
 - (void)viewWillDisappear:(BOOL)animated {
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 }
 */

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}

// Set the height of the table cell
#pragma mark -
#pragma mark Table View Delegate Methods
-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 61;
}

@end

