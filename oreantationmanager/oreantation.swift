//
//  oreantation.swift
//  Horror Game
//
//  Created by Habishek B on 22/06/25.
//
import UIKit

struct OrientationManager {
    static func forceLandscape() {
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        // iOS 16+ fix
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let rootVC = windowScene.windows.first?.rootViewController {
            rootVC.setNeedsUpdateOfSupportedInterfaceOrientations()
        }
    }
}
