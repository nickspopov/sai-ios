//
//  AnimatedHeader.swift
//  sai
//
//  Created by Николай Попов on 06.09.2023.
//

import SwiftUI
import Popovers

struct AnimatedHeader: View {
    
    var animationProgress: CGFloat // from 0 to 1
    
    @Binding var selectedDate: Date
    
    func getOffestY() -> Double {
        return animationProgress.interpolate([0, 0.7, 1], [0, -300, -550])
    }
    
    func getOffestX() -> Double {
        return animationProgress.interpolate([0, 1], [0, 35])
    }
    
    func getScale() -> Double {
        return animationProgress.interpolate([0, 0.7, 1], [1, 0.5, 0.35])
    }
    
    func getOpacity() -> Double {
        return animationProgress.interpolate([0, 1], [1, 0])
    }
    
    func getDividerOpacity() -> Double {
        return animationProgress.interpolate([0, 0.8, 1], [0, 0, 1])
    }
    
    func getChevronOpacity() -> Double {
        return animationProgress.interpolate([0, 0.9, 1], [0, 0, 1])
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0){
                Spacer()
                    .frame(height: 54)
                Header()
                    .opacity(getOpacity())
                Spacer()
                    .frame(height: 80)
                DateViewPicker(selectedDate: $selectedDate)
                    .offset(x: getOffestX(), y: getOffestY())
                    .scaleEffect(getScale())
                DateViewPickerDescription()
                    .opacity(getOpacity())
                Spacer()
                    .frame(height: 64)
            }
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: UIScreen.main.bounds.width, height: 0.33)
                .background(.white.opacity(0.8))
                .offset(y: 44)
                .opacity(getDividerOpacity())
            ChevronDownIcon()
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .offset(x: 65, y: 10)
                .opacity(getDividerOpacity())
        }
    }
}

struct AnimatedHeader_Previews: PreviewProvider {
    static var previews: some View {
        let date: Binding<Date> = .constant(Date())
        VStack{
            AnimatedHeader(animationProgress: 1, selectedDate: date)
                .preferredColorScheme(.dark)
            Spacer()
        }
    }
}



// MARK: - DateView
fileprivate struct DateViewPicker: View {
    
    @Binding var selectedDate: Date
    @State var present = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(selectedDate.format(format: "MMM d, YYYY"))
                .font(
                    Font.custom("Inter-SemiBold", size: 48)
                        .weight(.semibold)
                )
                .foregroundColor(.white)
                .onTapGesture {
                    present = true
                }
        }
        .padding(.leading, 16)
        .padding(.trailing, 32)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .popover(present: $present, attributes: {
            $0.presentation.animation = .spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.1)
            $0.presentation.transition = .move(edge: .top)
            $0.dismissal.transition = .move(edge: .top)
        }) {
            VStack {
                DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .frame(maxHeight: 400)
            }
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .foregroundColor(.gray)
            )
        }
        .onChange(of: selectedDate) { newValue in
            present = false
        }
    }
}

fileprivate struct DateViewPickerDescription: View {
    var body: some View {
        VStack(alignment: .leading) {
            Typography("Click on the date and check history", .regular(.six))
                .foregroundColor(Color(red: 0.69, green: 0.68, blue: 0.68))
                .frame( alignment: .leading)
        }
        .padding(.top, 2)
        .padding(.leading, 16)
        .padding(.trailing, 32)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}


// MARK: - Header
fileprivate struct Header: View {
    var body: some View {
        HStack(alignment: .center) {
            Image("profile")
                .resizable()
                .frame(width: 50, height: 50)
                .background(Color(red: 55, green: 55, blue: 55))
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
            Spacer()
            Button(action: {print("Pet-time pressed")}) {
                Typography("Pet-time", .regular(.five))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 16)
    }
}
