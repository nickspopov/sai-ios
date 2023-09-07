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
        return animationProgress.interpolate([0, 1], [0, -500])
    }
    
    func getOffestX() -> Double {
        return animationProgress.interpolate([0, 1], [0, 50])
    }
    
    func getScale() -> Double {
        return animationProgress.interpolate([0, 1], [1, 0.35])
    }
    
    func getOpacity() -> Double {
        return animationProgress.interpolate([0, 1], [1, 0])
    }
    
    var body: some View {
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
    }
}

struct AnimatedHeader_Previews: PreviewProvider {
    static var previews: some View {
        let date: Binding<Date> = .constant(Date())
        VStack{
            AnimatedHeader(animationProgress: 0, selectedDate: date)
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
        .popover(present: $present) {
            VStack {
                DatePicker("Enter your birthday", selection: $selectedDate, displayedComponents: [.date])
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
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(Color(red: 55, green: 55, blue: 55))
            Spacer()
            Button(action: {print("Pet-time pressed")}) {
                Typography("Pet-time", .regular(.five))
                    .foregroundColor(.white)
            }
        }
        .padding(.horizontal, 16)
    }
}
