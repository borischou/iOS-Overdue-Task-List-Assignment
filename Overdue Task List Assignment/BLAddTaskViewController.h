//
//  BLAddTaskViewController.h
//  Overdue Task List Assignment
//
//  Created by Bo Li Zhou on 9/2/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BLAddTaskVCDelegate <NSObject>

@required

- (void)didAddTask:(BLTaskObject *)taskObject;
- (void)didCancel;

@end

@interface BLAddTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) id <BLAddTaskVCDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *textFieldAddTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelAddCompletion;
@property (strong, nonatomic) IBOutlet UITextView *textViewAddTaskDescrpt;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePickerAdd;
- (IBAction)barButtonSave:(UIBarButtonItem *)sender;
- (IBAction)barButtonCancel:(UIBarButtonItem *)sender;

@end
