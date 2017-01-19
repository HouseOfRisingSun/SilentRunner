//
//  SRRunnerServer.swift
//  SilentRunner
//
//  Created by andrew batutin on 12/23/16.
//  Copyright © 2016 HomeOfRisingSun. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Result
import SocketRocket

@objc
public class SRRunnerServer: NSObject, SRWebSocketDelegate {
    
    typealias SRRunnerServerValue = String
    
    public func webSocket(_ webSocket: SRWebSocket!, didReceiveMessage message: Any!) {
         self.observer.send(value:message as! String)
    }
    
    
    public func webSocket(_ webSocket: SRWebSocket!, didFailWithError message: Error!) {
        self.observer.send(error: AnyError(message))
    }

    
    let server : SRWebSocket
    private var observer : Observer<SRRunnerServerValue, AnyError>!
    private var disposable : Disposable!
    var signal : Signal<String, AnyError>!
    
    init?(path:String) {
        guard let url = URL(string:path) else{
            return nil
        }
        guard let server = SRWebSocket(url:url) else{
            return nil
        }
        self.server = server
        super.init()
        self.server.delegate = self
        self.createMessageSignal()
    }
    
    func createMessageSignal(){
        
        let signalProducer : SignalProducer<String, AnyError> =   SignalProducer{ (observer, disposable) -> () in
            self.observer = observer
            self.disposable = disposable
        }
        
        signalProducer.startWithSignal { (theSignal, disposable) in
            self.signal = theSignal
        }
    }
    
    func start(){
        self.server.open()
    }
}

