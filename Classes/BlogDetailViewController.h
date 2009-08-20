//  Make
//  Created by Peter Horvath.
//  Copyright 2009 O'Reilly Media. All rights reserved.

#import <UIKit/UIKit.h>
#define firstValueTag 1
#define secValueTag 2


@interface BlogDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> 
{
	IBOutlet UITableView * blogDetailTable; 
	NSArray * blogDetail;
	NSString * detailHeader;
	NSString * detailBody;
	NSString * detailPubDate;	
	NSString * detailAuthor;	
	NSString * detailCategory;	
}

@property (nonatomic, retain) NSArray * blogDetail;
@property (nonatomic, retain) UITableView * blogDetailTable;
@property (retain)	NSString * detailHeader;
@property (retain)	NSString * detailBody;
@property (retain)	NSString * detailPubDate;
@property (retain)	NSString * detailAuthor;
@property (retain)	NSString * detailCategory;
@end
