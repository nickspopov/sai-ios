//
//  Header.swift
//  sai
//
//  Created by Николай Попов on 23.08.2023.
//

import SwiftUI

var randomGrayColor = Color(uiColor: UIColor(red: 0.72, green: 0.72, blue: 0.72, alpha: 1))

struct CalendarWidget: View {
    var body: some View {
        HStack(alignment: .center, spacing: 24) {
            dateRectangle
            schedule
        }
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 152, maxHeight: 152, alignment: .leading)
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
        .cornerRadius(12)
    }
}

struct CalendarWidget_Previews: PreviewProvider {
    static var previews: some View {
        CalendarWidget()
            .preferredColorScheme(.dark)
            .padding(16)
    }
}


// MARK: - Date Rectangle
extension CalendarWidget {
    private var dateRectangle: some View {
        VStack(alignment: .leading) {
            Typography("Aug 12", .semibold(.three))
            Spacer()
            VStack(alignment: .leading, spacing: 0){
                Typography("Monday", .regular(.eight))
                    .frame(height: 20)
                Typography("2 reminders", .regular(.eight))
                    .frame(height: 20)
            }
            .foregroundColor(randomGrayColor)
        }
        .padding(.horizontal, 12)
        .padding(.top, 12)
        .padding(.bottom, 8)
        .frame(minWidth: 142, maxWidth: 142, maxHeight: .infinity, alignment: .leading)
        .background(
          LinearGradient(
            stops: [
              Gradient.Stop(color: Color(red: 33, green: 58, blue: 125), location: 0.00),
              Gradient.Stop(color: Color(red: 237, green: 185, blue: 108), location: 1),
            ],
            startPoint: UnitPoint(x: 0, y: 1),
            endPoint: UnitPoint(x: 1, y: 0)
          )
        )
        .cornerRadius(8)
    }
    
}

//MARK: - Schedule
extension CalendarWidget {
    private var schedule: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
                .frame(height: 6)
            Typography("Upcoming", .regular(.eight))
                .foregroundColor(randomGrayColor)
            schedultItem()
            schedultItem()
            Spacer()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        
    }
    
    private func schedultItem() -> some View {
        return HStack(alignment: .center, spacing: 8) {
            RoundedRectangle(cornerRadius: 2)
                .frame(width: 2, height: 31)
                .foregroundColor(Color.warning)
            VStack(alignment: .leading) {
                Typography("Grooming", .semibold(.seven))
                    .lineLimit(1)
                Spacer()
                    .frame(height: 4)
                Typography("10:00 - 11:30", .regular(.eight))
                    .foregroundColor(Color(uiColor: UIColor(red: 0.64, green: 0.68, blue: 0.69, alpha: 1)))
            }
            Spacer()
        }
        .frame(height: 42)
    }
}
