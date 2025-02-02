//
//  NetworkMonitor.swift
//  SSMartEcom
//
//  Created by siva chitran p on 02/02/25.
//


import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    private var isConnected: Bool = false
    private var continuation: CheckedContinuation<Bool, Never>?
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            let status = path.status == .satisfied
            self?.isConnected = status
            self?.continuation?.resume(returning: status)
            self?.continuation = nil
        }
        monitor.start(queue: queue)
    }
    
    func checkConnectivity() async -> Bool {
        if isConnected { return true }
        
        return await withCheckedContinuation { continuation in
            self.continuation = continuation
        }
    }
}