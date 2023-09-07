//
//  HomeScreenV2.swift
//  sai
//
//  Created by Николай Попов on 05.09.2023.
//

import SwiftUI
import UIKit
import Combine
@_spi(Advanced) import SwiftUIIntrospect

fileprivate let closedPosition: CGFloat = UIScreen.main.bounds.height - 460
fileprivate let openedPosition: CGFloat = 180.0


struct HomeScreen: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @EnvironmentObject var navigationController: NavigationController
    
    @State var pageIndex = 0
    @State var bottomSheetY: CGFloat = closedPosition
    @State var isSheetPresented = true
    
    var animatedProgress: CGFloat {
        if (bottomSheetY < 0) {
            return 0
        }
        return bottomSheetY.interpolate([openedPosition, closedPosition], [1.0, 0.0])
    }
    
    var body: some View {
        VStack {
            AnimatedHeader(animationProgress: animatedProgress)
            Spacer()
                .sheet(isPresented: $isSheetPresented) {
                    sheetTuningAndHeightHandler
                    FiltersRow(activeIndex: $pageIndex)
                    Spacer()
                        .frame(height: 38)
                    AdaptivePagingScrollView(currentPageIndex: $pageIndex,
                                             itemsAmount: 1,
                                             itemScrollableSide: UIScreen.main.bounds.width,
                                             itemPadding: 0,
                                             visibleContentLength: UIScreen.main.bounds.width) {
                        AllTab(navigationController: navigationController)
                        TasksTab()
                    }
                                             .interactiveDismissDisabled()
                                             .presentationDetents([.height(400), .height(UIScreen.main.bounds.height - 160)])
                                             .presentationBackgroundInteraction(.enabled)
                                             .presentationDragIndicator(.hidden)
                                             .presentationBackground(.clear)
                                             .presentationCornerRadius(0)
                }
        }
        .padding(.top, safeAreaInsets.top)
        .screenContainer(
            background: bgGradient
        )
        .ignoresSafeArea(.all)
        .toolbar(.hidden, for: .navigationBar)
        .onWillDisappear {
            isSheetPresented = false
        }
        .onAppear {
            isSheetPresented = true
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(NavigationController())
            .preferredColorScheme(.dark)
    }
}

// MARK: - Background
extension HomeScreen {
    @ViewBuilder var bgGradient: some View {
        VStack {
            if(pageIndex == 0) {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.74, green: 0.69, blue: 0.65), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0), location: 1.00),
                        Gradient.Stop(color: Color(red: 0.28, green: 0.25, blue: 0.31), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            } else {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.03, green: 0.82, blue: 0.78), location: 0.00),
                        Gradient.Stop(color: Color(red: 0, green: 0.2, blue: 0.19), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            }
        }
        .animation(.easeIn(duration: 0.2), value: pageIndex)
    }
}

// MARK: - Sheet height handler + Sheet tuning
extension HomeScreen {
    @ViewBuilder var sheetTuningAndHeightHandler: some View {
        VStack {
            EmptyView()
        }
        .introspect(.sheet, on: .iOS(.v16, .v17), customize: { (_sheet: UISheetPresentationController) in
            _sheet.containerView.map { _view in
                _view.subviews.forEach { _subView in
                    _subView.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0)
                }
            }
        })
        .screenPositionYChangePreference { _bottomSheetY in
            withAnimation {
                self.bottomSheetY = _bottomSheetY
            }
        }
    }
}
