//
//  AppDelegate.m
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

#import "AppDelegate.h"

#import "MyModel.h"
#import "MyListViewCell.h"
#import "MyListViewHeaderCell.h"


#pragma mark Constants

#define LISTVIEW_CELL_IDENTIFIER		@"MyListViewCell"
#define LISTVIEW_HEADER_CELL_IDENTIFIER		@"MyListViewHeaderCell"

#define NUM_EXAMPLE_SECTIONS            5
#define NUM_EXAMPLE_ITEMS               10

@implementation AppDelegate

#pragma mark -
#pragma mark Init/Dealloc

- (void)awakeFromNib
{
	[listView setCellSpacing:2.0f];
	[listView setAllowsEmptySelection:YES];
	[listView setAllowsMultipleSelection:YES];
	[listView registerForDraggedTypes:[NSArray arrayWithObjects: NSStringPboardType, nil]];
	
	_listItems = [[NSMutableArray alloc] init];


	//Create a bunch of rows as a test
    for( NSInteger s = 0; s < NUM_EXAMPLE_SECTIONS; ++s)
    {
        MyModel *model = [[[MyModel alloc] init] autorelease];
        model.title = [NSString stringWithFormat:@"Section %ld", (long)(s + 1)];
        model.section = YES;
        [_listItems addObject:model];

        for( NSInteger i = 0; i < NUM_EXAMPLE_ITEMS; i++ )
        {
            model = [[[MyModel alloc] init] autorelease];
            model.title = [NSString stringWithFormat: @"Item %ld", (long)((s * NUM_EXAMPLE_ITEMS) + i + 1)];
            model.section = NO;
            [_listItems addObject:model];
        }
    }

	[listView reloadData];
}

- (void)dealloc
{
	[_listItems release], _listItems=nil;
    
	[super dealloc];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

#pragma mark -
#pragma mark List View Delegate Methods

- (NSUInteger)numberOfRowsInListView: (PXListView*)aListView
{
#pragma unused(aListView)
	return [_listItems count];
}

- (PXListViewCell*)listView:(PXListView*)aListView cellForRow:(NSUInteger)row
{
    MyModel *obj = [_listItems objectAtIndex:row];

    if (obj.isSection) {
        MyListViewHeaderCell *cell = (MyListViewHeaderCell*)[aListView dequeueCellWithReusableIdentifier:LISTVIEW_HEADER_CELL_IDENTIFIER];

        if(!cell) {
            cell = [MyListViewHeaderCell cellLoadedFromNibNamed:@"MyListViewHeaderCell" reusableIdentifier:LISTVIEW_HEADER_CELL_IDENTIFIER];
        }

        // Set up the new cell:
        [[cell titleLabel] setStringValue: obj.title];

        return cell;
    } else {
        MyListViewCell *cell = (MyListViewCell*)[aListView dequeueCellWithReusableIdentifier:LISTVIEW_CELL_IDENTIFIER];
        
        if(!cell) {
            cell = [MyListViewCell cellLoadedFromNibNamed:@"MyListViewCell" reusableIdentifier:LISTVIEW_CELL_IDENTIFIER];
        }

        // Set up the new cell:
        [[cell titleLabel] setStringValue: obj.title];
        
        return cell;
    }
}

- (CGFloat)listView:(PXListView*)aListView heightOfRow:(NSUInteger)row
{
	return 50;
}

- (void)listViewSelectionDidChange:(NSNotification*)aNotification
{
    NSLog(@"Selection changed");
}


// The following are only needed for drag'n drop:
- (BOOL)listView:(PXListView*)aListView writeRowsWithIndexes:(NSIndexSet*)rowIndexes toPasteboard:(NSPasteboard*)dragPasteboard
{
	// +++ Actually drag the items, not just dummy data.
	[dragPasteboard declareTypes: [NSArray arrayWithObjects: NSStringPboardType, nil] owner: self];
    NSString *content = [[[_listItems objectsAtIndexes:rowIndexes] valueForKey:@"title"] componentsJoinedByString:@", "];
	[dragPasteboard setString: content forType: NSStringPboardType];
	
	return YES;
}

- (NSDragOperation)listView:(PXListView*)aListView validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSUInteger)row
							proposedDropHighlight:(PXListViewDropHighlight)dropHighlight;
{
	return NSDragOperationCopy;
}

- (IBAction) reloadTable:(id)sender
{
	[listView reloadData];
}

@end
