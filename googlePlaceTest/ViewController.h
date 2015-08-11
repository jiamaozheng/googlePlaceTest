//
//  ViewController.h
//  googlePlaceTest
//
//  Created by Jiamao Zheng on 7/28/15.
//  Copyright (c) 2015 Emerge Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVPlaceSearchTextField.h"
#import "Autocomplete.h"
#import "AutoFillTableViewController.h"

@interface ViewController : UIViewController <PlaceSearchTextFieldDelegate,UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) AutoFillTableViewController *autoFillTableViewController;
@property (nonatomic, strong) Autocomplete *autocomplete;
@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *searchLocation;

@property (nonatomic, retain) IBOutlet UITextField *urlField;
@property (nonatomic, retain) UITableView *autocompleteTableView;
@property (nonatomic, strong) NSMutableArray *pastUrls;
@property (nonatomic, strong) NSMutableArray *autocompleteUrls;

- (IBAction)textDidChange:(id)textField;
- (IBAction)textEditBegin:(id)textField;

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring;

@end

