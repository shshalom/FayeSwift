//
//  FayeClientDelegate.swift
//  Pods
//
//  Created by Haris Amin on 2/20/16.
//
//

import Foundation

public enum subscriptionError: ErrorType {
    case error(subscription: String, error: String)
}

// MARK: FayeClientDelegate Protocol
public protocol FayeClientDelegate: class {
  func messageReceived(client:FayeClient, messageDict: NSDictionary, channel: String)
  func pongReceived(client:FayeClient)
  func connectedToServer(client:FayeClient)
  func disconnectedFromServer(client:FayeClient)
  func connectionFailed(client:FayeClient)
  func didSubscribeToChannel(client:FayeClient, channel:String)
  func didUnsubscribeFromChannel(client:FayeClient, channel:String)
  func subscriptionFailedWithError(client:FayeClient, error:subscriptionError)
  func fayeClientError(client:FayeClient, error:NSError)
}

public extension FayeClientDelegate {
  func messageReceived(client:FayeClient, messageDict: NSDictionary, channel: String){}
  func pongReceived(client:FayeClient){}
  func connectedToServer(client:FayeClient){}
  func disconnectedFromServer(client:FayeClient){}
  func connectionFailed(client:FayeClient){}
  func didSubscribeToChannel(client:FayeClient, channel:String){}
  func didUnsubscribeFromChannel(client:FayeClient, channel:String){}
  func subscriptionFailedWithError(client:FayeClient, error:subscriptionError){}
  func fayeClientError(client:FayeClient, error:NSError){}
}
