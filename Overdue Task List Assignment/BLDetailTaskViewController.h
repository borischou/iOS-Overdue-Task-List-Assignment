//
//  BLDetailTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Bo Li Zhou on 9/2/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLEditTaskViewController.h"
#import "BLMainViewController.h"

@interface BLDetailTaskViewController : UIViewController <BLEditTaskViewDelegate, UINavigationControllerDelegate>

- (IBAction)btnEdit:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UILabel *labelDetailTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelDetailCompletion;
@property (strong, nonatomic) IBOutlet UILabel *labelDetailTime;
@property (strong, nonatomic) IBOutlet UITextView *textViewDetail;

@property (strong, nonatomic) NSString *taskTitle;
@property (strong, nonatomic) NSString *taskDescrpt;
@property (strong, nonatomic) NSString *isTaskCompleted;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSIndexPath *path;

@property (strong, nonatomic) BLTaskObject *objectForMethod;

@end
