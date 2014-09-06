//
//  BLDetailTaskViewController.m
//  Overdue Task List Assignment
//
//  Created by Bo Li Zhou on 9/2/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import "BLDetailTaskViewController.h"

@interface BLDetailTaskViewController ()

@end

@implementation BLDetailTaskViewController

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
    [self initialData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper method
-(void)initialData {
    NSMutableArray *currentTaskObjects = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASKOBJECT] mutableCopy];
    BLTaskObject *taskObject = [self.objectForMethod dictionaryForTaskObject:[currentTaskObjects objectAtIndex:self.path.row]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd G 'at' HH:mm:ss zzz"];
    self.labelDetailTime.text = [formatter stringFromDate:taskObject.date];
    self.labelDetailTitle.text = taskObject.taskTitle;
    self.labelDetailCompletion.text = taskObject.isTaskCompleted;
    self.textViewDetail.text = taskObject.taskDescrpt;
    //self.navigationController.delegate = self;
}

#pragma mark - BLEditTaskDelegate
-(void)didFinish {
    [self initialData];
    //[self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)didEditCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.destinationViewController isKindOfClass:[BLEditTaskViewController class]]) {
        BLEditTaskViewController *editTaskVC = segue.destinationViewController;
        editTaskVC.delegate = self;
        NSMutableArray *newPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASKOBJECT] mutableCopy];
        BLTaskObject *taskObject = [self.objectForMethod dictionaryForTaskObject:[newPropertyList objectAtIndex:self.path.row]];
        editTaskVC.taskTitle = taskObject.taskTitle;
        editTaskVC.taskDescrpt = taskObject.taskDescrpt;
        editTaskVC.date = taskObject.date;
        editTaskVC.isComepleted = taskObject.isTaskCompleted;
        editTaskVC.path = self.path;
        if (!editTaskVC.objectForMethod) {
            editTaskVC.objectForMethod = [[BLTaskObject alloc] init];
        }
    }
}

- (IBAction)btnEdit:(UIBarButtonItem *)sender {
}

@end
