//
//  CreateEventScreen.swift
//  sai
//
//  Created by Николай Попов on 26.08.2023.
//

import SwiftUI

struct CreateEventScreen: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var title: String = ""
    @State var notes: String = ""
    @State var startedAt: Date = Date()
    @State var endedAt: Date = Date() + 3600
    @State var type: CalendarEventType = .walking
    
    @State var isLoading: Bool = false
    
    func createEvent() {
        let calendarRepository = CalendarEventsRepositoryImpl.shared
        
        let event = CalendarEvent(
            title: title,
            notes: notes,
            startedAt: startedAt,
            endedAt: endedAt,
            type: type
        )
        isLoading = true
        Task {
            if let _ = try? await calendarRepository.save(event) {
                DispatchQueue.main.async {
                    isLoading = false
                    presentationMode.wrappedValue.dismiss()
                }
            } else {
                DispatchQueue.main.async {
                    isLoading = false
                }
                
                print("Error")
            }
        }
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Title", text: $title)
                    TextField("Notes", text: $notes, axis: .vertical)
                        .lineLimit(3...5)
                    DatePicker(selection: $startedAt, in: Date()...) {
                        Text("Start date")
                    }
                    DatePicker(selection: $endedAt, in: (startedAt + 600)...) {
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
                if isLoading {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        ProgressView()
                    }
                } else {
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
