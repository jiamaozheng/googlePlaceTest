//
//  ViewController.h
//  googlePlaceTest
//
//  Created by Jiamao Zheng on 7/28/15.
//  Copyright (c) 2015 Emerge Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVPlaceSearchTextField.h"

@interface ViewController : UIViewController <PlaceSearchTextFieldDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *searchLocation;


@end

