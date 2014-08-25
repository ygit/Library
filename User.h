//
//  User.h
//  Library
//
//  Created by MacBook Pro on 17/07/14.
//  Copyright (c) 2014 Inspeero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject {
    int userID;
    BOOL isUserBookCollectionJustCreated;
    NSString* userName;
}

@property int userID;
@property(retain) NSString* userName;
@property BOOL isUserBookCollectionJustCreated;

@end
