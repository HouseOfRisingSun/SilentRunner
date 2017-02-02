//
//  SRSandbox.swift
//  SilentRunner
//
//  Created by andrew batutin on 1/19/17.
//  Copyright © 2017 HomeOfRisingSun. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result

enum SRParseErrors : Error{
    case DataParseError
}

var serverS:SRRunnerServer?

func testData(){
    guard let server = SRRunnerServer(path: "http://localhost:9000/chat") else{
        return
    }
    serverS = server
    let signal = server.signal!
    
    signal.attemptMap(parseMessage).observeResult{ (result) in
        switch result{
        case .failure(let error):
            print(error)
        case .success(let msg):
            print(msg)
        }
    }
    
    server.start()
    
}

func parseMessage( message:String ) throws -> [String:Any] {
    guard let data = message.data(using: .utf8) else {
        throw SRParseErrors.DataParseError
    }
    
    guard let result = try JSONSerialization.jsonObject(with: data) as? [String:Any] else{
        throw SRParseErrors.DataParseError
    }
    
    
    
    return result
    
}

//func createModel ( dict:[String:Any] ) throws ->

