//
//  StatsControl.swift
//  WidgetsExtension
//
//  Created for Stats.
//

import WidgetKit
import SwiftUI
import AppIntents
import CPU

@available(macOS 15.0, *)
struct CPUControlValueProvider: ControlValueProvider {
    typealias Value = Double
    
    private let userDefaults: UserDefaults? = UserDefaults(suiteName: "\(Bundle.main.object(forInfoDictionaryKey: "TeamId") as! String).eu.exelban.Stats.widgets")
    
    var previewValue: Value {
        return 0.42
    }
    
    func currentValue() async throws -> Value {
        guard let raw = userDefaults?.data(forKey: "CPU@LoadReader"),
              let load = try? JSONDecoder().decode(CPU_Load.self, from: raw) else {
            return 0.0
        }
        return load.totalUsage
    }
}

@available(macOS 15.0, *)
public struct CPUControlWidget: ControlWidget {
    public init() {}
    
    public var body: some ControlWidgetConfiguration {
        StaticControlConfiguration(
            kind: "eu.exelban.Stats.CPUControl",
            provider: CPUControlValueProvider()
        ) { value in
            ControlWidgetStatus(
                "CPU",
                status: Text("\(Int(value * 100))%"),
                image: Image(systemName: "cpu")
            )
        }
        .displayName("CPU Usage")
        .description("Displays current CPU usage.")
    }
}
