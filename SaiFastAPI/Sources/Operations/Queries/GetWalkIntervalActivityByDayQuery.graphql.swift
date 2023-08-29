// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetWalkIntervalActivityByDayQuery: GraphQLQuery {
  public static let operationName: String = "GetWalkIntervalActivityByDay"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetWalkIntervalActivityByDay($fromDate: DateTimeType!, $toDate: DateTimeType!) { getWalkIntervalActivityByDay(fromDate: $fromDate, toDate: $toDate) { __typename totalDuration totalDistance items { __typename date duration } } }"#
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
      .field("getWalkIntervalActivityByDay", GetWalkIntervalActivityByDay.self, arguments: [
        "fromDate": .variable("fromDate"),
        "toDate": .variable("toDate")
      ]),
    ] }

    public var getWalkIntervalActivityByDay: GetWalkIntervalActivityByDay { __data["getWalkIntervalActivityByDay"] }

    /// GetWalkIntervalActivityByDay
    ///
    /// Parent Type: `WalkIntervalActivity`
    public struct GetWalkIntervalActivityByDay: SaiFastAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.WalkIntervalActivity }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("totalDuration", Double.self),
        .field("totalDistance", Double.self),
        .field("items", [Item].self),
      ] }

      public var totalDuration: Double { __data["totalDuration"] }
      public var totalDistance: Double { __data["totalDistance"] }
      public var items: [Item] { __data["items"] }

      /// GetWalkIntervalActivityByDay.Item
      ///
      /// Parent Type: `WalkIntervalActivityItem`
      public struct Item: SaiFastAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.WalkIntervalActivityItem }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("date", SaiFastAPI.DateTimeType.self),
          .field("duration", Double.self),
        ] }

        public var date: SaiFastAPI.DateTimeType { __data["date"] }
        public var duration: Double { __data["duration"] }
      }
    }
  }
}
