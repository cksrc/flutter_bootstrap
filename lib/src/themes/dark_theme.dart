import 'package:flutter/material.dart';

class DarkTheme {
  static final DarkTheme _singleton = DarkTheme._constructor();
  DarkTheme._constructor();
  static DarkTheme get instance => _singleton;

  static const primary = Color(0xFFa1cbb5);
  static const primaryLighter = Color(0xFFC0DBCD);
  static const primaryDarker = Color(0xFF385F4D);
  static const secondary = Color(0xFFFFE46D);
  static const secondaryDarker = Color(0xFFffcc00);
  static const tertiary = Color(0xFF9F67B9);
  static const background = Color(0xFFC0DBCD);
  static const surface = Color(0xFFC0DBCD);
  static const error = Color(0xFFfc4b4b);
  static const onPrimary = Color(0xFF000000);
  static const onSecondary = Color(0xFF000000);

  static const fontFamily = 'Montserrat';
  static const TextStyle display1 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 34,
      letterSpacing: 0.25);

  static const TextStyle headline = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 24,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    letterSpacing: 0.15,
  );

  static const TextStyle subtitle1 = TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      letterSpacing: 0.15);
  static const TextStyle subtitle2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.1,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.25,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static const TextStyle button = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 1.25,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.4,
  );

  static const TextTheme textTheme = TextTheme(
    headline4: display1,
    headline5:
        headline, // Used for large text in dialogs (e.g., the month and year in the dialog)
    headline6:
        title, // Used for the primary text in app bars and dialogs (e.g., [AppBar.title]
    subtitle1:
        subtitle1, // Used for the primary text in lists (e.g., [ListTile.title]
    subtitle2:
        subtitle2, // For medium emphasis text that's a little smaller than
    bodyText2: body2, // The default body text style
    bodyText1: body1, // The emphasized body text
    button: button, // For button text
    caption: caption, // For image captions
  );

  ThemeData theme = ThemeData.dark().copyWith(
    colorScheme: const ColorScheme.dark(
        primary:
            primary, // The color displayed most frequently across your app’s screens and components.
        primaryContainer:
            primaryDarker, // A darker version of the primary color.
        secondary:
            secondary, // An accent color that, when used sparingly, calls attention to parts of your app.
        secondaryContainer:
            secondary, // A darker version of the secondary color.
        background:
            background, //A color that typically appears behind scrollable content.
        surface: surface, // The background color for widgets like Card.
        error: error, //The color to use for input validation errors
        onPrimary:
            onPrimary, //A color that's clearly legible when drawn on primary.
        onSecondary:
            onSecondary, // A color that's clearly legible when drawn on secondary
        brightness: Brightness.dark),
    // textTheme: textTheme,
  );
}
