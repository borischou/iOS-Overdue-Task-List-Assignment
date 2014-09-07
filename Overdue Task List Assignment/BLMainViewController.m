//
//  BLMainViewController.m
//  Overdue Task List Assignment
//
//  Created by Bo Li Zhou on 9/2/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import "BLMainViewController.h"

@interface BLMainViewController ()

@end

@implementation BLMainViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"[viewDidLoad] loaded");
    self.objectForMethod = [[BLTaskObject alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.showsReorderControl = NO;
    [self updateCurrentTaskObjects];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"[viewDidAppear] loaded");
    [self.tableView reloadData];
}

#pragma mark - Helper Methods
-(void)updateCurrentTaskObjects {
    if (![self.addedTaskObjects count]) {
        self.addedTaskObjects = [[NSMutableArray alloc] init];
    }
    for (NSDictionary *dictionary in [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASKOBJECT]) {
        [self.addedTaskObjects addObject:[self.objectForMethod dictionaryForTaskObject:dictionary]];
    }
}

-(BOOL)isLargerThanCurrentDate:(NSDate *)date {
    NSDate *nowTime = [[NSDate alloc] init];
    if (date.timeIntervalSince1970 > nowTime.timeIntervalSince1970) {
        return YES;
    } else return NO;
}

#pragma mark - BLAddTaskVCDelegate
-(void)didAddTask:(BLTaskObject *)taskObject {
    [self.addedTaskObjects addObject:taskObject];
    NSMutableArray *taskObjectAsPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASKOBJECT] mutableCopy];
    [taskObjectAsPropertyList addObject:[self.objectForMethod taskObjectForDictionary:taskObject]];
    if (!taskObjectAsPropertyList) taskObjectAsPropertyList = [[NSMutableArray alloc] init];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectAsPropertyList forKey:ADDED_TASKOBJECT];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}

-(void)didCancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[BLAddTaskViewController class]]) {
        if ([sender isKindOfClass:[UIBarButtonItem class]]) {
            BLAddTaskViewController *addTaskVC = segue.destinationViewController;
            addTaskVC.delegate = self;
        }
    } else if ([segue.destinationViewController isKindOfClass:[BLDetailTaskViewController class]]) {
        BLDetailTaskViewController *detailTaskVC = segue.destinationViewController;
        NSIndexPath *path = sender;
        detailTaskVC.path = path;
        if (!detailTaskVC.objectForMethod) {
            detailTaskVC.objectForMethod = [[BLTaskObject alloc] init];
        }
    }
}

#pragma mark - UITableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.addedTaskObjects count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath];
    NSMutableArray *currentPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASKOBJECT] mutableCopy];
    BLTaskObject *taskObject = [self.objectForMethod dictionaryForTaskObject:[currentPropertyList objectAtIndex:indexPath.row]];
    cell.textLabel.text = taskObject.taskTitle;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd G 'at' HH:mm:ss zzz"];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:taskObject.date];
    if ([taskObject.isTaskCompleted isEqualToString:@"YES"]) {
        cell.backgroundColor = [UIColor greenColor];
    } else if ([self isLargerThanCurrentDate:taskObject.date]) {
        cell.backgroundColor = [UIColor yellowColor];
    } else cell.backgroundColor = [UIColor redColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.addedTaskObjects removeObjectAtIndex:indexPath.row];
        NSMutableArray *newAddedTaskDictionaries = [[NSMutableArray alloc] init];
        for (BLTaskObject *taskObject in self.addedTaskObjects) {
            [newAddedTaskDictionaries addObject:[self.objectForMethod taskObjectForDictionary:taskObject]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newAddedTaskDictionaries forKey:ADDED_TASKOBJECT];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"toDetailTaskVC" sender:indexPath];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *currentPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASKOBJECT] mutableCopy];
    NSDictionary *dictionary = [currentPropertyList objectAtIndex:indexPath.row];
    BLTaskObject *taskObject = [self.objectForMethod dictionaryForTaskObject:dictionary];
    if ([taskObject.isTaskCompleted isEqualToString:@"YES"]) {
        taskObject.isTaskCompleted = @"NO";
    } else taskObject.isTaskCompleted = @"YES";
    [self.objectForMethod updateTaskCompletion:taskObject forIndexPath:indexPath];
    [self.tableView reloadData];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSMutableArray *newTaskObjectAsPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASKOBJECT] mutableCopy];
    NSDictionary *sourceItemForDestination = [newTaskObjectAsPropertyList objectAtIndex:sourceIndexPath.row];
    [newTaskObjectAsPropertyList removeObjectAtIndex:sourceIndexPath.row];
    [newTaskObjectAsPropertyList insertObject:sourceItemForDestination atIndex:destinationIndexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectAsPropertyList forKey:ADDED_TASKOBJECT];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
}

-(IBAction)btnAdd:(UIBarButtonItem *)sender {
}

- (IBAction)btnReorder:(UIBarButtonItem *)sender {
    if (self.showsReorderControl) {
        self.showsReorderControl = NO;
        [self.tableView setEditing:NO animated:YES];
        sender.title = @"Reorder";
    } else {
        [self.tableView setEditing:YES animated:YES];
        self.showsReorderControl = YES;
        sender.title = @"Done";
    }
}
@end
