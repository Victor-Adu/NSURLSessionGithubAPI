//
//  ViewController.m
//  GitHubNetworkCallJSON
//
//  Created by Victor  Adu on 8/25/14.
//  Copyright (c) 2014 Victor  Adu. All rights reserved.
//

#import "ViewController.h"
#import "Repository.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong, nonatomic) NSArray *githubRepoSearch;  //Setting an array to a 'weak' property caused our app not to show

//Repository *gitHubRepo;

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.githubRepoSearch = @[@"Repositories"];
    
//    [self.tableView reloadData];
    
}

//UITableViewDataSource Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section; {
    return self.githubRepoSearch.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"githubRepoCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.githubRepoSearch[indexPath.row];
    
    return cell;
}

//UITableViewDelegate Method
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"showRepoDetails" sender:self];
}

//-----------------------------///////////////
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0){
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
