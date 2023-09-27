//
//  WillDisapearHandler.swift
//  sai
//
//  Created by Николай Попов on 10.09.2023.
//

import Foundation
import SwiftUI

struct LifecycleHandler: UIViewControllerRepresentable {
    func makeCoordinator() -> LifecycleHandler.Coordinator {
        Coordinator(
            onWillDisappear: onWillDisappear,
            onWillAppear: onWillAppear,
            onDidDisappear: onDidDisappear,
            onDidAppear: onDidAppear
        )
    }
    
    let onWillDisappear: (() -> Void)?
    let onWillAppear: (() -> Void)?
    let onDidDisappear: (() -> Void)?
    let onDidAppear: (() -> Void)?
    
    init(onWillDisappear: (() -> Void)? = nil, onWillAppear: (() -> Void)? = nil, onDidDisappear: (() -> Void)? = nil, onDidAppear: (() -> Void)? = nil) {
        self.onWillDisappear = onWillDisappear
        self.onWillAppear = onWillAppear
        self.onDidDisappear = onDidDisappear
        self.onDidAppear = onDidAppear
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<LifecycleHandler>) -> UIViewController {
        context.coordinator
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<LifecycleHandler>) {
    }
    
    typealias UIViewControllerType = UIViewController
    
    class Coordinator: UIViewController {
        let onWillDisappear: (() -> Void)?
        let onWillAppear: (() -> Void)?
        let onDidDisappear: (() -> Void)?
        let onDidAppear: (() -> Void)?
        
        init(onWillDisappear: (() -> Void)?, onWillAppear: (() -> Void)? = nil, onDidDisappear: (() -> Void)? = nil, onDidAppear: (() -> Void)? = nil) {
            self.onWillDisappear = onWillDisappear
            self.onWillAppear = onWillAppear
            self.onDidDisappear = onDidDisappear
            self.onDidAppear = onDidAppear
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            onWillAppear?()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            onDidAppear?()
        }
        
        override func viewDidDisappear(_ animated: Bool) {
            super.viewDidDisappear(animated)
            onDidDisappear?()
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            onWillDisappear?()
        }
    }
}

struct LifecycleModifier: ViewModifier {
    let onWillDisappear: (() -> Void)?
    let onWillAppear: (() -> Void)?
    let onDidDisappear: (() -> Void)?
    let onDidAppear: (() -> Void)?
    
    init(onWillDisappear: (() -> Void)? = nil, onWillAppear: (() -> Void)? = nil, onDidDisappear: (() -> Void)? = nil, onDidAppear: (() -> Void)? = nil) {
        self.onWillDisappear = onWillDisappear
        self.onWillAppear = onWillAppear
        self.onDidDisappear = onDidDisappear
        self.onDidAppear = onDidAppear
    }
    
    func body(content: Content) -> some View {
        content
            .background(LifecycleHandler(onWillDisappear: onWillDisappear, onWillAppear: onWillAppear, onDidDisappear: onDidDisappear, onDidAppear: onDidAppear))
    }
}
