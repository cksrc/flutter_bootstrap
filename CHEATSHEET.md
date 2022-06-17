# State Management

Flutter is declarative. This means that when the state of the app changes, the user interface is redrawn to reflect the change.

- state is “whatever data you need in order to rebuild your UI at any moment in time”.
- You can have **Local/Ephemeral** and **Shared/App** state management.
- Local state refers to data that may affect the UI of a single widget. Local state management can be handled with a StatefulWidget. No need for state management packages. Restrict SatefulWidgets only to the elements that need to be redrawn for a specific change in order to minimize the load.
- Shared state is any data that needs to be shared across many widgets. For example, changing theme from Dark to Light.
- There are different packages for App state management but the most recommended is provider:

  `flutter pub add provider`

- To create a provider we create a class that extends `ChangeNotifier`.
- To use the Provider we have to declare it in a parent widget
  - `ChangeNotifierProvider()`

## Common errors

### Error

`Please specify a platform for this target in your Podfile`

To use firebase you need to update app/ios/Podfile from minimum supported ios 9 to 10:

`platform :ios, '10.0'`

`https://stackoverflow.com/a/72117620/447738`
