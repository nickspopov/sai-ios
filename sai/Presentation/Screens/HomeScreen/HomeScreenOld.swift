//
//  HomeScreen.swift
//  sai
//
//  Created by Николай Попов on 23.08.2023.
//

import SwiftUI
import SwiftUIPager

struct HomeScreenOld: View {
    @EnvironmentObject var navigationController: NavigationController
    
    @StateObject var page: Page = .first()
    var items = Array(0..<4)
    
    @State var pageIndex = 0
    
    var body: some View {
        NavigationView {
            VStack{
                GeometryReader { geometry in
                    ScrollView(.vertical) {
                        Group {
                            header
                            Spacer()
                                .frame(height: 80)
                        }
                        dateView
                        Spacer()
                            .frame(height: 64)
                        filtersRow
                        Spacer()
                            .frame(height: 32)
//                        VStack {
                            
                            AdaptivePagingScrollView(currentPageIndex: $pageIndex,
                                                     itemsAmount: 1,
                                                     itemScrollableSide: geometry.size.width,
                                                     itemPadding: 0,
                                                     visibleContentLength: geometry.size.width,
                                                     orientation: .horizontal) {
                                allTab
                                    .frame(width: geometry.size.width)
                                allTab
                                    .frame(width: geometry.size.width)
//                                ForEach(onboardData.cards) { card in
//                                    GeometryReader { screen in
//                                        OnbardingCardView(card: card)
//                                            .rotation3DEffect(Angle(degrees: (Double(screen.frame(in: .global).minX) - 20) / -15),
//                                                              axis: (x: 0, y: 90.0, z: 0))
//
//                                            .scaleEffect(activePageIndex == onboardData.cards.firstIndex(of: card) ?? 0 ? 1.05 : 1)
//                                    }
//                                    .frame(width: self.itemWidth, height: 600)
//                                }
//                            }.frame(width: geometry.size.width, height: .infinity)
//                                .background(.blue)
                            
                            
//                            Pager(page: page,
//                                  data: items,
//                                  id: \.self,
//                                  content: { index in
//                                switch index {
//                                case 0: allTab
//                                default: Text("Not implemented for tab: \(index)")
//                                }
//                            })
//                            .frame(minHeight: 300, maxHeight: .infinity)
                        }
                    }
                }

            }
            .padding(.top, 36)
            .screenContainer()
        }
        .onChange(of: page.index, perform: { newValue in
            print("Page changed to \(newValue)")
        })
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct HomeScreenOld_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenOld()
    }
}

// MARK: - All tab
extension HomeScreenOld {
    var allTab: some View {
        VStack {
            CalendarWidget()
            CalendarWidget()
//            CalendarWidget()
//            CalendarWidget()
//            CalendarWidget()
//            CalendarWidget()
            
            Spacer()
        }
        
    }
}

// MARK: - FiltersRow
extension HomeScreenOld {
    var filtersRow: some View {
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


// MARK: - DatePicker
extension HomeScreenOld {
    var dateView: some View {
        VStack(alignment: .leading) {
            Text("Sep 3, 2023")
                .font(
                    Font.custom("Inter-SemiBold", size: 48)
                        .weight(.semibold)
                )
                .foregroundColor(.white)
            Typography("To access the summary for different days, just click on the date at the top.", .regular(.six))
                .foregroundColor(Color(red: 0.69, green: 0.68, blue: 0.68))
                .frame( alignment: .leading)
        }
        .padding(.leading, 16)
        .padding(.trailing, 32)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

// MARK: - Header
extension HomeScreenOld {
    var header: some View {
        HStack(alignment: .center) {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(Color(red: 55, green: 55, blue: 55))
            Spacer()
            HStack(alignment: .center, spacing: 16) {
                Typography("Community", .regular(.five))
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(Color(red: 0.32, green: 0.32, blue: 0.32))
            .cornerRadius(200)
        }
        .padding(.horizontal, 16)
    }
}



//
//  AdaptivePagingScrollView.swift
//  OnboardingAnimationOne
//
//  Created by Boris on 06.09.2022.
//

import SwiftUI

struct FrameModifier: ViewModifier {
    let contentLength: CGFloat
    let currentScrollOffset: CGFloat
    let orientation: Orientation

    init (contentLength: CGFloat,
          visibleContentLength: CGFloat,
          currentScrollOffset: CGFloat,
          orientation: Orientation) {
        self.contentLength = contentLength
        self.currentScrollOffset = currentScrollOffset
        self.orientation = orientation
    }

    func body(content: Content) -> some View {
        switch orientation {
        case .horizontal:
            let offset = contentLength / 2
            return content
                .frame(width: contentLength)
                .offset(x: self.currentScrollOffset + offset, y: 0)
        case .vertical:
            return content
                .frame(height: contentLength)
                .offset(x: 0, y: self.currentScrollOffset)
        }
    }
}

extension View {
    func frameModifier(_ contentLength: CGFloat,
                       _ currentScrollOffset: CGFloat,
                       _ orientation: Orientation) -> some View {
        modifier(
            FrameModifier(
                contentLength: contentLength,
                visibleContentLength: contentLength,
                currentScrollOffset: currentScrollOffset,
                orientation: orientation
            )
        )
    }
}

enum Orientation {
    case horizontal, vertical
}

struct AdaptivePagingScrollView: View {
    
    private let items: [AnyView]
    private let itemPadding: CGFloat
    private let itemSpacing: CGFloat
    private let itemScrollableSide: CGFloat
    private let itemsAmount: Int
    private let visibleContentLength: CGFloat
    
    private let initialOffset: CGFloat
    private let scrollDampingFactor: CGFloat = 0.66
    private let orientation: Orientation
    
    @Binding var currentPageIndex: Int
    
    @State private var currentScrollOffset: CGFloat = 0
    @State private var gestureDragOffset: CGFloat = 0
    
    private func countOffset(for pageIndex: Int) -> CGFloat {
        
        let activePageOffset = CGFloat(pageIndex) * (itemScrollableSide + itemPadding)
        
        return initialOffset - activePageOffset
    }
    
    private func countPageIndex(for offset: CGFloat) -> Int {
        
        guard itemsAmount > 0 else { return 0 }
        
        let offset = countLogicalOffset(offset)
        let floatIndex = (offset)/(itemScrollableSide + itemPadding)
        
        var index = Int(round(floatIndex))
        if max(index, 0) > itemsAmount {
            index = itemsAmount
        }
        
        return min(max(index, 0), itemsAmount - 1)
    }
    
    private func countCurrentScrollOffset() -> CGFloat {
        return countOffset(for: currentPageIndex) + gestureDragOffset
    }
    
    private func countLogicalOffset(_ trueOffset: CGFloat) -> CGFloat {
        return (trueOffset-initialOffset) * -1.0
    }
    
    private func changeFocus() {
        withAnimation {
            currentScrollOffset = countOffset(for: currentPageIndex)
        }
    }
    
    init<A: View>(currentPageIndex: Binding<Int>,
                  itemsAmount: Int,
                  itemScrollableSide: CGFloat,
                  itemPadding: CGFloat,
                  visibleContentLength: CGFloat,
                  orientation: Orientation,
                  @ViewBuilder content: () -> A) {
        
        let views = content()
        self.items = [AnyView(views)]
        
        self._currentPageIndex = currentPageIndex
        
        self.itemsAmount = itemsAmount
        self.itemSpacing = itemPadding
        self.itemScrollableSide = itemScrollableSide
        self.itemPadding = itemPadding
        self.visibleContentLength = visibleContentLength
        self.orientation = orientation
        
        let itemRemain = (visibleContentLength-itemScrollableSide-2*itemPadding)/2
        self.initialOffset = itemRemain + itemPadding
    }
    
    @ViewBuilder
    func contentView() -> some View {
        switch orientation {
        case .horizontal:
            HStack(alignment: .center, spacing: itemSpacing) {
                ForEach(items.indices, id: \.self) { itemIndex in
                    items[itemIndex].frame(width: itemScrollableSide)
                }
            }
        case .vertical:
            VStack(alignment: .leading, spacing: itemSpacing) {
                ForEach(items.indices, id: \.self) { itemIndex in
                    items[itemIndex].frame(height: itemScrollableSide)
                }
            }
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            contentView()
        }
        .onAppear {
            currentScrollOffset = countOffset(for: currentPageIndex)
        }
        .background(Color.black.opacity(0.00001)) // hack - this allows gesture recognizing even when background is transparent
        .frameModifier(visibleContentLength, currentScrollOffset, orientation)
        .highPriorityGesture(
            DragGesture(minimumDistance: 30, coordinateSpace: .local)
                .onChanged { value in
                    switch orientation {
                    case .horizontal:
                        gestureDragOffset = value.translation.width
                    case .vertical:
                        gestureDragOffset = value.translation.height
                    }
                    currentScrollOffset = countCurrentScrollOffset()
                }
                .onEnded { value in
                    let cleanOffset: CGFloat
                    switch orientation {
                    case .horizontal:
                        cleanOffset = (value.predictedEndTranslation.width - gestureDragOffset)
                    case .vertical:
                        cleanOffset = (value.predictedEndTranslation.height - gestureDragOffset)
                    }
                    let velocityDiff = cleanOffset * scrollDampingFactor
                    
                    var newPageIndex = countPageIndex(for: currentScrollOffset + velocityDiff)
                    
                    let currentItemOffset = CGFloat(currentPageIndex) * (itemScrollableSide + itemPadding)
                    
                    if currentScrollOffset < -(currentItemOffset),
                       newPageIndex == currentPageIndex {
                        newPageIndex += 1
                    }
                    
                    gestureDragOffset = 0
                    
                    withAnimation(.interpolatingSpring(mass: 0.1,
                                                       stiffness: 20,
                                                       damping: 1.5,
                                                       initialVelocity: 0)) {
                        self.currentPageIndex = newPageIndex
                        self.currentScrollOffset = self.countCurrentScrollOffset()
                    }
                }
        )
        .contentShape(Rectangle())
        .onChange(of: currentPageIndex, perform: { _ in changeFocus() })
    }
}




//extension View {
//    func delaysTouches(for duration: TimeInterval = 0.25, onTap action: @escaping () -> Void = {}) -> some View {
//        modifier(DelaysTouches(duration: duration, action: action))
//    }
//}
//
//fileprivate struct DelaysTouches: ViewModifier {
//    @State private var disabled = false
//    @State private var touchDownDate: Date? = nil
//
//    var duration: TimeInterval
//    var action: () -> Void
//
//    func body(content: Content) -> some View {
//        Button(action: action) {
//            content
//        }
//        .buttonStyle(DelaysTouchesButtonStyle(disabled: $disabled, duration: duration, touchDownDate: $touchDownDate))
//        .disabled(disabled)
//    }
//}
//
//fileprivate struct DelaysTouchesButtonStyle: ButtonStyle {
//    @Binding var disabled: Bool
//    var duration: TimeInterval
//    @Binding var touchDownDate: Date?
//
//    func makeBody(configuration: Configuration) -> some View {
//        configuration.label
//            .onChange(of: configuration.isPressed, perform: handleIsPressed)
//    }
//
//    private func handleIsPressed(isPressed: Bool) {
//        if isPressed {
//            let date = Date()
//            touchDownDate = date
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + max(duration, 0)) {
//                if date == touchDownDate {
//                    disabled = true
//
//                    DispatchQueue.main.async {
//                        disabled = false
//                    }
//                }
//            }
//        } else {
//            touchDownDate = nil
//            disabled = false
//        }
//    }
//}
