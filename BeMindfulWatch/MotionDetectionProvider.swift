//
//  MotionDetectionProvider.swift
//  BeMindfulWatch
//
//  Created by Martin Karlik on 06/04/2023.
//

import Foundation
import CoreMotion
import WatchKit

class MotionDetectionProvider: MotionDetectionDelegate {
    
    var motionManager: CMMotionManager
    var startQuaternion: CMQuaternion?
    var startTime: TimeInterval?
    
    init() {
        motionManager = CMMotionManager()
    }
    
    func monitorRotationRate() {
        
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { [weak self] motion, error in
                guard let motion = motion, error == nil, let self = self else {
                    print("*** Motion Error: \(error!)")
                    return
                }
                
                
                if let startQuaternion = self.startQuaternion,
                   let startTime = self.startTime,
                    motion.timestamp - startTime < 1.0 {
                    
                    let currentQuaternion = motion.attitude.quaternion
                    let angle = self.angleBetweenQuaternions(startQuaternion, currentQuaternion)
                    
                    if angle < -2.0 {
                        print("Rotated by 180 degrees within one second")
                        WKInterfaceDevice.current().play(.notification)
                        self.startQuaternion = nil
                        self.startTime = nil
                    }
                } else {
                    self.startQuaternion = motion.attitude.quaternion
                    self.startTime = motion.timestamp
                }
                
            }
        } else {
            print("*** Device Unavailable")
        }
    }
    
    func angleBetweenQuaternions(_ q1: CMQuaternion, _ q2: CMQuaternion) -> Double {
        let dotProduct = q1.x*q2.x + q1.y*q2.y + q1.z*q2.z + q1.w*q2.w
        let angle = 2 * acos(abs(dotProduct))
        
        // Get the cross product to determine the direction of the rotation
        let w = q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z
        let x = q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y
        let y = q1.w * q2.y - q1.x * q2.z + q1.y * q2.w + q1.z * q2.x
        let z = q1.w * q2.z + q1.x * q2.y - q1.y * q2.x + q1.z * q2.w
        let crossProduct = CMQuaternion(x: x, y: y, z: z, w: w)
        
        let direction = crossProduct.y >= 0 ? 1.0 : -1.0
        return direction * angle
    }

}
