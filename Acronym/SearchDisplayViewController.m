//
//  ViewController.m
//  Acronym
//
//  Created by Saranya's Workstation on 11/6/15.
//  Copyright (c) 2015 Saranya's Workstation. All rights reserved.
//

#import "SearchDisplayViewController.h"



typedef void (^AcronymCompletionHandler) (NSArray *responseObject, NSError *error);
static NSString * reuseIdentifier =   @"cell";

@interface SearchDisplayViewController ()

@end

@implementation SearchDisplayViewController

- (void)viewDidLoad {
    self.searchResults = [NSMutableArray array];
    [super viewDidLoad];

}

#pragma mark tableView delagates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.searchResults.count;
}

/**
 Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
 Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
 */

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    cell.textLabel.text = self.searchResults[indexPath.row][@"lf"];
    return cell;
}

#pragma mark searchDislayController  delegate

/**
   return YES to reload table. called when search string/option changes. convenience methods on top UISearchBar delegate methods
 */

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString{
    
    [self filterContentForSearchText:searchString];
     
    
    return YES;
}


/**
 Method Name :filterContentForSearchText  - use to send the search text to API and reload the search  resultant data into the table.
 
 @param - searchText
*/
- (void)filterContentForSearchText:(NSString*)searchText
{

    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    AcronymWebRequestManager *manager = [AcronymWebRequestManager sharedManger];
    
    [manager requestDatawithParams:[NSDictionary dictionaryWithObject:searchText forKey:@"sf"] completion: ^(NSArray *responseObject, NSError *error){
        
        
        [self.searchResults removeAllObjects];

          for (NSDictionary *dictionaryitem in responseObject){
                [self.searchResults addObjectsFromArray:dictionaryitem[@"lfs"]];
            }
        
        [self.searchDisplayController.searchResultsTableView reloadData];
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];

    }];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
