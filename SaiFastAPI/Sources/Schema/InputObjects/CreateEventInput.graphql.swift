// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct CreateEventInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    title: String,
    notes: String,
    startedAt: DateTimeType,
    endedAt: DateTimeType,
    type: GraphQLEnum<CalendarEventTypeEnumType>
  ) {
    __data = InputDict([
      "title": title,
      "notes": notes,
      "startedAt": startedAt,
      "endedAt": endedAt,
      "type": type
    ])
  }

  public var title: String {
    get { __data["title"] }
    set { __data["title"] = newValue }
  }

  public var notes: String {
    get { __data["notes"] }
    set { __data["notes"] = newValue }
  }

  public var startedAt: DateTimeType {
    get { __data["startedAt"] }
    set { __data["startedAt"] = newValue }
  }

  public var endedAt: DateTimeType {
    get { __data["endedAt"] }
    set { __data["endedAt"] = newValue }
  }

  public var type: GraphQLEnum<CalendarEventTypeEnumType> {
    get { __data["type"] }
    set { __data["type"] = newValue }
  }
}
