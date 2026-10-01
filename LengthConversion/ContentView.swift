//
//  ContentView.swift
//  LengthConversion
//
//  Created by Mohammed Alhashim on 22/09/2026.
//

import SwiftUI

/// Converts a value from one unit of length to another.
/// Pulled out of the view so it can be unit-tested without instantiating SwiftUI.
func convert(_ value: Double, from: UnitLength, to: UnitLength) -> Measurement<UnitLength> {
    Measurement(value: value, unit: from).converted(to: to)
}

struct ContentView: View {

    static let lengths: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]

    @State private var inputValue: Double = 10
    @State private var inputUnit: UnitLength = .meters
    @State private var outputUnit: UnitLength = .miles
    @FocusState private var inputIsFocused: Bool

    var result: Measurement<UnitLength> {
        convert(inputValue, from: inputUnit, to: outputUnit)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Please select a unit and a value") {
                    Picker("Select a unit", selection: $inputUnit) {
                        ForEach(Self.lengths, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)

                    TextField("Enter value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                }

                Section("Select output unit") {
                    Picker("Result", selection: $outputUnit) {
                        ForEach(Self.lengths, id: \.self) {
                            Text($0.symbol)
                        }
                    }
                    .pickerStyle(.segmented)

                    Text(result, format: .measurement(width: .abbreviated, usage: .asProvided))
                }

                Section {
                    Button {
                        swap(&inputUnit, &outputUnit)
                    } label: {
                        Label("Swap units", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
            .navigationTitle("Length Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
