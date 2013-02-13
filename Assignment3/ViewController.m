//
//  ViewController.m
//  Assignment3
//
//  Created by David Evans on 2/5/13.
//  Copyright (c) 2013 DavidEvans. All rights reserved.
//

#import "ViewController.h"
#import "Assignment3DetailViewController.h"
#import "Fruit.h"

@interface ViewController ()

@end

@implementation ViewController

void populateCart(id anyObject){
    for(int i = 0; i < 50; i++){
        NSString * fruitName = [NSString stringWithFormat:@"Banana %d", i];
        
        if((i % 10) == 0){
            fruitName = [NSString stringWithFormat:@"Free Banana %d", i];
        }
        
        Fruit * anonFruit = [[Fruit alloc] initWithName:fruitName andColor:@"Yellow" andShape:@"Curved"];
        anonFruit.url = @"http://en.m.wikipedia.org/wiki/Banana";
        [anyObject addObject:anonFruit];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Dan's Banana Stand";
    
    _allSelected = NO;
    _cart = [NSMutableArray arrayWithCapacity:0];
    populateCart(_cart);
    _fill.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark IBActions

-(IBAction)selectAllOrNone:(id)sender
{
    _allSelected = !_allSelected;
    if(_allSelected){
        [_select setTitle:@"Select None" forState:UIControlStateNormal];
    } else {
        [_select setTitle:@"Select All" forState:UIControlStateNormal];
    }
    [_cartView reloadData];
}

//Should remove all of the fruit in the cart.
-(IBAction)emptyCart:(id)sender
{
    [_cart removeAllObjects];
    _allSelected = NO;
    [_select setTitle:@"Select All" forState:UIControlStateNormal];
    _select.hidden = YES;
    _empty.hidden = YES;
    _fill.hidden = NO;
    [_cartView reloadData];
}

//should add 50 bananas to the cart and display them!
-(IBAction)fillCart:(id)sender
{
    populateCart(_cart);
    _select.hidden = NO;
    _empty.hidden = NO;
    _fill.hidden = YES;
    [_cartView reloadData];
}



#pragma mark UITableView dataSource and delegate methods

-(int) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Fruit";
}

-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([_cart count] == 0){
        return 1;
    }
    
    return [_cart count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"TableViewCell"];
    }
    
    if([_cart count] == 0){
        cell.textLabel.text = @"No Fruit in Cart";
        cell.detailTextLabel.text = @"";
        
    } else {
        Fruit * tempFruit = [_cart objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [tempFruit name];
        cell.detailTextLabel.text = [tempFruit color];
        
        if(_allSelected){
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fruit * selectedFruit = [_cart objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Assignment3DetailViewController * detailView = [[Assignment3DetailViewController alloc] initWithNibName:@"Assignment3DetailViewController" bundle:nil];
    
    detailView.title = selectedFruit.name;
    detailView.url = selectedFruit.url;
    
    [self.navigationController pushViewController:detailView animated:YES];
}

@end