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

/// A customizable control for inputting time values ranging between 0 and 24 hours. It serves as a drop-in replacement of [UIDatePicker](https://developer.apple.com/documentation/uikit/uidatepicker) with [countDownTimer](https://developer.apple.com/documentation/uikit/uidatepicker/mode/countdowntimer) mode with additional functionality for time input.
///
/// You can use a duration picker to allow a user to enter a time interval between 0 and 24 hours.
public struct DurationPickerView: UIViewRepresentable {
  public init(_ duration: Binding<TimeInterval>, components: Components = .hourMinuteSecond, hourInterval: Int = 1, minuteInterval: Int = 1, secondInterval: Int = 1, minumumDuration: TimeInterval? = nil, maximumDuration: TimeInterval? = nil) {
    self._duration = duration
    self.mode = components
    self.hourInterval = hourInterval
    self.minuteInterval = minuteInterval
    self.secondInterval = secondInterval
    self.minumumDuration = minumumDuration
    self.maximumDuration = maximumDuration
  }
  
  // This has to be public to comply with UIViewRepresentable, but we don't actually want it to show up in the doc.
  @_documentation(visibility: internal)
  public typealias UIViewType = DurationPicker
  
  /// The components displayed by the duration picker.
  ///
  /// The mode determines which combination of hours, minutes, and seconds are displayed. You can set and retrieve the mode value through the ``DurationPickerView/mode`` property.
  public typealias Components = DurationPicker.Mode
    
  @Binding private var duration: TimeInterval
  
  private var mode: Components
  
  private var hourInterval: Int
  private var minuteInterval: Int
  private var secondInterval: Int
  private var minumumDuration: TimeInterval?
  private var maximumDuration: TimeInterval?
 
  // This has to be public to comply with UIViewRepresentable, but we don't actually want it to show up in the doc.
  @_documentation(visibility: internal)
  public func makeUIView(context: Context) -> DurationPicker {
    let timeDurationPicker = DurationPicker()
    
    timeDurationPicker.pickerMode = mode
    timeDurationPicker.hourInterval = hourInterval
    timeDurationPicker.minuteInterval = minuteInterval
    timeDurationPicker.secondInterval = secondInterval
    timeDurationPicker.minimumDuration = minumumDuration
    timeDurationPicker.maximumDuration = maximumDuration
    
    timeDurationPicker.addTarget(context.coordinator, action: #selector(Coordinator.changed(_:)), for: .primaryActionTriggered)
    return timeDurationPicker
  }

  // This has to be public to comply with UIViewRepresentable, but we don't actually want it to show up in the doc.
  @_documentation(visibility: internal)
  public func updateUIView(_ uiView: DurationPicker, context: Context) {
    if (uiView.duration != duration) {
      uiView.duration = duration
    }
    if (uiView.pickerMode != mode) {
      uiView.pickerMode = mode
    }
    if (uiView.hourInterval != hourInterval) {
      uiView.hourInterval = hourInterval
    }
    if (uiView.minuteInterval != minuteInterval) {
      uiView.minuteInterval = minuteInterval
    }
    if (uiView.secondInterval != secondInterval) {
      uiView.secondInterval = secondInterval
    }
    if (uiView.minimumDuration != minumumDuration) {
      uiView.minimumDuration = minumumDuration
    }
    if (uiView.maximumDuration != maximumDuration) {
      uiView.maximumDuration = maximumDuration
    }
  }

  // This has to be public to comply with UIViewRepresentable, but we don't actually want it to show up in the doc.
  @_documentation(visibility: internal)
  public func makeCoordinator() -> DurationPickerView.Coordinator {
    return Coordinator(duration: $duration)
  }
  
  // This has to be public to comply with UIViewRepresentable, but we don't actually want it to show up in the doc.
  @_documentation(visibility: internal)
  public class Coordinator: NSObject {
    private var duration: Binding<TimeInterval>

    init(duration: Binding<TimeInterval>) {
      self.duration = duration
    }

    @objc func changed(_ sender: DurationPicker) {
      self.duration.wrappedValue = sender.duration
    }
  }
}

@available(iOS 17.0,*)
#Preview {
  @Previewable @State var duration: TimeInterval = 60.0 * 30.0
  @Previewable @State var components: DurationPickerView.Components = .hourMinuteSecond
  @Previewable @State var minimumDuration: TimeInterval? = nil
  @Previewable @State var maximumDuration: TimeInterval? = nil
  @Previewable @State var hourInterval: Int = 1
  @Previewable @State var minuteInterval: Int = 1
  @Previewable @State var secondInterval: Int = 1

  // Can't make it case iterable since its defined as an extension.
  let modes: [DurationPickerView.Components] = [.hour, .hourMinute, .hourMinuteSecond, .minute, .minuteSecond, .second]
  
  List {
    DurationPickerView(
      $duration,
      components: components,
      hourInterval: hourInterval,
      minuteInterval: minuteInterval,
      secondInterval: secondInterval,
      minumumDuration: minimumDuration,
      maximumDuration: maximumDuration
    )
    
    LabeledContent {
      Text(Date()..<Date().addingTimeInterval(duration), format: .timeDuration)
    } label: {
      Text("Value")
    }
    
    Picker("Components", selection: $components) {
      ForEach(modes, id: \.self) { mode in
        Text(String(describing: mode))
      }
    }
    
    LabeledContent {
      TextField("Seconds", value: $minimumDuration, format: .number)
    } label: {
      Text("Minimum Duration")
    }
    
    LabeledContent {
      TextField("Seconds", value: $maximumDuration, format: .number)
    } label: {
      Text("Maximum Duration")
    }
    
    LabeledContent {
      TextField("Hour Interval", value: $hourInterval, format: .number)
    } label: {
      Text("Hour Interval")
    }
    
    LabeledContent {
      TextField("Seconds", value: $minuteInterval, format: .number)
    } label: {
      Text("Minute Interval")
    }
    
    LabeledContent {
      TextField("Seconds", value: $secondInterval, format: .number)
    } label: {
      Text("Second Interval")
    }
  }
}
