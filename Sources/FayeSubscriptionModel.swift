//
//  FayeSubscriptionModel.swift
//  Pods
//
//  Created by Shams Ahmed on 25/04/2016.
//
//

import Foundation
import SwiftyJSON

public enum FayeSubscriptionModelError: ErrorType {
    case ConversationError
    case ClientIdNotValid
}

// MARK:
// MARK: FayeSubscriptionModel

///  Subscription Model
public class FayeSubscriptionModel {
    
    /// Subscription URL
    public let subscription: String
    
    /// Channel type for request
    public let channel: BayeuxChannel
    
    /// Uniqle client id for socket
    public var clientId: String?
    
    public var connectionExtension:[String:AnyObject]?
    
    /// Model must conform to Hashable
    public var hashValue: Int {
        return subscription.hashValue
    }
    
    // MARK:
    // MARK: Init
    
    public init(subscription: String, channel: BayeuxChannel=BayeuxChannel.Subscribe, clientId: String?) {
        self.subscription = subscription
        self.channel      = channel
        self.clientId     = clientId
    }
    
    // MARK:
    // MARK: JSON
    
    ///  Return Json string from model
    public func jsonString() throws -> String {
        do {
            guard let model = try JSON(toDictionary()).rawString() else {
                throw FayeSubscriptionModelError.ConversationError
            }
            
            return model
        } catch {
            throw FayeSubscriptionModelError.ClientIdNotValid
        }
    }
    
    // MARK:
    // MARK: Helper
    
    ///  Create dictionary of model object, Subclasses should override method to return custom model
    public func toDictionary() throws -> [String: AnyObject] {
        guard let clientId = clientId else {
            throw FayeSubscriptionModelError.ClientIdNotValid
        }
        
        var dict:Dictionary<String,AnyObject> = [Bayeux.Channel.rawValue: channel.rawValue,
                    Bayeux.ClientId.rawValue: clientId,
                    Bayeux.Subscription.rawValue: subscription]
        
        if let ext = self.connectionExtension {
            dict[Bayeux.Extension.rawValue] = ext
        }
        
        return dict
    }
}

// MARK: 
// MARK: Description

extension FayeSubscriptionModel: CustomStringConvertible {
    
    public var description: String {
        return "FayeSubscriptionModel: \(try? self.toDictionary())"
    }
}

// MARK:
// MARK: Equatable

public func ==(lhs: FayeSubscriptionModel, rhs: FayeSubscriptionModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
}
