// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetCommunitiesQuery: GraphQLQuery {
  public static let operationName: String = "GetCommunities"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetCommunities { getCommunities { __typename ...CommunityFragment } }"#,
      fragments: [CommunityFragment.self, UserFragment.self, DogFragment.self, CommunityPlaceFragment.self, CommunityMemberFragment.self, CommunityMemberLastCheckinFragment.self]
    ))

  public init() {}

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getCommunities", [GetCommunity].self),
    ] }

    public var getCommunities: [GetCommunity] { __data["getCommunities"] }

    /// GetCommunity
    ///
    /// Parent Type: `CommunityType`
    public struct GetCommunity: SaiFastAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityType }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(CommunityFragment.self),
      ] }

      public var id: String { __data["id"] }
      public var name: String { __data["name"] }
      public var owner: Owner { __data["owner"] }
      public var places: [Place] { __data["places"] }
      public var members: [Member] { __data["members"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var communityFragment: CommunityFragment { _toFragment() }
      }

      /// GetCommunity.Owner
      ///
      /// Parent Type: `UserType`
      public struct Owner: SaiFastAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.UserType }

        public var id: String { __data["id"] }
        public var name: String { __data["name"] }
        public var dogs: [Dog] { __data["dogs"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var userFragment: UserFragment { _toFragment() }
        }

        /// GetCommunity.Owner.Dog
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

      /// GetCommunity.Place
      ///
      /// Parent Type: `CommunityPlaceType`
      public struct Place: SaiFastAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityPlaceType }

        public var id: String { __data["id"] }
        public var name: String { __data["name"] }
        public var lat: Double { __data["lat"] }
        public var lon: Double { __data["lon"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var communityPlaceFragment: CommunityPlaceFragment { _toFragment() }
        }
      }

      /// GetCommunity.Member
      ///
      /// Parent Type: `CommunityMemberType`
      public struct Member: SaiFastAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityMemberType }

        public var user: User { __data["user"] }
        public var lastCheckin: LastCheckin? { __data["lastCheckin"] }

        public struct Fragments: FragmentContainer {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public var communityMemberFragment: CommunityMemberFragment { _toFragment() }
        }

        /// GetCommunity.Member.User
        ///
        /// Parent Type: `UserType`
        public struct User: SaiFastAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.UserType }

          public var id: String { __data["id"] }
          public var name: String { __data["name"] }
          public var dogs: [Dog] { __data["dogs"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var userFragment: UserFragment { _toFragment() }
          }

          /// GetCommunity.Member.User.Dog
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

        /// GetCommunity.Member.LastCheckin
        ///
        /// Parent Type: `CommunityMemberLastCheckinType`
        public struct LastCheckin: SaiFastAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityMemberLastCheckinType }

          public var date: SaiFastAPI.DateTimeType { __data["date"] }
          public var place: Place { __data["place"] }

          public struct Fragments: FragmentContainer {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public var communityMemberLastCheckinFragment: CommunityMemberLastCheckinFragment { _toFragment() }
          }

          /// GetCommunity.Member.LastCheckin.Place
          ///
          /// Parent Type: `CommunityPlaceType`
          public struct Place: SaiFastAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityPlaceType }

            public var id: String { __data["id"] }
            public var name: String { __data["name"] }
            public var lat: Double { __data["lat"] }
            public var lon: Double { __data["lon"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(_dataDict: DataDict) { __data = _dataDict }

              public var communityPlaceFragment: CommunityPlaceFragment { _toFragment() }
            }
          }
        }
      }
    }
  }
}
