//
//  ViewController.m
//  SilentRunner
//
//  Created by Andrew Batutin on 12/12/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"
#import <SilentRunnerEngine/SilentRunnerEngine.h>

@interface ViewController ()
@property (nonatomic, strong) SRServer* serv;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SRServer enableLogging];
    [SRClientPool addClient:@[].mutableCopy forTag:@"NSMutableArray"];
    // register your app delegate to be callable from test server
    [SRClientPool addClient:[UIApplication sharedApplication].delegate forTag:@"app"];
    TestModel* model = [[TestModel alloc] init];
    [SRClientPool addClient:model forTag:@"TestModel"];
    self.serv = [SRServer serverWithURL:@"ws://localhost:9000/chat"  withErrorHandler:^(NSError * error) {
        [self.serv sendErrorMessage:error];
    }];
}


- (IBAction)testAction:(id)sender {
    [self.serv webSocket:self.serv.webSocket didReceiveMessage:@"hi"];
}

- (IBAction)runServer:(id)sender {
    [self.serv runServer:^(SRWebSocket* socket) {
        NSLog(@"server started");
    }];
}

- (IBAction)stopServer:(id)sender {
    [self.serv closeServer:^(SRWebSocket* socket) {
        NSLog(@"server stopped");
    }];
}


@end
