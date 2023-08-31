// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetEventQuery: GraphQLQuery {
  public static let operationName: String = "GetEvent"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetEvent($id: String!) { getEvent(id: $id) { __typename id title notes startedAt endedAt type } }"#
    ))

  public var id: String

  public init(id: String) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getEvent", GetEvent.self, arguments: ["id": .variable("id")]),
    ] }

    public var getEvent: GetEvent { __data["getEvent"] }

    /// GetEvent
    ///
    /// Parent Type: `CalendarEventType`
    public struct GetEvent: SaiFastAPI.SelectionSet {
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
