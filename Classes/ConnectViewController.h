//  Make
//  Created by Peter Horvath.
//  Copyright 2009 O'Reilly Media. All rights reserved.

#import <UIKit/UIKit.h>
#define firstValueTag 1
#define secValueTag 2


@interface ConnectViewController: UIViewController <UITableViewDataSource, UITableViewDelegate> 
{
	IBOutlet UITableView * connectTable;
	NSArray * toolBox;
}

@property (nonatomic, retain) NSArray * toolBox;
@property (nonatomic, retain) UITableView * connectTable;
@end
