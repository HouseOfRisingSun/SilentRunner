//
//  ViewController.m
//  SilentRunner
//
//  Created by andrew batutin on 12/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "ViewController.h"
#import "SilentRunner-Test-Swift.h"


@interface ViewController ()
@property (nonatomic, strong) SRRunnerServer* serv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.serv = [[SRRunnerServer alloc] initWithPath:@"http://localhost:9000/chat"];
    //[self.serv start];
    [SRRunnerServer test];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
