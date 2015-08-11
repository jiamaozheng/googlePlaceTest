//
//  ViewController.m
//  googlePlaceTest
//
//  Created by Jiamao Zheng on 7/28/15.
//  Copyright (c) 2015 Emerge Media. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad {
    
    //http://www.raywenderlich.com/336/auto-complete-tutorial-for-ios-how-to-auto-complete-with-custom-values
    
    [super viewDidLoad];
    self.pastUrls = [[NSMutableArray alloc] initWithObjects:@"www.google.com", @"www.uvm.edu",@"www.yahoo.com", @"www.uchicago.edu", @"www.news.com", nil];
    self.autocompleteUrls = [[NSMutableArray alloc] init];
    
    self.autocompleteTableView = [[UITableView alloc] initWithFrame:
                                  CGRectMake(self.urlField.frame.origin.x, self.urlField.frame.origin.y + 30, self.urlField.frame.size.width, 150) style:UITableViewStylePlain];
    self.autocompleteTableView.delegate = self;
    self.autocompleteTableView.dataSource = self;
    self.autocompleteTableView.scrollEnabled = YES;
//    [self.autocompleteTableView setSeparatorStyle:UITableViewCellStyleDefault];
    self.autocompleteTableView.hidden = YES;
    
    
    self.urlField.delegate = self;
    [self.view addSubview:self.autocompleteTableView];
   
    
    self.searchLocation.placeSearchDelegate                 = self;
    self.searchLocation.strApiKey                           = @"AIzaSyCDi2dklT-95tEHqYoE7Tklwzn3eJP-MtM";
    self.searchLocation.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    self.searchLocation.autoCompleteShouldHideOnSelection   = YES;
    self.searchLocation.maximumNumberOfAutoCompleteRows     = 5;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [self.autocompleteUrls removeAllObjects];
    for(NSString *curString in self.pastUrls) {
        NSRange substringRange = [curString rangeOfString:substring];
        if (substringRange.location == 0) {
            [self.autocompleteUrls addObject:curString];
        }
    }
    [self.autocompleteTableView reloadData];
}


#pragma mark UITextFieldDelegate methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.autocompleteTableView.hidden = NO;
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section {
    return self.autocompleteUrls.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
      UITableViewCell *cell = nil;
    
//    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake
//                             (0, cell.frame.size.height-1,
//                              cell.frame.size.width, 1)];
//    [separatorView setBackgroundColor:[UIColor lightGrayColor]];
//    [separatorView setAlpha:0.8f];
//    
//    [cell addSubview:separatorView];
    
  
    static NSString *AutoCompleteRowIdentifier = @"AutoCompleteRowIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:AutoCompleteRowIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCompleteRowIdentifier];
    }
    
    cell.textLabel.text = [self.autocompleteUrls objectAtIndex:indexPath.row];
//    
//    cell.contentView.layer.borderColor = [[UIColor grayColor] CGColor];
//    cell.contentView.layer.borderWidth = 1;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == tableView.numberOfSections - 1) {
        return [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == tableView.numberOfSections - 1) {
        return 1;
    }
    return 0;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    self.urlField.text = selectedCell.textLabel.text;
    tableView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    
    //Optional Properties
    self.searchLocation.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    self.searchLocation.autoCompleteBoldFontName = @"HelveticaNeue";
    self.searchLocation.autoCompleteTableCornerRadius=0.0;
    self.searchLocation.autoCompleteRowHeight=35;
    self.searchLocation.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    self.searchLocation.autoCompleteFontSize=14;
    self.searchLocation.autoCompleteTableBorderWidth=1.0;
    self.searchLocation.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    self.searchLocation.autoCompleteShouldHideOnSelection=YES;
    self.searchLocation.autoCompleteShouldHideClosingKeyboard=YES;
    self.searchLocation.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
//    self.searchLocation.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-self.searchLocation.frame.size.width)*0.5, self.searchLocation.frame.size.height+100.0, self.searchLocation.frame.size.width, 200.0);
}

#pragma mark - Place search Textfield Delegates
-(void)placeSearchResponseForSelectedPlace:(NSMutableDictionary*)responseDict{
    [self.view endEditing:YES];
    NSLog(@"%@",responseDict);
    
    NSDictionary *aDictLocation=[[[responseDict objectForKey:@"result"] objectForKey:@"geometry"] objectForKey:@"location"];
    NSLog(@"SELECTED ADDRESS :%@",aDictLocation);
}
-(void)placeSearchWillShowResult{
    
}
-(void)placeSearchWillHideResult{
    
}
-(void)placeSearchResultCell:(UITableViewCell *)cell withPlaceObject:(PlaceObject *)placeObject atIndex:(NSInteger)index{
    if(index%2==0){
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}

@end
