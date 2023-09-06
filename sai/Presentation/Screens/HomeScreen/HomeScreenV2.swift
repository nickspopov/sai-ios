//
//  HomeScreenV2.swift
//  sai
//
//  Created by Николай Попов on 05.09.2023.
//

import SwiftUI
import BottomSheet
@_spi(Advanced) import SwiftUIIntrospect

struct HomeScreenV2: View {
    
    @State var bottomSheetPosition: BottomSheetPosition = .relative(0.5)
    
    @State var headerHeight = 350.0
    @State var pageIndex = 0
    
    var body: some View {
        VStack {
            VStack{
                Spacer()
                    .frame(height: 54)
                Header()
                Spacer()
                    .frame(height: 80)
                DateView()
                Spacer()
                    .frame(height: 64)
                //                Spacer()
            }
            .frame(height: headerHeight)
            Spacer()
        }
        .screenContainer()
        .toolbar(.hidden, for: .navigationBar)
        .bottomSheet(bottomSheetPosition: self.$bottomSheetPosition, switchablePositions: [.relative(0.5), .relativeTop(0.9)], headerContent: {EmptyView()}) {
            VStack {
                FiltersRow()
                AdaptivePagingScrollView(currentPageIndex: $pageIndex,
                                         itemsAmount: 1,
                                         itemScrollableSide: 375,
                                         itemPadding: 0,
                                         visibleContentLength: 375,
                                         orientation: .horizontal) {
                    VStack{
                        CalendarWidget()
                            .frame(width: 375)
                        CalendarWidget()
                            .frame(width: 375)
                    }
                    VStack{
                        CalendarWidget()
                            .frame(width: 375)
                        CalendarWidget()
                            .frame(width: 375)
                    }
                }
                //                ScrollView(.vertical, showsIndicators: false) {
                
                //                            CalendarWidget()
                //                            CalendarWidget()
                //                            CalendarWidget()
                //                            CalendarWidget()
                //                            CalendarWidget()
                //                            CalendarWidget()
            }
            //                }
        }
        .onDragChanged({ value in
            if bottomSheetPosition == .relative(0.5) {
                let newV = 350.0 + value.translation.height
                //                            print("newV: \(newV)")
                headerHeight = newV
            }
        })
        .onDragEnded({ v in
            headerHeight = 350
        })
        .customBackground(EmptyView())
        .showDragIndicator(false)
        .enableAppleScrollBehavior(true)
        .onChange(of: bottomSheetPosition, perform: { newValue in
            if newValue == .relative(0.5) {
                withAnimation {
                    headerHeight = 350
                }
            } else {
                withAnimation {
                    headerHeight = 80
                }
            }
            
            print("New value: \(newValue)")
        })
        
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
struct HomeScreenV2_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenV2()
    }
}
