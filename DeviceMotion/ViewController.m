//
//  ViewController.m
//  DeviceMotion
//
//  Created by Love on 9/27/16.
//  Copyright © 2016 Love. All rights reserved.
//

#import "ViewController.h"
@import CoreMotion;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong,nonatomic)CMMotionManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[CMMotionManager alloc]init];
    
    self.imageView.image =[UIImage imageNamed:@"clownfish.jpg"];
    [self.manager startDeviceMotionUpdates];
    
    self.manager.accelerometerUpdateInterval = 0.01;
    
    ViewController* __weak weakSelf = self;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [self.manager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion *motionData, NSError *error) {
        
        double x= motionData.gravity.x;
        double y = motionData.gravity.y;
        //double z = motionData.gravity.z;
        
        double rotation = -atan2(x, -y);
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            weakSelf.imageView.transform = CGAffineTransformMakeRotation(rotation);
            
            
        }];
        
    }];
    
}





@end
