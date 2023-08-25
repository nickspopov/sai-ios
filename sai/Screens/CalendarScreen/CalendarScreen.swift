//
//  SwiftUIView.swift
//  sai
//
//  Created by Николай Попов on 25.08.2023.
//

import SwiftUI

struct CalendarScreen: View {
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @EnvironmentObject var navigationController: NavigationController
    
    @StateObject var viewModel: CalendarScreenViewModel = CalendarScreenViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                header
                eventsList
            }
            .screenContainer()
            .ignoresSafeArea()
            .onAppear() {
                viewModel.onAppear()
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct CalendarScreen_Previews: PreviewProvider {
    static var previews: some View {
        CalendarScreen()
    }
}

//MARK: - Events List
extension CalendarScreen {
    var eventsList: some View {
        VStack {
            ForEach(viewModel.events, id: \.self) { event in
                eventItem(event)
                    .padding()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func eventItem(_ event: CalendarEvent) -> some View {
        return VStack {
            Text(event.title)
        }

        .frame(
            maxWidth: .infinity,
            minHeight: 136,
            maxHeight: 136
        )
        .background(Color.red)
    }
}

// MARK: - Header
extension CalendarScreen {
    var header: some View {
        VStack {
                VStack {
                    navigationRow
                        .padding(.horizontal, 16)
                    Spacer()
                        .frame(height: 25)
                    calendar
                }
                .padding(.top, safeAreaInsets.top + 20)
                .padding(.bottom, 25)
                .background {
                    VStack {
                        LinearGradient(
                            stops: [
                                Gradient.Stop(color: Color(red: 33, green: 58, blue: 125), location: 0.00),
                                Gradient.Stop(color: Color(red: 237, green: 185, blue: 108), location: 1),
                            ],
                            startPoint: UnitPoint(x: 0, y: 1),
                            endPoint: UnitPoint(x: 1, y: -1)
                        )
                    }.cornerRadius(32, corners: [.bottomLeft, .bottomRight])
                }
        }
    }
}

// MARK: - Calendar
extension CalendarScreen {
    var calendar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { scrollViewProxy in
                LazyHStack(spacing: 0) {
                    ForEach(viewModel.daysArray, id: \.self) { _day in
                        dayItem(_day, onPress: viewModel.onDateSelected )
                            .id(_day.timeIntervalSince1970)
                    }
                }
                .onChange(of: viewModel.daysArray, perform: { [oldValue = viewModel.daysArray] newValue in
                    if(oldValue.count == 0 && newValue.count > 0) {
                        scrollViewProxy.scrollTo(viewModel.selectedDate.timeIntervalSince1970)
                    }
                })
            }
            .frame(height: 71)
        }
    }
    
    func dayItem(_ day: Date, onPress: @escaping (_ day: Date) -> Void) -> some View {
        return VStack(spacing: 0) {
            Text(day.dayOfWeek().prefix(1))
                .padding(.top, 11)
            Text(day.format(format: "dd"))
                .frame(width: 40)
                .foregroundColor(.white)
                .padding(.top, 4)
            Spacer()
        }
        .frame(width: 40, height: 71)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(day == viewModel.selectedDate ? 0.8 : 0.2))
        )
        .padding(.horizontal, 8)
        .onTapGesture {
            onPress(day)
        }
    }
}


// MARK: - Navigation Row
extension CalendarScreen {
    var navigationRow: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .blendMode(.difference)
            }
            Spacer()
            Typography("August", .semibold(.five))
            Spacer()
            Button(action: {viewModel.showCreateEventScreen.toggle()}) {
                Image(systemName: "plus")
                    .blendMode(.difference)
            }
            .sheet(isPresented: $viewModel.showCreateEventScreen) {
                CreateEventScreen()
            }
        }
    }
    
}
