// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetWalkQuery: GraphQLQuery {
  public static let operationName: String = "GetWalk"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetWalk($id: String!) { getWalk(id: $id) { __typename id } }"#
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
      .field("getWalk", GetWalk?.self, arguments: ["id": .variable("id")]),
    ] }

    public var getWalk: GetWalk? { __data["getWalk"] }

    /// GetWalk
    ///
    /// Parent Type: `WalkType`
    public struct GetWalk: SaiFastAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.WalkType }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", String.self),
      ] }

      public var id: String { __data["id"] }
    }
  }
}
