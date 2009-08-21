//  Make
//  Created by Peter Horvath.
//  Copyright 2009 O'Reilly Media. All rights reserved.

#import "ToolboxViewController.h"
#import "FlickrViewController.h"
#import "CalcViewController.h"

@implementation ToolboxViewController

@synthesize toolBox;
@synthesize toolTable;
@synthesize imgPicker;

- (void)loadView {
	toolTable = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];

	toolTable.separatorStyle = UITableViewCellSeparatorStyleNone;	
	
	toolTable.delegate = self;
	toolTable.dataSource = self;

	self.view = toolTable;
}

- (void)viewDidLoad {

	// Table
	NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Arduino connector",  @"First", @"Interface with physical devices", @"Second", nil];
	NSDictionary *row2 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Flickr camera",  @"First", @"Browse & upload to Make's pool", @"Second", nil];
	NSDictionary *row3 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Pocket reference",  @"First", @"Codes, measurements, charts, etc.", @"Second", nil];
	NSDictionary *row4 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Electronics calculator",  @"First", @"LEDs, resistors and capacitors", @"Second", nil];
	NSDictionary *row5 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Maker's notebook",  @"First", @"Document and sketch your projects", @"Second", nil];
	NSDictionary *row6 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Clinometer",  @"First", @"Measures incline and level", @"Second", nil];
	NSDictionary *row7 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Projects",  @"First", @"Featured projects from Instructables", @"Second", nil];
		
	NSArray *array = [[NSArray alloc] initWithObjects:row1, row2, row3, row4, row5, row6, row7, nil];
	
	self.toolBox = array;
	
	[row1 release];
	[row2 release];	
	[row3 release];	
	[row4 release];	
	[row5 release];	
	[row6 release];		
	[row7 release];
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

		CGRect cellFrame;
		
        cellFrame.origin.x = 0;
        cellFrame.origin.y = 0;
        cellFrame.size.width = 300;
        cellFrame.size.height = 65;
		
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellTableIdentifier] autorelease];
		
		UIImage *indicatorImage = [UIImage imageNamed:@"Indicator.png"];
		cell.accessoryView = [[[UIImageView alloc] initWithImage:indicatorImage] autorelease];		
		



		cell.backgroundView = [[[UIImageView alloc] init] autorelease];
		cell.selectedBackgroundView = [[[UIImageView alloc] init] autorelease];	
	}
	
	//cell.contentView.backgroundColor = [UIColor darkGrayColor];
	
	
	UIImage *rowBackground;
	UIImage *selectionBackground;
	
	rowBackground = [UIImage imageNamed:@"CellBackground.png"];
	selectionBackground = [UIImage imageNamed:@"CellBackgroundSelected.png"];
	
	
	
	((UIImageView *)cell.backgroundView).image = rowBackground;	
	((UIImageView *)cell.selectedBackgroundView).image = selectionBackground;		
	
	NSDictionary *rowData = [self.toolBox objectAtIndex:row];

	
	cell.textLabel.text = [rowData objectForKey:@"First"];
	cell.detailTextLabel.text = [rowData objectForKey:@"Second"];
	

	
	if (row == 0) {
		UIImage *image = [UIImage imageNamed:@"toolArduino.png"];
		cell.imageView.image = image;	
	} else if (row == 1) {
		UIImage *image = [UIImage imageNamed:@"toolFlickr.png"];
		cell.imageView.image = image;
	} else if (row == 2) {
		UIImage *image = [UIImage imageNamed:@"toolReference.png"];
		cell.imageView.image = image;	
	} else if (row == 3) {
		UIImage *image = [UIImage imageNamed:@"toolCalculator.png"];
		cell.imageView.image = image;	
	} else if (row == 4) {
		UIImage *image = [UIImage imageNamed:@"toolNotebook.png"];
		cell.imageView.image = image;
	} else if (row == 5) {
		UIImage *image = [UIImage imageNamed:@"toolClinometer.png"];
		cell.imageView.image = image;		
	} else if (row == 6) {
		UIImage *image = [UIImage imageNamed:@"toolProjects.png"];
		cell.imageView.image = image;	
	}	

	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {	
	
	int toolIndex = [indexPath indexAtPosition: [indexPath length] - 1];		
	
	if (toolIndex == 0) {
		

		
	} else if (toolIndex == 1) {

		FlickrViewController *flickrView = [[FlickrViewController alloc] initWithNibName:@"FlickrViewController" bundle:[NSBundle mainBundle]];
		[self.navigationController pushViewController:flickrView animated:YES];

		[flickrView release];			
					
		UIBarButtonItem *button = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera
																				 target:self
																				 action:@selector(dialogOKCancelAction:)] autorelease];
		[flickrView.navigationItem setRightBarButtonItem:button animated:YES];		
		
	} else if (toolIndex == 2) {
		
	} else if (toolIndex == 3) {
		
	} else if (toolIndex == 4) {

		CalcViewController *calcView = [[CalcViewController alloc] init];
		[self.navigationController pushViewController:calcView animated:YES];
		
		[calcView release];					
		
	} else if (toolIndex == 5) {
		
	}	
}


// Open a dialog with custom buttons
- (void)dialogOKCancelAction:(id)sender
{
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@""
															 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
													otherButtonTitles:@"Take Photo", @"Chose Existing Photo", @"Cancel", nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	
	// Make the third button destructive
	actionSheet.destructiveButtonIndex = 2;	
	
	// Reveal action sheet from tab bar
	[actionSheet showInView:self.tabBarController.view];
	[actionSheet setBounds:CGRectMake(0,15,320,245)];
	
	[actionSheet release];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0){		
		self.imgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;	
		[self presentModalViewController:self.imgPicker animated:YES];		
	}
	else if (buttonIndex == 1){
		self.imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;	
		[self presentModalViewController:self.imgPicker animated:YES];		
	} else if (buttonIndex == 2) {

	}
}

- (void)viewWillAppear:(BOOL)animated
{
	// Unselect the selected row if any
	NSIndexPath *selection = [self.toolTable indexPathForSelectedRow];
	if (selection)
		[self.toolTable deselectRowAtIndexPath:selection animated:YES];
	
	[self.toolTable reloadData];
}

- (void)dealloc
{
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
