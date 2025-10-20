# GeometryReaderSample

A SwiftUI sample project demonstrating how to pass button functionality from a list view to the NavigationBar using GeometryReader and related techniques.

## Overview

This project showcases advanced SwiftUI layout techniques, specifically focusing on `GeometryReader` and the modern `onGeometryChange()` modifier to dynamically control UI elements based on scroll position and view geometry. The main implementation is found in `BlogListView`, which demonstrates how to create a collapsing navigation bar effect based on scroll position.

## Screenshots

<div align="center">
  <img width="420" height="912" alt="screenshot1" src="https://github.com/user-attachments/assets/8ae1e64f-af34-4983-ad41-082cb421f676" alt="Main View"/>
  <img width="420" height="912" alt="screenshot2" src="https://github.com/user-attachments/assets/f149831f-d0ba-45b4-ae7f-7987d4121676" alt="Scrolled View"/>
</div>

## Key Features

- **Dynamic Navigation Bar**: Navigation bar elements that respond to scroll position
- **GeometryReader Integration**: Demonstrates practical use of GeometryReader for layout calculations
- **Scroll Position Detection**: Detects when content crosses specific thresholds
- **Smooth Animations**: Animated transitions based on geometry changes

## Technical Implementation

### GeometryReader Usage

The project demonstrates two approaches to monitoring view geometry:

#### Traditional Approach (iOS 14+)

```swift
GeometryReader { geo in
    let minY = geo.frame(in: .global).minY
    Color.clear
        .onChange(of: minY) { _, newValue in
            withAnimation(.easeInOut(duration: 0.15)) {
                isCollapsed = newValue < 100
            }
        }
}
.frame(height: 1)
```

This approach uses `GeometryReader` to monitor the global Y position of a view anchor. When the view scrolls past a threshold (100 points), it triggers a state change that can affect the navigation bar appearance.

**Key Points:**
- `GeometryReader` provides access to the view's geometry through a `GeometryProxy`
- `.frame(in: .global)` returns the view's position in global coordinate space
- `onChange(of:)` monitors changes to the calculated position
- A transparent `Color.clear` acts as an invisible anchor point

#### Modern Approach (iOS 18+)

```swift
Color.clear
    .frame(height: 1)
    .onGeometryChange(for: CGFloat.self) { proxy in
        proxy.frame(in: .global).minY
    } action: { newMinY in
        withAnimation(.easeInOut(duration: 0.15)) {
            isCollapsed = newMinY < 100
        }
    }
```

The `onGeometryChange()` modifier provides a cleaner, more performant alternative:

**Advantages:**
- No need for nested `GeometryReader` structure
- Doesn't affect layout hierarchy
- Better performance with lazy containers
- More declarative syntax
- Only triggers when the monitored value actually changes

### BlogListView Architecture

The `BlogListView` serves as the main demonstration component, implementing:

1. **Scroll Detection**: Monitors scroll position using geometry tracking
2. **State Management**: Uses `@State` to control UI element visibility
3. **Conditional Rendering**: Shows/hides navigation elements based on scroll position
4. **Smooth Transitions**: Applies animations to state changes for polished UX

### Coordinate Spaces

The project demonstrates understanding of SwiftUI's coordinate spaces:

- **`.global`**: Screen-level coordinate system
- **`.local`**: Parent view's coordinate system
- **`.named("custom")`**: Custom coordinate spaces for specific use cases

## Requirements

- iOS 14.0+ (for GeometryReader + onChange)
- iOS 18.0+ (for onGeometryChange - optional)
- Xcode 13.0+
- Swift 5.5+

## Usage

### Basic Integration

To implement similar functionality in your project:

1. Add a geometry anchor at the top of your scrollable content
2. Monitor the anchor's position using either approach
3. Update state based on position thresholds
4. Apply animations for smooth transitions

### Example Implementation

```swift
struct MyListView: View {
    @State private var isNavigationCollapsed = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Anchor point for scroll detection
                    Color.clear
                        .frame(height: 1)
                        .onGeometryChange(for: CGFloat.self) { proxy in
                            proxy.frame(in: .global).minY
                        } action: { minY in
                            withAnimation {
                                isNavigationCollapsed = minY < 100
                            }
                        }
                    
                    // Your content here
                    ForEach(items) { item in
                        ItemRow(item: item)
                    }
                }
            }
            .navigationTitle("My List")
            .toolbar {
                if !isNavigationCollapsed {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Action") {
                            // Action
                        }
                    }
                }
            }
        }
    }
}
```

## Performance Considerations

### GeometryReader Limitations

- Creates a container that takes up all available space
- Can cause unexpected layout behavior in List and LazyVStack
- Triggers view updates on every geometry change

### onGeometryChange Benefits

- Doesn't affect layout hierarchy
- Only triggers on actual value changes (Equatable-based)
- Optimized for use with lazy containers
- Reduces unnecessary view updates

## Best Practices

1. **Use Minimal Height**: Keep geometry tracking views small (`height: 1`)
2. **Threshold-Based Logic**: Use clear thresholds for state changes
3. **Animation Consistency**: Apply consistent animation durations
4. **iOS Version Checking**: Provide fallbacks for older iOS versions
5. **Avoid Overuse**: Only track geometry when necessary

## Code Structure

```
GeometoryReaderSample/
├── BlogListView.swift          # Main demonstration view
├── ContentView.swift           # Entry point
└── Supporting Files/
    └── Assets.xcassets
```

## Learning Resources

### GeometryReader Concepts
- Understanding SwiftUI's layout system
- Coordinate space transformations
- View geometry calculations

### State Management
- Using @State for view updates
- Binding and data flow
- Animation integration

### Modern Alternatives
- onGeometryChange() for iOS 18+
- PreferenceKey for complex scenarios
- Custom layout protocols

## Migration Guide

### From GeometryReader to onGeometryChange

If you're updating existing code to use the modern approach:

**Before (iOS 14-17):**
```swift
GeometryReader { geo in
    let value = geo.frame(in: .global).minY
    Color.clear.onChange(of: value) { _, newValue in
        // Handle change
    }
}
```

**After (iOS 18+):**
```swift
Color.clear
    .onGeometryChange(for: CGFloat.self) { proxy in
        proxy.frame(in: .global).minY
    } action: { newValue in
        // Handle change
    }
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is available under the MIT license. See the LICENSE file for more info.

## Author

**Kaname Noto** ([@notoroid](https://github.com/notoroid))

## Related Projects

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [GeometryReader Official Docs](https://developer.apple.com/documentation/swiftui/geometryreader)
- [WWDC Sessions on SwiftUI](https://developer.apple.com/videos/swiftui)

## Acknowledgments

This sample demonstrates practical implementation patterns for:
- Dynamic navigation bar behavior
- Scroll-based UI transformations
- Modern SwiftUI geometry tracking techniques
- Performance optimization in list views

---

**Note**: Replace the screenshot placeholders with actual screenshots from your running application to complete the documentation.
