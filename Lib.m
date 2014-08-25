//
//  Lib.m
//  Library
//
//  Created by MacBook Pro on 17/07/14.
//  Copyright (c) 2014 Inspeero. All rights reserved.
//

#import "Lib.h"
#import "Book.h"
#import "User.h"

@implementation Lib


// ---------------------------------------------------------------------------------------------

//      adding book to library
-(NSString*)addToLib{
    
    if(!libArray){
            libArray = [[NSMutableArray alloc]init];
    }
    
    NSString* additionResult=[[NSString alloc]init];
    
//      take book name from user
   
    NSLog(@"Enter name of the book to add : ");
    char bookNameInC[50] = {0};
    scanf(" %[^\n]s",bookNameInC);
    NSString* bookName = [NSString stringWithFormat:@"%s",bookNameInC];
    
    Book* bookObject = [[Book alloc]init];
    bookObject.bookName = bookName;
    bookObject.isIssued = false;
    bookObject.bookID = (int)libArray.count;
    
//      check if book already exists, if not then add to library
    BOOL islibArrayEmpty = ([libArray count] == 0);
    BOOL match = false;
    
    if(islibArrayEmpty){
        
        [libArray addObject:bookObject];
        additionResult = [NSString stringWithFormat: @"Book Name : %@ was added to the library.",bookName];
        
    } else {
    
        for (int i=0;i<[libArray count];i++) {
            
            Book* temp = [libArray objectAtIndex:i];
            if([temp.bookName isEqualToString:bookName]){
                match = true;
                break;
            }
        }
        if (match) {
            additionResult = [NSString stringWithFormat: @"Book Name : %@ already exists in the library.",bookName];
        }
        else {
            [libArray addObject:bookObject];
            additionResult = [NSString stringWithFormat: @"Book Name : %@ was added to the library.",bookName];
        }
   }
    
    return additionResult;
}
    

// ---------------------------------------------------------------------------------------------


//  removing book from library
-(NSString*)remFromLib{
    
    BOOL match = false;
    BOOL isJustCreated = false;
    if(!libArray){
        libArray = [[NSMutableArray alloc]init];
        isJustCreated = true;
    }
    
    NSString* removalResult = [[NSString alloc]init];
    
//      take book name from user
    NSLog(@"Enter name of the book to remove : ");
    char bookNameInC[50] = {0};
    scanf(" %[^\n]s",bookNameInC);
    NSString* bookName = [NSString stringWithFormat:@"%s",bookNameInC];
    
    
    
//    check if book name is valid
    
    if (isJustCreated) {
        removalResult = [NSString stringWithFormat:@"No book exists in the library hence cannot remove %@ book from library.",bookName];
        return removalResult;
    }
    else {
        
        Book* temp;
        for (int i=0; i<[libArray count]; i++) {
            temp = [libArray objectAtIndex:i];
            if([temp.bookName isEqualToString:bookName]){
                match = true;
                break;
            }
        }
        if (match) {
            
            if (temp.isIssued) {
                
                removalResult = [NSString stringWithFormat:@"The book is not available in the library for removal."];
                return removalResult;
                
            } else {
                
                
                [libArray removeObject:temp];
                removalResult = [NSString stringWithFormat:@" The book %@ was removed from the library.",bookName];
                return removalResult;
                
            }
        }
        else {
            removalResult = [NSString stringWithFormat:@"The book %@ does not exists in the library.", bookName];
            return removalResult;
        }
    }
}


// ---------------------------------------------------------------------------------------------


//      issuing a book to user
-(NSString*)issueBook:(NSString*)bookName toUser:(NSString*)userName {
    
    NSString* issueResult = [[NSString alloc]init];
    NSArray* userNameAsKeys;
    BOOL match = false;
    BOOL isLibraryJustCreated = false;
    BOOL userAlreadyHasABook = false;

    Book* bookObject;
    
    if(!libArray){
        libArray = [[NSMutableArray alloc]init];
        isLibraryJustCreated = true;
    }
    
    if (!userBookDict) {
        userBookDict = [[NSMutableDictionary alloc]init];
    }
    
    //      check if user already has a book issued
    
    userNameAsKeys = [userBookDict allKeys];
    for (int i = 0; i < [userNameAsKeys count]; i++) {
        if ([[userNameAsKeys objectAtIndex:i] isEqualToString:userName]) {
            userAlreadyHasABook = true;
            break;
        }
    }
    
    if (userAlreadyHasABook) {
        issueResult = [NSString stringWithFormat:@"Sorry %@! But you already have a book issued to you. Complete it first.", userName];
        return issueResult;
    }
    
    if (isLibraryJustCreated) {
        issueResult = [NSString stringWithFormat:@"Library currently does not have any books available for issuing."];
        return issueResult;
    } else {
        
        for (int i=0; i<[libArray count]; i++) {
            Book* temp =[libArray objectAtIndex:i];
            if([temp.bookName isEqualToString:bookName]){
                match = true;
                bookObject = temp;
                break;
            }
        }
        
        if (match) {
            
            if (bookObject.isIssued) {
                
                issueResult = [NSString stringWithFormat:@"Book unavailable! The book %@ is already issued to user %@",bookName, userName];
                return issueResult;
                
            } else {
                
                [userBookDict setObject:bookObject forKey:userName];
                issueResult = [NSString stringWithFormat:@"The book %@ is being issued to the user %@. Enjoy Reading!", bookObject.bookName, userName];
                bookObject.isIssued = true;
                return issueResult;
                
            }
        } else {
            
            issueResult = [NSString stringWithFormat:@"Sorry %@ ! The book %@ does not exists in the library.", userName, bookName];
            return issueResult;
        }
    }
}


// ---------------------------------------------------------------------------------------------


//      returning a book
-(NSString*) returnBook: (NSString*)bookName fromUser: (NSString*)userName {

    NSString* returnResult = [[NSString alloc]init];
    BOOL isLibraryJustCreated = false;
    BOOL isNoBookIssued = false;
    BOOL isValidUserAndBookCredentials = false;
    BOOL match = false;
    
    Book* bookObject;
    
    if(!libArray){
        libArray = [[NSMutableArray alloc]init];
        isLibraryJustCreated = true;
    }
    
    if (!userBookDict) {
        userBookDict = [[NSMutableDictionary alloc]init];
        isNoBookIssued = true;
    }
    
    if (isNoBookIssued) {
        returnResult = [NSString stringWithFormat:@"No books have been currently issued from the library. So, how can you return a book ?"];
        return returnResult;
    }
    
    if (isLibraryJustCreated) {
        returnResult = [NSString stringWithFormat:@"Library does not have any books. So it never issued anything hence how can you return a book ?"];
        return returnResult;
    } else {
        
        for (int i = 0; i < [libArray count]; i++) {
            Book* temp = [libArray objectAtIndex:i];
            if ([temp.bookName isEqualToString:bookName]) {
                match = true;
                bookObject = temp;
                break;
            }
        }
        
        if (!match) {
            returnResult = [NSString stringWithFormat:@"Such a book does not exists in library. Please enter a valid book name."];
            return returnResult;
        }
        
        if (match) {
            if (bookObject.isIssued) {
                for (int i=0; i<[userBookDict count]; i++) {
                    if ([[userBookDict objectForKey:userName] isEqualTo:bookObject]) {
                        isValidUserAndBookCredentials = true;
                    }
                }
            } else {
                returnResult = [NSString stringWithFormat:@"The book was not issued to anyone. Please try issuing a book before returning it."];
                return returnResult;
            }
        }
        
        if (isValidUserAndBookCredentials) {
            [userBookDict removeObjectForKey:userName];
            returnResult = [NSString stringWithFormat:@"The book %@ has been returned to the library by %@ . Hope you enjoyed it.",bookName, userName];
            bookObject.isIssued = false;
            return returnResult;
        } else {
            returnResult = [NSString stringWithFormat:@"Sorry %@! But the book %@ is not yours to be returned.", userName, bookName];
            return returnResult;
        }
    }
}


// ---------------------------------------------------------------------------------------------


//      check book availability
-(NSString*) checkBookAvailability: (NSString*)bookName {

    NSString* bookAvailabilityResult = [[NSString alloc]init];
    BOOL isLibraryJustCreated = false;
    BOOL isNoBookIssued = false;
    BOOL match = false;
    Book* bookObject;
    
    if(!libArray){
        libArray = [[NSMutableArray alloc]init];
        isLibraryJustCreated = true;
    }
    
    if (!userBookDict) {
        userBookDict = [[NSMutableDictionary alloc]init];
        isNoBookIssued = true;
    }
    
    if (isLibraryJustCreated) {
        bookAvailabilityResult = [NSString stringWithFormat:@"No books currently exist in the library."];
        return bookAvailabilityResult;
    }
    
    
    for (int i = 0; i <[libArray count]; i++) {
        Book* temp = [libArray objectAtIndex:i];
        if ([temp.bookName isEqualToString:bookName]) {
            match = true;
            bookObject = temp;
            break;
        }
    }
    
    if (match) {
        
        if (!bookObject.isIssued) {
            bookAvailabilityResult = [NSString stringWithFormat:@"YES, the book %@ is available in the library",bookName];
            return bookAvailabilityResult;
        } else {
            bookAvailabilityResult = [NSString stringWithFormat:@"NO, the book %@ is not available in the library", bookName];
            return bookAvailabilityResult;
        }
        
    } else {
        bookAvailabilityResult = [NSString stringWithFormat:@"The book %@ does not exists in the library.", bookName];
        return bookAvailabilityResult;
    }
}


// ---------------------------------------------------------------------------------------------


//      show all books collection in the library
-(void) showCollection {
    
    BOOL isLibraryJustCreated = false;
    
    if(!libArray){
        libArray = [[NSMutableArray alloc]init];
        isLibraryJustCreated = true;
    }
    
    if (isLibraryJustCreated) {
    
        NSLog(@"No books currently exist in the library");
    
    } else {
        
        if ([libArray count] == 0) {
            NSLog(@"All books have been removed from the library.");
        } else {
            
            NSLog(@"Displaying books collection in library below...");
            
            for (int i=0; i < [libArray count]; i++) {
                Book* temp = [libArray objectAtIndex:i];
                NSLog(@"%i. %@",i+1,temp.bookName);
            }
        }
    }
}


// ---------------------------------------------------------------------------------------------


@end
