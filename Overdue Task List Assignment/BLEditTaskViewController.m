//
//  BLEditTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Bo Li Zhou on 9/2/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import "BLEditTaskViewController.h"
#import "BLDetailTaskViewController.h"

@interface BLEditTaskViewController ()

@end

@implementation BLEditTaskViewController

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
    self.textViewEditTaskDescrpt.delegate = self;
    self.textFieldEditTitle.delegate = self;
    self.textFieldEditTitle.text = self.taskTitle;
    self.labelCompletion.text = self.isComepleted;
    self.textViewEditTaskDescrpt.text = self.taskDescrpt;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.textViewEditTaskDescrpt resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [self.textFieldEditTitle resignFirstResponder];
        return NO;
    }
    return YES;
}

//#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    if ([segue.destinationViewController isKindOfClass:[BLMainViewController class]]) {
//        BLMainViewController *mainVC = segue.destinationViewController;
//        self.delegate = mainVC;
//    }
//}

#pragma mark - BarButton
- (IBAction)barButtonEditSave:(UIBarButtonItem *)sender {
    BLTaskObject *taskObject = [[BLTaskObject alloc] init];
    taskObject.taskTitle = self.textFieldEditTitle.text;
    taskObject.taskDescrpt = self.textViewEditTaskDescrpt.text;
    taskObject.isTaskCompleted = self.labelCompletion.text;
    NSDate *date = self.datePickerEditTask.date;
    taskObject.date = date;
    [self.objectForMethod updateTaskCompletion:taskObject forIndexPath:self.path];
    if (![taskObject.taskTitle length] || ![taskObject.taskDescrpt length]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The title/description is blank." delegate:nil cancelButtonTitle:@"Back" otherButtonTitles:nil, nil];
        [alertView show];
    } else [self.delegate didFinish];
    
}

- (IBAction)barButtonEditCancel:(UIBarButtonItem *)sender {
    [self.delegate didEditCancel];
}
@end
