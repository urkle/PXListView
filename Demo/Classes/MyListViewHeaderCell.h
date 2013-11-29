//
//  MyListViewHeaderCell.h
//  PXListView
//

#import <Cocoa/Cocoa.h>

#import "PXListViewCell.h"

@interface MyListViewHeaderCell : PXListViewCell
{
	NSTextField *titleLabel;
}

@property (nonatomic, retain) IBOutlet NSTextField *titleLabel;

@end
