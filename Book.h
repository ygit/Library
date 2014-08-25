//
//  Book.h
//  Library
//
//  Created by MacBook Pro on 17/07/14.
//  Copyright (c) 2014 Inspeero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject {
    int bookID;
    NSString* bookName;
    BOOL isIssued;
}

@property int bookID;
@property(retain) NSString* bookName;
@property BOOL isIssued;

@end
