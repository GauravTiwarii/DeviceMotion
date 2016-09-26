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

@property(strong,nonatomic)NSArray *images;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[CMMotionManager alloc]init];
    
    
    self.images = @[[UIImage imageNamed:@"abstract.jpg"],[UIImage imageNamed:@"sample.jpg"],[UIImage imageNamed:@"clownfish.jpg"],[UIImage imageNamed:@"glass.jpg"]];
    [self chooseImage:0.0];
    
    [self.manager startDeviceMotionUpdates];
    
    self.manager.accelerometerUpdateInterval = 0.01;
    
    ViewController* __weak weakSelf = self;
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    CMAttitudeReferenceFrame frame = CMAttitudeReferenceFrameXArbitraryCorrectedZVertical;
    
    [self.manager startDeviceMotionUpdatesUsingReferenceFrame:frame toQueue:queue withHandler:^(CMDeviceMotion *motionData, NSError *error) {
        
        double yaw = motionData.attitude.yaw;

        
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
                    weakSelf.imageView.transform = CGAffineTransformMakeRotation(yaw);
                    
                    [self chooseImage:yaw];
                    
                }];
                
            }];

    
    
    
//    You do this part when reference Frame is not the part of concern
//   // [self.manager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion *motionData, NSError *error) {
//        
//        double x= motionData.gravity.x;
//        double y = motionData.gravity.y;
//        //double z = motionData.gravity.z;
//        
//        double rotation = -atan2(x, -y);
//        
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            
//            weakSelf.imageView.transform = CGAffineTransformMakeRotation(rotation);
//            
//            
//        }];
//        
//    }];
    
}


-(void)chooseImage:(double)yaw{
    
    if(yaw<=M_PI_4){
        self.imageView= self.images[0];
    }
    else if(yaw>=-3.0*M_PI_4){
        self.imageView.image = self.images[1];
    }
    else {
        if(yaw<=3.0*M_PI_4){
            
            self.imageView.image = self.images[3];
        }
        else{
            self.imageView.image = self.images[2];
        }
    }
}


@end
