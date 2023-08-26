//
//  CreateEventScreen.swift
//  sai
//
//  Created by Николай Попов on 26.08.2023.
//

import SwiftUI

struct CreateEventScreen: View {
    @State var title: String = ""
    @State var notes: String = ""
    @State var startedAt: Date = Date()
    @State var endedAt: Date = Date() + 3600
    @State var type: CalendarEventType = .walk
    
    func createEvent() {
        let calendarRepository = CalendarEventsRepository.shared
        
        let event = CalendarEvent(
            id: nil,
            title: title,
            notes: notes,
            startedAt: startedAt,
            endedAt: endedAt,
            type: type
        )
        
        Task {
            try? await calendarRepository.save(event)
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Title", text: $title)
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(3...5)
                    DatePicker(selection: $startedAt, in: ...(endedAt - 3600)) {
                        Text("Start date")
                    }
                    DatePicker(selection: $endedAt, in: ...endedAt) {
                        Text("End date")
                    }
                    Picker("Type", selection: $type) {
                        ForEach(CalendarEventType.allCases, id: \.self) {
                            Text($0.name)
                        }
                    }
                }
            }
            .screenContainer()
            .navigationTitle("Create Event")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        print("Cancel")
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        createEvent()
                    }, label: {
                        Text("Save")
                    })
                }
            }
        }
    }
}

struct CreateEventScreen_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("AAAA")
        }.sheet(isPresented: .constant(true)) {
            CreateEventScreen()
        }
    }
}
