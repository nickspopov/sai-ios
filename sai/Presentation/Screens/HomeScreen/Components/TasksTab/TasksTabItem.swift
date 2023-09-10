//
//  TasksTabItem.swift
//  sai
//
//  Created by Николай Попов on 08.09.2023.
//

import SwiftUI

enum TasksTabItemColor {
    case orange, gray, dark
    
    init(fromIndex: Int) {
        if (fromIndex == 0) {
            self = .orange
            return
        }
        switch fromIndex % 3 {
        case 0:
            self = .orange
            return
        case 1:
            self = .gray
            return
        case 2:
            self = .dark
            return
        default:
            self = .orange
            return
        }
    }
    
    var bg: Color {
        switch self {
        case .orange:
            return Color(red: 0.93, green: 0.34, blue: 0.16)
        case .gray:
            return Color(red: 0.92, green: 0.92, blue: 0.97, opacity: 0.32)
        case .dark:
            return Color(red: 0.15, green: 0.15, blue: 0.15)
        }
    }
    
}

struct TasksTabItem: View {
    
    var task: CalendarEvent
    var color: TasksTabItemColor = .orange
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Typography(task.type.name, .regular(.eight))
            Spacer()
                .frame(height: 8)
            Typography(task.title, .regular(.three))
            Spacer()
                .frame(height: 5)
            Typography("-", .regular(.eight))
            Spacer()
                .frame(height: 17)
            HStack(alignment: .bottom) {
                Typography("\(task.startedAt.timeIn24HourFormat()) - \(task.endedAt.timeIn24HourFormat())", .regular(.eight))
                Spacer()
                VStack(alignment: .center) {
                    NorthEastIcon()
                        .foregroundColor(.black)
                        .frame(width: 19, height: 19)
                }
                .frame(width: 32,height: 32)
                .background(.white)
                .cornerRadius(16)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 12)
        .padding(.bottom, 16)
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(color.bg)
        .cornerRadius(24)
    }
}

struct TasksTabItem_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TasksTabItem(
                task: CalendarEvent(
                    id: "sss",
                    title: "Walk with dog",
                    notes: "Walk with dog",
                    startedAt: Date(),
                    endedAt: Date(),
                    type: .food
                ),
                color: .init(fromIndex: 0)
            )
            TasksTabItem(
                task: CalendarEvent(
                    id: "sss",
                    title: "Walk with dog",
                    notes: "Walk with dog",
                    startedAt: Date(),
                    endedAt: Date(),
                    type: .food
                ),
                color: .init(fromIndex: 1)
            )
            TasksTabItem(
                task: CalendarEvent(
                    id: "sss",
                    title: "Walk with dog",
                    notes: "Walk with dog",
                    startedAt: Date(),
                    endedAt: Date(),
                    type: .food
                ),
                color: .init(fromIndex: 2)
            )
            TasksTabItem(
                task: CalendarEvent(
                    id: "sss",
                    title: "Walk with dog",
                    notes: "Walk with dog",
                    startedAt: Date(),
                    endedAt: Date(),
                    type: .food
                ),
                color: .init(fromIndex: 3)
            )
            TasksTabItem(
                task: CalendarEvent(
                    id: "sss",
                    title: "Walk with dog",
                    notes: "Walk with dog",
                    startedAt: Date(),
                    endedAt: Date(),
                    type: .food
                ),
                color: .init(fromIndex: 4)
            )
        }
        .preferredColorScheme(.dark)
    }
}
