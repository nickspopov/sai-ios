// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetMeQuery: GraphQLQuery {
  public static let operationName: String = "GetMe"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetMe { me { __typename ...UserFragment } }"#,
      fragments: [UserFragment.self, DogFragment.self]
    ))

  public init() {}

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("me", Me.self),
    ] }

    public var me: Me { __data["me"] }

    /// Me
    ///
    /// Parent Type: `UserType`
    public struct Me: SaiFastAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.UserType }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(UserFragment.self),
      ] }

      public var id: String { __data["id"] }
      public var name: String { __data["name"] }
      public var dogs: [Dog] { __data["dogs"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var userFragment: UserFragment { _toFragment() }
      }

      /// Me.Dog
      ///
      /// Parent Type: `DogType`
      public struct Dog: SaiFastAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.DogType }

        public var id: String { __data["id"] }
        public var name: String { __data["name"] }
        public var breed: String { __data["breed"] }
        public var dateOfBirth: SaiFastAPI.DateTimeType { __data["dateOfBirth"] }
        public var sex: String { __data["sex"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var dogFragment: DogFragment { _toFragment() }
        }
      }
    }
  }
}
