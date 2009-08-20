//  Make
//  Created by Peter Horvath.
//  Copyright 2009 O'Reilly Media. All rights reserved.

#import "BlogDetailViewController.h"

@implementation BlogDetailViewController

@synthesize blogDetail;
@synthesize blogDetailTable;
@synthesize detailHeader;
@synthesize detailBody;
@synthesize detailPubDate;
@synthesize detailAuthor;
@synthesize detailCategory;

- (void)loadView {
	blogDetailTable = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
	blogDetailTable.delegate = self;
	blogDetailTable.dataSource = self;
	
	self.view = blogDetailTable;
}

- (void)viewDidLoad {
	
	// Table
	NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys: detailHeader, @"First", nil];
	NSDictionary *row2 = [[NSDictionary alloc] initWithObjectsAndKeys: detailBody, @"First", nil];
	NSDictionary *row3 = [[NSDictionary alloc] initWithObjectsAndKeys: detailPubDate, @"First", nil];
	NSDictionary *row4 = [[NSDictionary alloc] initWithObjectsAndKeys: detailAuthor, @"First", nil];
	NSDictionary *row5 = [[NSDictionary alloc] initWithObjectsAndKeys: detailCategory, @"First", nil];
	
	NSArray *array = [[NSArray alloc] initWithObjects:row1, row2, row3, row4, row5, nil];
	
	self.blogDetail = array;
	
	[row1 release];
	[row2 release];	
	[row3 release];	
	[row4 release];	
	[row5 release];		
	[array release];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; 
	// Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.blogDetail count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellTableIdentifier = @"CellTableIdentifier";
	
	NSInteger row = indexPath.row;
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
	
	if (cell == nil) {
		CGRect cellFrame = CGRectMake(30, 0, 300, 65);
		
		cell = [[[UITableViewCell alloc] initWithFrame: cellFrame reuseIdentifier: CellTableIdentifier] autorelease];
		[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];		
		
		CGRect toolTitleRect = CGRectMake(45, 10, 260, 17);
		UILabel *toolTitle = [[UILabel alloc] initWithFrame:toolTitleRect];
		toolTitle.tag = firstValueTag;
		[cell.contentView addSubview:toolTitle];
		[toolTitle release];
		
		CGRect descValueRect = CGRectMake(45, 29, 260, 17);
		UILabel *descValue = [[UILabel alloc] initWithFrame:descValueRect];
		descValue.tag = secValueTag;
		[cell.contentView addSubview:descValue];		
		[descValue release];
	}
	
	
	
	NSDictionary *rowData = [self.blogDetail objectAtIndex:row];
	
	UILabel *toolTitle = (UILabel *)[cell.contentView viewWithTag:firstValueTag];
	UILabel *descValue = (UILabel *)[cell.contentView viewWithTag:secValueTag];
	
	//UIColor *darkGray= [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:1.0];  
	
	toolTitle.text = [rowData objectForKey:@"First"];
	descValue.text = [rowData objectForKey:@"Second"];
	
	toolTitle.font = [UIFont boldSystemFontOfSize:16];	
	descValue.font = [UIFont systemFontOfSize:13];	
	
	// Selection
	toolTitle.highlightedTextColor = [UIColor whiteColor];
	descValue.highlightedTextColor = [UIColor whiteColor];	
	
	
	return cell;
}

- (void)dealloc
{
	[blogDetail release];
    [super dealloc];
}

#pragma mark -
#pragma mark Table View Data Source Methods

-(CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 61;
}

@end
