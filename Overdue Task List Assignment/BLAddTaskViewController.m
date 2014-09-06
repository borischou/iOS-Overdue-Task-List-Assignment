//
//  BLAddTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Bo Li Zhou on 9/2/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import "BLAddTaskViewController.h"

@interface BLAddTaskViewController ()

@end

@implementation BLAddTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.textViewAddTaskDescrpt.delegate = self;
    self.textFieldAddTitle.delegate = self;
    self.labelAddCompletion.text = @"Undone";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.textViewAddTaskDescrpt resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [self.textFieldAddTitle resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - Helper Methods
- (BLTaskObject *)toTaskObject {
    BLTaskObject *taskObject = [[BLTaskObject alloc] init];
    taskObject.taskTitle = self.textFieldAddTitle.text;
    taskObject.taskDescrpt = self.textViewAddTaskDescrpt.text;
    taskObject.isTaskCompleted = @"NO";
    NSDate *date = self.datePickerAdd.date;
    taskObject.date = date;
    return taskObject;
}

- (IBAction)barButtonSave:(UIBarButtonItem *)sender {
    if (![self.textFieldAddTitle.text length] || ![self.textViewAddTaskDescrpt.text length]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Title/Task Description is blank." delegate:nil cancelButtonTitle:@"Back" otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        BLTaskObject *taskObject = [self toTaskObject];
        if (!taskObject) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"TaskObject is empty." delegate:nil cancelButtonTitle:@"Back" otherButtonTitles:nil, nil];
            [alertView show];
        } else {
            NSLog(@"Hello, here is the taskObject: %@", taskObject.isTaskCompleted);
            [self.delegate didAddTask:taskObject];
        }
    }
}

- (IBAction)barButtonCancel:(UIBarButtonItem *)sender {
    [self.delegate didCancel];
}

@end
