//  Make
//  Created by Peter Horvath.
//  Copyright 2009 O'Reilly Media. All rights reserved.

#import <UIKit/UIKit.h>
#define firstValueTag 1
#define secValueTag 2


@interface CalcViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> 
{
	IBOutlet UITableView * blogDetailTable; 
	NSArray * blogDetail;
}

@property (nonatomic, retain) NSArray * blogDetail;
@property (nonatomic, retain) UITableView * blogDetailTable;
@end
