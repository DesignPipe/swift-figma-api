public struct LibraryAnalyticsAction: Decodable, Sendable {
    public let componentKey: String?
    public let componentName: String?
    public let styleKey: String?
    public let styleName: String?
    public let variableKey: String?
    public let variableName: String?
    public let actionType: String
    public let actionCount: Int

    private enum CodingKeys: String, CodingKey {
        case componentKey = "component_key"
        case componentName = "component_name"
        case styleKey = "style_key"
        case styleName = "style_name"
        case variableKey = "variable_key"
        case variableName = "variable_name"
        case actionType = "action_type"
        case actionCount = "action_count"
    }
}

public struct LibraryAnalyticsUsage: Decodable, Sendable {
    public let componentKey: String?
    public let componentName: String?
    public let styleKey: String?
    public let styleName: String?
    public let variableKey: String?
    public let variableName: String?
    public let usageCount: Int

    private enum CodingKeys: String, CodingKey {
        case componentKey = "component_key"
        case componentName = "component_name"
        case styleKey = "style_key"
        case styleName = "style_name"
        case variableKey = "variable_key"
        case variableName = "variable_name"
        case usageCount = "usage_count"
    }
}
