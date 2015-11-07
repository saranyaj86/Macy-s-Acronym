//
//  ViewController.h
//  Acronym
//
//  Created by Saranya's Workstation on 11/6/15.
//  Copyright (c) 2015 Saranya's Workstation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchDisplayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate>

@property(nonatomic,retain)NSMutableArray *searchResults; //To store the search results

@end

