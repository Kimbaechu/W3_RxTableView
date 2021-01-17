//
//  AppDelegate.swift
//  RxTableViewPractice
//
//  Created by Beomcheol Kwon on 2021/01/12.
//

import UIKit
import RxFlow
import RxSwift
import RxCocoa

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let disposeBag = DisposeBag()
    var window: UIWindow?
    let appCoordinator = FlowCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard let window = self.window else { return false }
        
        self.appCoordinator.rx.willNavigate.subscribe(onNext: { flow, step in
            NSLog("@@@ did willNavigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)
        
        self.appCoordinator.rx.didNavigate.subscribe(onNext: { flow, step in
            NSLog("did navigate to flow=\(flow) and step=\(step)")
        }).disposed(by: self.disposeBag)
        
        let appFlow = AppFlow.shared
        
        self.appCoordinator.coordinate(flow: appFlow, with: AppStepper.shared)
        
        Flows.use(appFlow, when: .created) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
            
       
        }
        
        return true
    }





}

