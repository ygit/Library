//
//  main.m
//  Library
//
//  Created by MacBook Pro on 17/07/14.
//  Copyright (c) 2014 Inspeero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lib.h"
#import "Book.h"
#import "User.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
//        create objects
        Lib* library = [[Lib alloc]init];
        Book* book = [[Book alloc]init];
        User* user = [[User alloc]init];
        
//        initialize variables
        char cInput[50] = {0};
        NSString* stringInput;
        int input = 0;
        int exitInput = 0;
        char bookName[50] = {0};
        char userName[25] = {0};
        NSString* result;
                                                                
//        main program loop
        NSLog(@"Welcome to the Library Management System!");
        
        do {
            
            NSLog(@"What do you want to perform ?");
            NSLog(@"1. Add book to library");
            NSLog(@"2. Remove book from library");
            NSLog(@"3. Issue boook from library");
            NSLog(@"4. Return book to library");
            NSLog(@"5. Check book availability");
            NSLog(@"6. Show all books in library");
            NSLog(@"7. Exit from library");
            scanf("%s",cInput);
            
            stringInput = [NSString stringWithFormat:@" %s",cInput];
            
            input = [stringInput intValue];
            
            if (!input) {
                
                NSLog(@"Please enter a valid integer only.");
            
            } else {
        
            

                    switch (input) {
                
//                  add book to library
                        case 1:
                            result = [library addToLib];
                            NSLog(@"%@",result);
                            break;
                    
                    
//                  remove book from library
                        case 2:
                            result = [library remFromLib];
                            NSLog(@"%@",result);
                            break;

                    
//                  issue book to user
                        case 3:
                            
                            NSLog(@"Enter book name you want to issue : ");
                            scanf(" %[^\n]s", bookName);
                            book.bookName = [NSString stringWithFormat:@"%s",bookName];
                            
                            NSLog(@"Enter user name : ");
                            scanf( " %[^\n]s",userName);
                            user.userName = [NSString stringWithFormat:@"%s",userName];
                            
                            result = [library issueBook: book.bookName  toUser: user.userName ];
                            NSLog(@"%@",result);
                            
                            break;

                    
//                  return book to library
                        case 4:
                            
                            NSLog(@"Enter book name you want to return : ");
                            scanf(" %[^\n]s", bookName);
                            book.bookName = [NSString stringWithFormat:@"%s", bookName];
                            
                            NSLog(@"Enter user name : ");
                            scanf(" %[^\n]s",userName);
                            user.userName = [NSString stringWithFormat:@"%s", userName];
                            
                            result = [library returnBook: book.bookName fromUser: user.userName];
                            NSLog(@"%@",result);
                            
                            break;
                    
                    
//                  check book availability
                        case 5:
                            
                            NSLog(@"Enter book name for checking its availability : ");
                            scanf(" %[^\n]s",bookName);
                            book.bookName = [NSString stringWithFormat:@"%s",bookName];
                            
                            result = [library checkBookAvailability:book.bookName];
                            NSLog(@"%@",result);
                            
                            break;

                    
//                  show all books in library
                        case 6:
                    
                            [library showCollection];
                            
                            break;
                    
                    
//                  exit from library
                        case 7:
                    
                            NSLog(@"Are you sure you want to exit the library ?");
                            NSLog(@"1. YES, exit the library.");
                            NSLog(@"2. NO, return to library..");
                            scanf("%d",&exitInput);
                            
                            switch (exitInput) {
                                case 1:
                                    NSLog(@"Exiting the library, goodbye..");
                                    return 0;
                                case 2:
                                    NSLog(@"Returning to the library..");
                                    break;
                                default:
                                    NSLog(@"Please enter a valid number.");
                                    break;
                            }
                            
                            break;

                    
                    
//          default option
                default:
                    NSLog(@"Please enter a valid integer option between 1 to 7.");
                    break;
            }
            }
            
        } while (true);
        
    }
    return 0;
}

