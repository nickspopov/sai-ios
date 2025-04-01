//
//  HomeScreenV2.swift
//  sai
//
//  Created by Николай Попов on 05.09.2023.
//

import SwiftUI
import UIKit
@_spi(Advanced) import SwiftUIIntrospect

struct HomeScreen: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @EnvironmentObject var navigationController: NavigationController
    
    @State var pageIndex = 0
    @State var bottomSheetY: CGFloat = SheetState.closed.topPosition
    @State var isSheetPresented = true
    
    @StateObject var viewModel: HomeScreenProvider
    var homeScreenTasksViewModel: HomeScreenTasksViewModel
    var homeScreenTripsViewModel: HomeScreenTripsViewModel
    
    init() {
        let _viewModel: HomeScreenProvider = HomeScreenProvider()
        let _homeScreenTasksViewModel = HomeScreenTasksViewModel(homeScreenProvider: _viewModel)
        let _homeScreenTripsViewModel = HomeScreenTripsViewModel(homeScreenProvider: _viewModel)
        self._viewModel = StateObject(wrappedValue: _viewModel)
        self.homeScreenTasksViewModel = _homeScreenTasksViewModel
        self.homeScreenTripsViewModel = _homeScreenTripsViewModel
    }
    
    var animatedProgress: CGFloat { SheetState.interpolateSheetTopPoisition(bottomSheetY) }
    
    var body: some View {
        VStack {
            AnimatedHeader(animationProgress: animatedProgress, selectedDate: $viewModel.selectedDate)
            Spacer()
                .sheet(isPresented: $isSheetPresented) {
                    sheetTuningAndHeightHandler
                    FiltersRow(activeIndex: $pageIndex)
                        .padding(.leading, UIScreen.main.bounds.width * 0.25)
                    Spacer()
                        .frame(height: 38)
                    AdaptivePagingScrollView(currentPageIndex: $pageIndex,
                                             itemsAmount: 3,
                                             itemScrollableSide: UIScreen.main.bounds.width,
                                             itemPadding: 0,
                                             visibleContentLength: UIScreen.main.bounds.width * 1.5) {
                        AllTab(navigationController: navigationController, homeScreenTripsViewModel: homeScreenTripsViewModel, homeScreenTasksViewModel: homeScreenTasksViewModel)
                        TasksTab(homeScreenTasksViewModel: homeScreenTasksViewModel)
                        ActivityTab(homeScreenTripsViewModel: homeScreenTripsViewModel)
                    }
                                             .interactiveDismissDisabled()
                                             .presentationDetents(SheetState.presentationDetents)
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
        .lifecycle(
            onWillDisappear: {isSheetPresented = false},
            onDidAppear: {isSheetPresented = true}
        )
    }
}

// MARK: - Preview
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
        ZStack(alignment: .bottom) {
            if(pageIndex == 0 ) {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.24, green: 0.24, blue: 0.24), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.74, green: 0.69, blue: 0.65), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            } else if pageIndex == 1 {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.74, green: 0.69, blue: 0.65), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.85, green: 0.85, blue: 0.85).opacity(0), location: 1.00),
                        Gradient.Stop(color: Color(red: 0.28, green: 0.25, blue: 0.31), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            } else if pageIndex == 2 {
                GeometryReader { geometry in
                    let chartHeight = geometry.size.height * 0.64
                    let chartWidth = geometry.size.width + 90
                    
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.26, green: 0.26, blue: 0.26), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.08, green: 0.08, blue: 0.08), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0),
                        endPoint: UnitPoint(x: 0.5, y: 1)
                    )
                    TripBackgroundShape()
                        .fill(.white)
                        .opacity(0.04)
                        .offset(y: geometry.size.height - chartHeight + 30)
                        .frame(width: chartWidth, height: chartHeight)
                }
            } else if pageIndex == 3 {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0, green: 0.27, blue: 0.98), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.07, green: 0.1, blue: 0.16), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
            }
        }
        .animation(.easeIn(duration: 0.35), value: pageIndex)
        .transition(.scale)
    }
}

// MARK: - Sheet height handler + Sheet tuning
extension HomeScreen {
    @ViewBuilder var sheetTuningAndHeightHandler: some View {
        VStack {
            EmptyView()
        }
        .introspect(.sheet, on: .iOS(.v16, .v17, .v18), customize: { (_sheet: UISheetPresentationController) in
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


// MARK: - Sheet calculations
fileprivate enum SheetState: CGFloat {
    case opened = 1.0
    case closed = 0.0
    
    var topPosition: CGFloat {
        switch self {
        case .opened:
            return 180.0
        case .closed:
            return SheetState.calculatedValues.topPosition
        }
    }
    
    static var presentationDetents: Set<PresentationDetent> {
        return [ .height(SheetState.calculatedValues.detent), .height(UIScreen.main.bounds.height - 123 - safeArea.top) ]
    }
    
    static func interpolateSheetTopPoisition(_ bottomSheetY: CGFloat) -> CGFloat {
        if (bottomSheetY < 0) {
            return 0
        }
        return bottomSheetY.interpolate([SheetState.opened.topPosition, SheetState.closed.topPosition], [SheetState.opened.rawValue, SheetState.closed.rawValue])
    }
    
    private static let safeArea: (bottom: CGFloat, top: CGFloat) = (bottom: 34, top: 50)
    
    private static var calculatedValues: (detent: CGFloat, topPosition: CGFloat) = {
        let headerHeight = 324.0
        let detent = UIScreen.main.bounds.height - headerHeight - safeArea.top - safeArea.bottom
        let topPosition = UIScreen.main.bounds.height - detent - 40
        
        return (detent: detent, topPosition: topPosition)
    }()
}
