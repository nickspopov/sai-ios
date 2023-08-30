// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateEventMutation: GraphQLMutation {
  public static let operationName: String = "CreateEvent"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateEvent($input: CreateEventInput!) { createEvent(input: $input) { __typename id title notes startedAt endedAt type } }"#
    ))

  public var input: CreateEventInput

  public init(input: CreateEventInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createEvent", CreateEvent.self, arguments: ["input": .variable("input")]),
    ] }

    public var createEvent: CreateEvent { __data["createEvent"] }

    /// CreateEvent
    ///
    /// Parent Type: `CalendarEventType`
    public struct CreateEvent: SaiFastAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CalendarEventType }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", String.self),
        .field("title", String.self),
        .field("notes", String.self),
        .field("startedAt", SaiFastAPI.DateTimeType.self),
        .field("endedAt", SaiFastAPI.DateTimeType.self),
        .field("type", GraphQLEnum<SaiFastAPI.CalendarEventTypeEnumType>.self),
      ] }

      public var id: String { __data["id"] }
      public var title: String { __data["title"] }
      public var notes: String { __data["notes"] }
      public var startedAt: SaiFastAPI.DateTimeType { __data["startedAt"] }
      public var endedAt: SaiFastAPI.DateTimeType { __data["endedAt"] }
      public var type: GraphQLEnum<SaiFastAPI.CalendarEventTypeEnumType> { __data["type"] }
    }
  }
}
