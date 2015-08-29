//
//  ViewController.m
//  Acronym
//
//  Created by Rachit on 8/28/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>
#import "ViewController.h"
#import "Acronym.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray *_fullForms;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.textField.delegate = self;
    self.lfTableView.delegate = self;
    self.lfTableView.dataSource = self;
    self.lfTableView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self search];
    return YES;
}

- (IBAction)search:(id)sender {
    [self search];
}

-(void)search
{
    if ([self.textField.text isEqualToString:@""])
    {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"No Acronym input" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [view show];
    }
    else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [Acronym search:self.textField.text result:^(NSArray *fullForms, NSError *error){
            if (fullForms == nil) {
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"No Acronym Found" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
                [view show];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            } else {
                _fullForms = fullForms;
                self.lfTableView.hidden = NO;
                [self.lfTableView reloadData];
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            }
            
        }];

    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_fullForms count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *MyIdentifier = @"MyIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text = [_fullForms[indexPath.row] objectForKey:@"lf"];
    return cell;

}

@end
