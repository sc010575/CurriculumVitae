//
//  ConnectivityHandler.swift
//  CurriculumVitae
//
//  Created by Suman Chatterjee on 22/08/2019.
//  Copyright © 2019 Suman Chatterjee. All rights reserved.
//

import Foundation
import Reachability

enum ConnectionType {
    case wifi
    case cellular
    case offline
}



protocol ConnectivityListener: class {
    func ConnectivityStatusDidChanged()
}


class ConnectivityHandler: ErrorTrigger {

    private var reachability: Reachability?
    private let notificationCenter: NotificationCenter

    init(reachability: Reachability? = Reachability(),
        notificationCenter: NotificationCenter = NotificationCenter.default) {
        self.reachability = reachability
        self.notificationCenter = notificationCenter
    }

    var listeners = [ConnectivityListener]()
    private var previousConnectionType: ConnectionType = .offline
    private var currentConnecType: ConnectionType = .offline


    deinit {
        reachability?.stopNotifier()
    }

    var connectionType: ConnectionType {
        guard let reachability = reachability else { return .offline }
        switch reachability.connection {
        case .wifi:
            return .wifi
        case .cellular:
            return .cellular
        case .none:
            return .offline
        }
    }
    func addListener(listener: ConnectivityListener) {
        listeners.append(listener)
    }

    func removeListener(listener: ConnectivityListener) {
        listeners = listeners.filter { $0 !== listener }
    }

    func startNotifier() {
//        reachability?.whenReachable = { reachability in
//            if reachability.connection == .wifi {
//                print("Reachable via WiFi")
//            } else {
//                print("Reachable via Cellular")
//            }
//
//            self.listeners.forEach {
//                $0.ConnectivityStatusDidChanged()
//            }
//        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        let a = [10, 110, 1110]
        a.forEach {
            let b =  formatter.string(from: NSNumber(value: $0))?.components(separatedBy: " ")
            Log.verbose("b is \(b ?? [])")
        }
        
        reachability?.whenUnreachable = { _ in
            self.displayErrorMessage(error: ErrorMessage.fallbackLostConnectionError)
            self.previousConnectionType = .offline
        }
        notificationCenter.addObserver(
            self,
            selector: #selector(reachabilityChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        try? reachability?.startNotifier()
    }

    @objc func reachabilityChanged(_ note: Notification) {
        guard let reachability = note.object as? Reachability else { return }
        self.reachability = reachability
        currentConnecType = connectionType
        if currentConnecType != previousConnectionType {
            previousConnectionType = currentConnecType
            self.listeners.forEach {
                $0.ConnectivityStatusDidChanged()
            }
        }

    }
}

struct ErrorMessage {
    var title: String
    var message: String
}

// MARK: - Fallbacks
extension ErrorMessage {

    static var fallbackLostConnectionError: ErrorMessage {
        return ErrorMessage(title: "Lost connection", message: "We appear to have lost connection. Please check your network settings and try again.")
    }

    static var fallbackGenericErrorMessage: ErrorMessage {
        return ErrorMessage(title: "There seems to be a problem", message: "We are experiencing a few problems. Please try refreshing the app, or come back in a couple of minutes.")
    }
}

protocol ErrorTrigger {
    func displayErrorMessage(error: ErrorMessage)
}

extension ErrorTrigger {
    func displayErrorMessage(error: ErrorMessage) {
        guard
            let appDelegate = UIApplication.shared.delegate as? AppDelegate,
            let rootVC = appDelegate.window?.rootViewController as? UINavigationController
            else {
                print("⚠️ Could not retrieve TabBar to present error message.")
                return
        }

        let alert = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okAction)
        rootVC.present(alert, animated: true, completion: nil)
    }
}
