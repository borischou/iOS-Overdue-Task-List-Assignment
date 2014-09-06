//
//  BLMainViewController.h
//  Overdue Task List Assignment
//
//  Created by Bo Li Zhou on 9/2/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLAddTaskViewController.h"
#import "BLDetailTaskViewController.h"

@interface BLMainViewController : UIViewController <BLAddTaskVCDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *addedTaskObjects;
@property (strong, nonatomic) BLTaskObject *objectForMethod;
@property (nonatomic) BOOL showsReorderControl;

-(void)updateCurrentTaskObjects;
-(IBAction)btnAdd:(UIBarButtonItem *)sender;
-(IBAction)btnReorder:(UIBarButtonItem *)sender;

@end
