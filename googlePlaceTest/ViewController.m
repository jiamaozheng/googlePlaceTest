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
    [super viewDidLoad];
    
    self.searchLocation.placeSearchDelegate                 = self;
    self.searchLocation.strApiKey                           = @"AIzaSyCDi2dklT-95tEHqYoE7Tklwzn3eJP-MtM";
    self.searchLocation.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    self.searchLocation.autoCompleteShouldHideOnSelection   = YES;
    self.searchLocation.maximumNumberOfAutoCompleteRows     = 5;
    // Do any additional setup after loading the view, typically from a nib.
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
