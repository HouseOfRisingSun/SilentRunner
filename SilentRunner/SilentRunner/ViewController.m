//
//  ViewController.m
//  SilentRunner
//
//  Created by andrew batutin on 12/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "ViewController.h"
#import "SRServer.h"

@interface ViewController ()
@property (nonatomic, strong) SRServer* serv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.serv = [SRServer serverWithURL:@"https://www.foo.com" withMessageHandler:^(NSString * msg) {
        
    } withErrorHandler:^(NSError * error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)testAction:(id)sender {
    [self.serv webSocket:self.serv.webSocket didReceiveMessage:@"hi"];
}

@end
