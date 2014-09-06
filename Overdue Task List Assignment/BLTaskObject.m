//
//  BLTaskObject.m
//  Overdue Task List Assignment
//
//  Created by Bo Li Zhou on 9/2/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import "BLTaskObject.h"

@implementation BLTaskObject

-(BLTaskObject *)dictionaryForTaskObject:(NSDictionary *)dictionary {
    BLTaskObject *taskObject = [[BLTaskObject alloc] init];
    taskObject.taskTitle = dictionary[TASK_TITLE];
    taskObject.taskDescrpt = dictionary[TASK_DESCRIPTION];
    taskObject.date = dictionary[TASK_DATE];
    taskObject.isTaskCompleted = dictionary[COMPLETION_STATUS];
    return taskObject;
}

-(NSDictionary *)taskObjectForDictionary:(BLTaskObject *)taskObject {
    NSString *completionStatus = [NSString stringWithFormat:@"%@", taskObject.isTaskCompleted];
    NSDictionary *dictionary = @{TASK_TITLE:taskObject.taskTitle, TASK_DESCRIPTION:taskObject.taskDescrpt, COMPLETION_STATUS:completionStatus, TASK_DATE:taskObject.date};
    return dictionary;
}

-(void)updateTaskCompletion:(BLTaskObject *)taskObject forIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *newPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASKOBJECT] mutableCopy];
    [newPropertyList removeObjectAtIndex:indexPath.row];
    [newPropertyList insertObject:[self taskObjectForDictionary:taskObject] atIndex:indexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:newPropertyList forKey:ADDED_TASKOBJECT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



@end
