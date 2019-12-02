//
//  PXListViewCell+Private.h
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

@interface PXListViewCell ()

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wobjc-multiple-method-names"

@property (readwrite, copy) NSString *reusableIdentifier;
@property (readwrite, assign) NSUInteger row;

#pragma GCC diagnostic pop
@end
