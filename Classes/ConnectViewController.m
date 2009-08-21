//  Make
//  Created by Peter Horvath.
//  Copyright 2009 O'Reilly Media. All rights reserved.

#import "ConnectViewController.h"
#import "TalkViewController.h"

@implementation ConnectViewController

@synthesize toolBox;
@synthesize connectTable;

- (void)loadView {
	connectTable = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
	connectTable.delegate = self;
	connectTable.dataSource = self;
	
	self.view = connectTable;
}

- (void)viewDidLoad {
	NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Make Magazine",  @"First", @"Read articles from the digital edition", @"Second", nil];
	NSDictionary *row2 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Maker Faire",  @"First", @"A guide to the world of Makers", @"Second", nil];
	NSDictionary *row3 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Make: Talk",  @"First", @"Listen to recorded radio broadcasts", @"Second", nil];
	NSDictionary *row4 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Make: Map",  @"First", @"Make-friendly shops and other places", @"Second", nil];
	NSDictionary *row5 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Community",  @"First", @"Discussion forum", @"Second", nil];
	
	
	NSArray *array = [[NSArray alloc] initWithObjects:row1, row2, row3, row4, row5, nil];
	
	self.toolBox = array;
	
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
	return [self.toolBox count];
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
	
	
	
	NSDictionary *rowData = [self.toolBox objectAtIndex:row];
	
	UILabel *toolTitle = (UILabel *)[cell.contentView viewWithTag:firstValueTag];
	UILabel *descValue = (UILabel *)[cell.contentView viewWithTag:secValueTag];
	
	//UIColor *darkGray= [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:25.0/255.0 alpha:1.0];  
	
	toolTitle.text = [rowData objectForKey:@"First"];
	descValue.text = [rowData objectForKey:@"Second"];
	
	toolTitle.font = [UIFont boldSystemFontOfSize:16];	
	descValue.font = [UIFont systemFontOfSize:13];	
	
	//Selection
	toolTitle.highlightedTextColor = [UIColor whiteColor];
	descValue.highlightedTextColor = [UIColor whiteColor];	
	
	if (row == 0) {
		UIImage *image = [UIImage imageNamed:@"connectMagazine.png"];
		cell.imageView.image = image;	
	} else if (row == 1) {
		UIImage *image = [UIImage imageNamed:@"connectFaire.png"];
		cell.imageView.image = image;	
	} else if (row == 2) {
		UIImage *image = [UIImage imageNamed:@"connectTalk.png"];
		cell.imageView.image = image;
	} else if (row == 3) {
		UIImage *image = [UIImage imageNamed:@"connectMap.png"];
		cell.imageView.image = image;	
	} else if (row == 4) {
		UIImage *image = [UIImage imageNamed:@"connectCommunity.png"];
		cell.imageView.image = image;	
	} 
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {	
	
	int toolIndex = [indexPath indexAtPosition: [indexPath length] - 1];		
	
	if (toolIndex == 0) {
		
	} else if (toolIndex == 1) {
		
	} else if (toolIndex == 2) {
		TalkViewController *talkView = [[TalkViewController alloc] init];
		[self.navigationController pushViewController:talkView animated:YES];
		
		[talkView release];			
	} else if (toolIndex == 3) {
		
	} else if (toolIndex == 4) {
		
	} else if (toolIndex == 5) {
		
	}
	
	
	
}

- (void)dealloc {
	[toolBox release];
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
