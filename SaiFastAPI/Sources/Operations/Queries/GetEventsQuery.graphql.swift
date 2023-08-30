// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetEventsQuery: GraphQLQuery {
  public static let operationName: String = "GetEvents"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetEvents($fromDate: DateTimeType!, $toDate: DateTimeType!) { getEvents(fromDate: $fromDate, toDate: $toDate) { __typename id title notes startedAt endedAt type } }"#
    ))

  public var fromDate: DateTimeType
  public var toDate: DateTimeType

  public init(
    fromDate: DateTimeType,
    toDate: DateTimeType
  ) {
    self.fromDate = fromDate
    self.toDate = toDate
  }

  public var __variables: Variables? { [
    "fromDate": fromDate,
    "toDate": toDate
  ] }

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getEvents", [GetEvent?].self, arguments: [
        "fromDate": .variable("fromDate"),
        "toDate": .variable("toDate")
      ]),
    ] }

    public var getEvents: [GetEvent?] { __data["getEvents"] }

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
