//
//  MyModel.h
//  PXListView
//
//  Created by Edward Rudd on 11/29/13.
//
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject {
    NSString *_title;
    BOOL _section;
}

@property (copy) NSString* title;
@property (assign, getter = isSection) BOOL section;

@end
