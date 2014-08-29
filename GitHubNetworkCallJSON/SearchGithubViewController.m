//
//  SearchGithubViewController.m
//  GitHubNetworkCallJSON
//
//  Created by Victor  Adu on 8/27/14.
//  Copyright (c) 2014 Victor  Adu. All rights reserved.
//

#import "SearchGithubViewController.h"
#import "NetworkController.h"
#import "Repository.h"

@interface SearchGithubViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView2;
@property (strong, nonatomic) NSArray *repositories;

@end

@implementation SearchGithubViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{

    return self.repositories.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repoDetails" forIndexPath:indexPath];
    
    Repository *repo = self.repositories[indexPath.row];
    cell.textLabel.text = repo.name;
    
    return cell;
}


#pragma SearchBar Button implemented

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    NSString *searchTermGitHub = searchBar.text;
    [searchBar resignFirstResponder];
    
    [NetworkController fetchRepositoriesForSearchTerm:searchTermGitHub withCompletion:^(NSArray *repositories, NSString *errorDescription) {
        self.repositories = repositories;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView2 reloadData];
        }];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
