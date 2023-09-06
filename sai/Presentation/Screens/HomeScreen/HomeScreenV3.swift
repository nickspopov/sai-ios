//
//  HomeScreenV2.swift
//  sai
//
//  Created by Николай Попов on 05.09.2023.
//

import SwiftUI

fileprivate let closedPosition: CGFloat = UIScreen.main.bounds.height - 360
fileprivate let openedPosition: CGFloat = 180.0


struct HomeScreenV3: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @State var trueValue = true
    @State var pageIndex = 0
    @State var bottomSheetY: CGFloat = closedPosition {
        didSet {
            animatedProgress = calcHeaderAnimationProgress()
        }
    }
    
    @State var animatedProgress: CGFloat = 0.0
    
    func calcHeaderAnimationProgress() -> CGFloat {
        return bottomSheetY.interpolate([openedPosition, closedPosition], [1.0, 0.0])
    }
    
    var body: some View {
        VStack {
            AnimatedHeader(animationProgress: $animatedProgress)
            Spacer()
                .sheet(isPresented: $trueValue) {
                    VStack {
                        EmptyView()
                    }
                    .screenPositionYChangePreference { _bottomSheetY in
                        print("closedPosition: \(closedPosition), openedPosition: \(openedPosition), _bottomSheetY: \(bottomSheetY)")
                        withAnimation {
                            self.bottomSheetY = _bottomSheetY
                        }
                    }
                    AdaptivePagingScrollView(currentPageIndex: $pageIndex,
                                             itemsAmount: 1,
                                             itemScrollableSide: UIScreen.main.bounds.width,
                                             itemPadding: 0,
                                             visibleContentLength: UIScreen.main.bounds.width,
                                             orientation: .horizontal) {
                        ScrollView {
                            VStack {
                                ForEach(0..<100) { index in
                                    Text("Row \(index)")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(.background)
                                        .cornerRadius(10)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                                        .padding()
                                        .onTapGesture {
                                            print("Tap: \(index)")
                                        }
                                }
                            }
                        }
                        .frame(width: 375)
                        ScrollView {
                            VStack {
                                ForEach(0..<100) { index in
                                    Text("Row \(index)")
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(.background)
                                        .cornerRadius(10)
                                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
                                        .padding()
                                        .onTapGesture {
                                            print("Tap 222: \(index)")
                                        }
                                }
                            }
                        }
                        .frame(width: 375)
                    }
                     .tabViewStyle(PageTabViewStyle())
                     .interactiveDismissDisabled()
                     .presentationDetents([.height(300), .height(UIScreen.main.bounds.height - 180)])
                     .presentationBackgroundInteraction(.enabled)
                     .presentationDragIndicator(.hidden)
                     .presentationBackground {
                         Color.clear
                     }
                     .presentationCompactAdaptation(.none)
                }
        }
        .screenContainer()
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Filters Row
fileprivate struct FiltersRow: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                filterItem(name: "All", isActive: true, onPress: {})
                filterItem(name: "Tasks", isActive: false, onPress: {})
                filterItem(name: "Activity", isActive: false, onPress: {})
                filterItem(name: "Meals", isActive: false, onPress: {})
            }
        }
    }
    
    func filterItem(name:String, isActive: Bool, onPress: @escaping () -> Void) -> some View {
        return HStack(alignment: .center, spacing: 16) {
            Typography(name, .regular(.five))
                .foregroundColor(isActive ? .black : .white)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(isActive ? .white : Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(200)
        .onTapGesture {
            onPress()
        }
    }
}

struct HomeScreenV3_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenV3()
            .preferredColorScheme(.dark)
    }
}
