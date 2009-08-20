//
//  CustomNavigatioBar.m
//  Text
//
//  Created by Peter Horvath on 13/08/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CustomNavigationBar.h"


@implementation CustomNavigationBar

- (void)setBackgroundImage:(UIImage*)image {
	if(image == NULL){
		return;
	}
	UIImageView *bgView = [[UIImageView alloc]initWithImage:image];
	backgroundView = bgView;
	[self addSubview:backgroundView];
	[self sendSubviewToBack:backgroundView];
	[bgView release];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		//[self setBackgroundImage:[UIImage imageNamed:@"NavigationBar.png"]];
	}
	return self;
}

- (void)pushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated {
	[super pushNavigationItem:item animated:animated];
	[self sendSubviewToBack:backgroundView];
}

- (UINavigationItem *)popNavigationItemAnimated:(BOOL)animated {
	[super popNavigationItemAnimated:YES];
	[self sendSubviewToBack:backgroundView];
	return [self topItem];
}

- (void)dealloc {
	[backgroundView release];
	[super dealloc];
}

@end