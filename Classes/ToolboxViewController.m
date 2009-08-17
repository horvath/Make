//  Make
//  Created by Peter Horvath.
//  Copyright 2009 O'Reilly Media. All rights reserved.

#import "ToolboxViewController.h"
#import "FlickrViewController.h"

@implementation ToolboxViewController

@synthesize toolBox;
@synthesize toolTable;
@synthesize imgPicker;

- (void)loadView {
	toolTable = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
	toolTable.delegate = self;
	toolTable.dataSource = self;

	self.view = toolTable;
}

- (void)viewDidLoad {

	// Camera
	self.imgPicker = [[UIImagePickerController alloc] init];
	self.imgPicker.allowsImageEditing = YES;
	self.imgPicker.delegate = self;
	

	// Table
	NSDictionary *row1 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Arduino connector",  @"First", @"View input / output data from Arduino", @"Second", nil];
	NSDictionary *row2 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Documentation camera",  @"First", @"Browse & upload photos to Flickr pool", @"Second", nil];
	NSDictionary *row3 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Pocket reference",  @"First", @"Codes, measurements, laws, charts, etc.", @"Second", nil];
	NSDictionary *row4 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Projects",  @"First", @"Featured projects from Instructables", @"Second", nil];
	NSDictionary *row5 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Electronics calculator",  @"First", @"LEDs, resistors and capacitors", @"Second", nil];
	NSDictionary *row6 = [[NSDictionary alloc] initWithObjectsAndKeys:
						  @"Clinometer",  @"First", @"Measures incline and level", @"Second", nil];
		
	NSArray *array = [[NSArray alloc] initWithObjects:row1, row2, row3, row4, row5, row6, nil];
	
	self.toolBox = array;
	
	[row1 release];
	[row2 release];	
	[row3 release];	
	[row4 release];	
	[row5 release];	
	[row6 release];		
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
	
	// Selection
	toolTitle.highlightedTextColor = [UIColor whiteColor];
	descValue.highlightedTextColor = [UIColor whiteColor];	
	
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
		UIImage *image = [UIImage imageNamed:@"toolProjects.png"];
		cell.imageView.image = image;	
	} else if (row == 4) {
		UIImage *image = [UIImage imageNamed:@"toolCalculator.png"];
		cell.imageView.image = image;
	} else if (row == 5) {
		UIImage *image = [UIImage imageNamed:@"toolClinometer.png"];
		cell.imageView.image = image;	
	}	
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {	
	
	int toolIndex = [indexPath indexAtPosition: [indexPath length] - 1];		
	
	if (toolIndex == 0) {
		
	} else if (toolIndex == 1) {

		/*FlickrViewController *flickrView = [[FlickrViewController alloc] init];
		[self.navigationController pushViewController:flickrView animated:YES];
		
		[flickrView release];			*/

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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
	[[picker parentViewController] dismissModalViewControllerAnimated:YES];
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
