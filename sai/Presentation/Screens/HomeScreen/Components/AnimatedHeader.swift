//
//  AnimatedHeader.swift
//  sai
//
//  Created by Николай Попов on 06.09.2023.
//

import SwiftUI

struct AnimatedHeader: View {
    
    @Binding var animationProgress: CGFloat // from 0 to 1
    
    func getOffest() -> Double {
        return animationProgress.interpolate([0, 1], [0, -400])
    }
    
    func getScale() -> Double {
        return animationProgress.interpolate([0, 1], [1, 0.5])
    }
    
    func getOpacity() -> Double {
        return animationProgress.interpolate([0, 1], [1, 0])
    }
    
    var body: some View {
        VStack{
            Spacer()
                .frame(height: 54)
            Header()
                .opacity(getOpacity())
            Spacer()
                .frame(height: 80)
            DateViewPicker()
                .offset(y: getOffest())
                .scaleEffect(getScale())
                .onTapGesture {
                    print("Date Picker")
                }
            DateViewPickerDescription()
                .opacity(getOpacity())
            Spacer()
                .frame(height: 64)
        }
    }
}

struct AnimatedHeader_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
//            AnimatedHeader(animationProgress: .constant(0))
//                .preferredColorScheme(.dark)
//            AnimatedHeader(animationProgress: .constant(0.5))
//                .preferredColorScheme(.dark)
            AnimatedHeader(animationProgress: .constant(1))
                .preferredColorScheme(.dark)
            Spacer()
        }
    }
}



// MARK: - DateView
fileprivate struct DateViewPicker: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Sep 3, 2023")
                .font(
                    Font.custom("Inter-SemiBold", size: 48)
                        .weight(.semibold)
                )
                .foregroundColor(.white)
        }
        .padding(.leading, 16)
        .padding(.trailing, 32)
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

fileprivate struct DateViewPickerDescription: View {
    var body: some View {
        VStack(alignment: .leading) {
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
            .onTapGesture {
                print("Community pressed")
            }
        }
        .padding(.horizontal, 16)
    }
}
