//
//  BLEditTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Bo Li Zhou on 9/2/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol BLEditTaskViewDelegate <NSObject>

@optional
-(void)didFinish;
-(void)didEditCancel;

@end

@interface BLEditTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) id <BLEditTaskViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UILabel *labelCompletion;
@property (strong, nonatomic) IBOutlet UITextField *textFieldEditTitle;
@property (strong, nonatomic) IBOutlet UITextView *textViewEditTaskDescrpt;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePickerEditTask;

- (IBAction)barButtonEditSave:(UIBarButtonItem *)sender;
- (IBAction)barButtonEditCancel:(UIBarButtonItem *)sender;

@property (strong, nonatomic) NSString *taskTitle;
@property (strong, nonatomic) NSString *taskDescrpt;
@property (strong, nonatomic) NSString *isComepleted;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSIndexPath *path;

@property (strong, nonatomic) BLTaskObject *objectForMethod;

@end
