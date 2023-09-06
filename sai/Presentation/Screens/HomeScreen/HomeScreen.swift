//
//  HomeScreen.swift
//  sai
//
//  Created by Николай Попов on 05.09.2023.
//

import SwiftUI
import Combine
@_spi(Advanced) import SwiftUIIntrospect


class ScrollViewDelegate: NSObject, UIScrollViewDelegate {
    
    public var scrollPosition = PassthroughSubject<Double, Never>()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        scrollPosition.send(scrollView.contentOffset.y)
    }
}

struct HomeScreen: View {
    
    @Weak var uiScrollView: UIScrollView?
    
    let scrollViewDelegate: ScrollViewDelegate = ScrollViewDelegate()
    
    @State var scrollPosition: Double = 0.0
    
    @State var cancellables: Set<AnyCancellable> = []

    func addDelegateToScrollView() {
        self.uiScrollView?.delegate = scrollViewDelegate
    }
    
    func getHeaderHeight() -> CGFloat {
        let val = scrollPosition.interpolated(fromLowerBound: 0.0, fromUpperBound: 350, toLowerBound: 200, toUpperBound: 30)
        if val < 0 {
            return 0
        }
        return val
    }
    
    func getHeaderPadding() -> CGFloat {
        let val = scrollPosition.interpolated(fromLowerBound: 0.0, fromUpperBound: 350, toLowerBound: 350, toUpperBound: 30)
        if val < 0 {
            return 0
        }
        return val
    }
    
    
    
    var body: some View {
//        NavigationView {
            HStack {
                ZStack(alignment: .topTrailing) {
                    VStack{
                        Group {
                            Spacer()
                                .frame(height: 54)
                            Header()
                            Spacer()
                                .frame(height: 80)
                            DateView()
                            Spacer()
                                .frame(height: 64)
                        }
                    }
                    .frame(height: getHeaderHeight())
                    VStack {
                        FiltersRow()
                        ScrollView(.vertical) {
                            CalendarWidget()
                            CalendarWidget()
                            CalendarWidget()
                            CalendarWidget()
                            CalendarWidget()
                            CalendarWidget()
                            CalendarWidget()
                            CalendarWidget()
                        }
                        .introspect(.scrollView, on: .iOS(.v16, .v17)) { _scrollView in
                            if self.uiScrollView == nil {
                                self.uiScrollView = _scrollView
                                addDelegateToScrollView()
                            }
                        }
                    }
                    .padding(.top, getHeaderPadding())
                }
            }
            .onAppear() {
                scrollViewDelegate.scrollPosition
                    .map({ v in
                        return v
                    })
                    .sink { value in
                        self.scrollPosition = value
                    }
                    .store(in: &cancellables)
            }
            .screenContainer()
            .toolbar(.hidden, for: .navigationBar)
//        }.toolbar(.hidden, for: .navigationBar)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
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


// MARK: - DateView
fileprivate struct DateView: View {
    var body: some View {
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
fileprivate struct Header: View {
    var body: some View {
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


extension FloatingPoint {
  /// Allows mapping between reverse ranges, which are illegal to construct (e.g. `10..<0`).
  func interpolated(
    fromLowerBound: Self,
    fromUpperBound: Self,
    toLowerBound: Self,
    toUpperBound: Self) -> Self
  {
    let positionInRange = (self - fromLowerBound) / (fromUpperBound - fromLowerBound)
    let result = (positionInRange * (toUpperBound - toLowerBound)) + toLowerBound
    return result < toLowerBound ? toLowerBound : result > toUpperBound ? toUpperBound : result
  }

  func interpolated(from: ClosedRange<Self>, to: ClosedRange<Self>) -> Self {
    interpolated(
      fromLowerBound: from.lowerBound,
      fromUpperBound: from.upperBound,
      toLowerBound: to.lowerBound,
      toUpperBound: to.upperBound)
  }
}
