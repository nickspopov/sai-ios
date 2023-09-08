//
//  CalendarEventItem.swift
//  sai
//
//  Created by Николай Попов on 01.09.2023.
//

import SwiftUI

struct CalendarEventItem: View {
    
    var event: CalendarEvent
    
    var body: some View {
        HStack {
            verticalLine
            Spacer()
                .frame(width: 16)
            info
            checkmark
        }
        .padding(.top, 14)
        .padding(.bottom, 16)
        .padding(.leading, 20)
        .padding(.trailing, 16)
        .frame(
            maxWidth: .infinity,
            minHeight: 136,
            maxHeight: 136
        )
        .background(Color(uiColor: UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)))
        .cornerRadius(12)
        
    }
}

// MARK: - Checkmark
extension CalendarEventItem {
    var checkmark: some View {
        VStack {
            ZStack {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundColor(Color(uiColor: UIColor(red: 0.15, green: 0.15, blue: 0.15, alpha: 1)))
            }
            .frame(width: 32, height: 32)
            .background(Color(uiColor: UIColor(red: 0.39, green: 0.39, blue: 0.4, alpha: 1)))
            .cornerRadius(.infinity)
            Spacer()
        }
    }
}


// MARK: - Info
extension CalendarEventItem {
    var timeString: String {
        var format = "hh:mm"
        return "\(event.startedAt.format(format: format)) - \(event.endedAt.format(format: format))"
    }
    
    var info: some View {
        VStack(alignment: .leading, spacing: 0) {
            Typography(event.type.name, .regular(.eight))
                .foregroundColor(Color(uiColor: UIColor(red: 0.64, green: 0.68, blue: 0.69, alpha: 1)))
                .frame(height: 20)
            Spacer()
                .frame(height: 11)
            Typography(event.title, .semibold(.six))
                .frame(height: 24)
            Typography(timeString, .regular(.eight))
                .foregroundColor(Color(uiColor: UIColor(red: 0.64, green: 0.68, blue: 0.69, alpha: 1)))
                .frame(height: 20)
            Spacer()
                .frame(height: 11)
            HStack {
                Typography("Remind", .regular(.eight))
                    .foregroundColor(Color(uiColor: UIColor(red: 0.64, green: 0.68, blue: 0.69, alpha: 1)))
                Spacer()
                    .frame(width: 10)
                Typography("in 1 hour", .regular(.eight))
            }
            .frame(height: 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


// MARK: - Vertical Line
extension CalendarEventItem {
    var verticalLine: some View {
        Rectangle()
            .frame(maxWidth: 2, maxHeight: .infinity)
            .foregroundColor(Color(uiColor: UIColor(red: 0.89, green: 0.59, blue: 0.2, alpha: 1)))
    }
}


struct CalendarEventItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CalendarEventItem(
                event: CalendarEvent(
                    title: "Title",
                    notes: "Notes",
                    startedAt: Date(),
                    endedAt: Date() + 3600,
                    type: .walking
                )
            )
            CalendarEventItem(
                event: CalendarEvent(
                    title: "Titlefbdksabfjkasnfdjankjsfbksadjbfkjasdbkfjbasdkjfbkjsadkjfnfnksdafnka",
                    notes: "Notes",
                    startedAt: Date(),
                    endedAt: Date() + 3600,
                    type: .walking
                )
            )
        }
        .preferredColorScheme(.dark)
        .padding(.horizontal)
    }
}
