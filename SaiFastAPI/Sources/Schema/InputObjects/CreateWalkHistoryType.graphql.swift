// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct CreateWalkHistoryType: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    history: [CreateWalkHistoryItemType]
  ) {
    __data = InputDict([
      "history": history
    ])
  }

  public var history: [CreateWalkHistoryItemType] {
    get { __data["history"] }
    set { __data["history"] = newValue }
  }
}
