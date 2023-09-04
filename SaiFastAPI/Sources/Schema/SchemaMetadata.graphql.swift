// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public typealias ID = String

public protocol SelectionSet: ApolloAPI.SelectionSet & ApolloAPI.RootSelectionSet
where Schema == SaiFastAPI.SchemaMetadata {}

public protocol InlineFragment: ApolloAPI.SelectionSet & ApolloAPI.InlineFragment
where Schema == SaiFastAPI.SchemaMetadata {}

public protocol MutableSelectionSet: ApolloAPI.MutableRootSelectionSet
where Schema == SaiFastAPI.SchemaMetadata {}

public protocol MutableInlineFragment: ApolloAPI.MutableSelectionSet & ApolloAPI.InlineFragment
where Schema == SaiFastAPI.SchemaMetadata {}

public enum SchemaMetadata: ApolloAPI.SchemaMetadata {
  public static let configuration: ApolloAPI.SchemaConfiguration.Type = SchemaConfiguration.self

  public static func objectType(forTypename typename: String) -> Object? {
    switch typename {
    case "Mutation": return SaiFastAPI.Objects.Mutation
    case "WalkType": return SaiFastAPI.Objects.WalkType
    case "WalkHistoryType": return SaiFastAPI.Objects.WalkHistoryType
    case "WalkHistoryItemType": return SaiFastAPI.Objects.WalkHistoryItemType
    case "CalendarEventType": return SaiFastAPI.Objects.CalendarEventType
    case "Query": return SaiFastAPI.Objects.Query
    case "UserType": return SaiFastAPI.Objects.UserType
    case "DogType": return SaiFastAPI.Objects.DogType
    case "WalkIntervalActivity": return SaiFastAPI.Objects.WalkIntervalActivity
    case "WalkIntervalActivityItem": return SaiFastAPI.Objects.WalkIntervalActivityItem
    case "WalkDayActivity": return SaiFastAPI.Objects.WalkDayActivity
    default: return nil
    }
  }
}

public enum Objects {}
public enum Interfaces {}
public enum Unions {}
