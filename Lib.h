//
//  Lib.h
//  Library
//
//  Created by MacBook Pro on 17/07/14.
//  Copyright (c) 2014 Inspeero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lib : NSObject {
    NSMutableArray* libArray;
    NSMutableDictionary* userBookDict;
}

-(NSString*) addToLib;
-(NSString*) remFromLib;
-(NSString*) issueBook: (NSString*)bookName toUser:(NSString*)userName;
-(NSString*) returnBook: (NSString*)bookName fromUser: (NSString*)userName;
-(NSString*) checkBookAvailability: (NSString*)bookName;
-(void) showCollection;

@end
