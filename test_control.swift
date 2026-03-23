import WidgetKit
@available(macOS 15.0, *)
struct TestProvider: ControlValueProvider {
    var previewValue: Double { 0.42 }
    func currentValue() async throws -> Double { 0.0 }
}
