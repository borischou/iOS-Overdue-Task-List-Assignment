//
//  BLTaskObject.h
//  Overdue Task List Assignment
//
//  Created by Bo Li Zhou on 9/2/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLTaskObject : NSObject

@property (strong, nonatomic) NSString *taskTitle;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *taskDescrpt;
@property (strong, nonatomic) NSString *isTaskCompleted;

-(BLTaskObject *)dictionaryForTaskObject:(NSDictionary *)dictionary;
-(NSDictionary *)taskObjectForDictionary:(BLTaskObject *)taskObject;
-(void)updateTaskCompletion:(BLTaskObject *)taskObject forIndexPath:(NSIndexPath *)indexPath;

@end
