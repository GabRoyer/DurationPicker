/// MIT License
///
/// Copyright (c) 2025 Vis Fitness Inc.
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in all
/// copies or substantial portions of the Software.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
/// SOFTWARE.

import SwiftUI
import DurationPicker

struct DurationPickerModeEnvironmentKey: EnvironmentKey {
  static let defaultValue: DurationPickerView.Mode = .hourMinuteSecond
}

extension EnvironmentValues {
  var durationPickerMode: DurationPickerView.Mode {
    get {
      self[DurationPickerModeEnvironmentKey.self]
    } set {
      self[DurationPickerModeEnvironmentKey.self] = newValue
    }
  }
}

public extension View {
  /// Sets the mode displayed by the duration picker.
  ///
  /// The mode determines which combination of hours, minutes, and seconds are displayed. You can set and retrieve the mode value through the ``DurationPicker/pickerMode`` property.
  func durationPickerMode(_ mode: DurationPickerView.Mode) -> some View {
    environment(\.durationPickerMode, mode)
  }
}
