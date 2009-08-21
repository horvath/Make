//  Make
//  Created by Peter Horvath.
//  Copyright 2009 O'Reilly Media. All rights reserved.

#import <UIKit/UIKit.h>
#define firstValueTag 1
#define secValueTag 2


@interface ToolboxViewController: UIViewController <UITableViewDataSource, UITableViewDelegate> 
{
	IBOutlet UITableView * toolTable;
	NSArray * toolBox;
	UIImagePickerController * imgPicker;	
}

@property (nonatomic, retain) NSArray * toolBox;
@property (nonatomic, retain) UITableView * toolTable;
@property (nonatomic, retain) UIImagePickerController * imgPicker;

@end
