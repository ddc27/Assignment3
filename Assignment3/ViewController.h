//
//  ViewController.h
//  Assignment3
//
//  Created by David Evans on 2/5/13.
//  Copyright (c) 2013 DavidEvans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fruit.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) BOOL allSelected;

@property (nonatomic, strong) NSMutableArray * cart;

@property (nonatomic, weak) IBOutlet UITableView * cartView;

@property (nonatomic, weak) IBOutlet UIButton * select;

@property (nonatomic, weak) IBOutlet UIButton * fill;

@property (nonatomic, weak) IBOutlet UIButton * empty;

-(IBAction)selectAllOrNone:(id)sender;
-(IBAction)emptyCart:(id)sender;
-(IBAction)fillCart:(id)sender;

@end
