//
//  InitialViewController.m
//  Pocket Resume
//
//  Created by Joshua Alvarado on 8/18/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *appliedJobsButton;
@property (weak, nonatomic) IBOutlet UIButton *myApplicationButton;
@property (strong, nonatomic) NSArray *imageArray;

@end

@implementation InitialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self generateRandomBackground];
}

-(void)generateRandomBackground
{
    UIImage *image1 = [UIImage imageNamed:@"background1.png"];
    UIImage *image2 = [UIImage imageNamed:@"pageController1.png"];
    UIImage *image3 = [UIImage imageNamed:@"pageController3.png"];
    UIImage *image4 = [UIImage imageNamed:@"background4.png"];
    
    _imageArray = @[image1, image2, image3, image4];
    
    int index = arc4random_uniform(4);
    
    self.backgroundImageView.image = self.imageArray[index];
}


@end
