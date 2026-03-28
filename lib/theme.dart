import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
//  Cipher — Material 3 Theme
//  Primary: Deep Teal  #1A6B5C
//  Scheme: privacy-first, easy on eyes
// ─────────────────────────────────────────────

class AppTheme {
  AppTheme._();

  // ── Core palette ─────────────────────────────
  static const Color _primary              = Color(0xFF1A6B5C);
  static const Color _onPrimary            = Color(0xFFFFFFFF);
  static const Color _primaryContainer     = Color(0xFFB2DFDB);
  static const Color _onPrimaryContainer   = Color(0xFF00201B);

  static const Color _secondary            = Color(0xFF4A7E74);
  static const Color _onSecondary          = Color(0xFFFFFFFF);
  static const Color _secondaryContainer   = Color(0xFFCCE8E3);
  static const Color _onSecondaryContainer = Color(0xFF051F1C);

  static const Color _tertiary             = Color(0xFF3A6E8A);
  static const Color _onTertiary           = Color(0xFFFFFFFF);
  static const Color _tertiaryContainer    = Color(0xFFBFDEF0);
  static const Color _onTertiaryContainer  = Color(0xFF00202E);

  static const Color _error                = Color(0xFFBA1A1A);
  static const Color _onError              = Color(0xFFFFFFFF);
  static const Color _errorContainer       = Color(0xFFFFDAD6);
  static const Color _onErrorContainer     = Color(0xFF410002);

  // ── Light surface palette ────────────────────
  static const Color _lightBackground              = Color(0xFFF4FBFA);
  static const Color _lightSurface                 = Color(0xFFF4FBFA);
  static const Color _lightOnSurface               = Color(0xFF191C1C);
  static const Color _lightOnSurfaceVariant        = Color(0xFF3F4947);
  static const Color _lightOutline                 = Color(0xFF6F7977);
  static const Color _lightOutlineVariant          = Color(0xFFBFC9C7);
  static const Color _lightSurfaceContainerHighest = Color(0xFFD1DEDD);

  // ── Dark surface palette ─────────────────────
  static const Color _darkPrimary              = Color(0xFF82CFC3);
  static const Color _darkOnPrimary            = Color(0xFF00382F);
  static const Color _darkPrimaryContainer     = Color(0xFF005144);
  static const Color _darkOnPrimaryContainer   = Color(0xFFB2DFDB);

  static const Color _darkSecondary            = Color(0xFFB1CCC7);
  static const Color _darkOnSecondary          = Color(0xFF1C3531);
  static const Color _darkSecondaryContainer   = Color(0xFF32524D);
  static const Color _darkOnSecondaryContainer = Color(0xFFCCE8E3);

  static const Color _darkTertiary             = Color(0xFF9ECDE9);
  static const Color _darkOnTertiary           = Color(0xFF003549);
  static const Color _darkTertiaryContainer    = Color(0xFF1E4D64);
  static const Color _darkOnTertiaryContainer  = Color(0xFFBFDEF0);

  static const Color _darkBackground              = Color(0xFF101414);
  static const Color _darkSurface                 = Color(0xFF101414);
  static const Color _darkOnSurface               = Color(0xFFE0E8E7);
  static const Color _darkOnSurfaceVariant        = Color(0xFFBFC9C7);
  static const Color _darkOutline                 = Color(0xFF899391);
  static const Color _darkOutlineVariant          = Color(0xFF3F4947);
  static const Color _darkSurfaceContainerHighest = Color(0xFF323636);

  // ── Light ColorScheme ────────────────────────
  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness:           Brightness.light,
    primary:              _primary,
    onPrimary:            _onPrimary,
    primaryContainer:     _primaryContainer,
    onPrimaryContainer:   _onPrimaryContainer,
    secondary:            _secondary,
    onSecondary:          _onSecondary,
    secondaryContainer:   _secondaryContainer,
    onSecondaryContainer: _onSecondaryContainer,
    tertiary:             _tertiary,
    onTertiary:           _onTertiary,
    tertiaryContainer:    _tertiaryContainer,
    onTertiaryContainer:  _onTertiaryContainer,
    error:                _error,
    onError:              _onError,
    errorContainer:       _errorContainer,
    onErrorContainer:     _onErrorContainer,
    surface:              _lightSurface,
    onSurface:            _lightOnSurface,
    surfaceContainerHighest: _lightSurfaceContainerHighest,
    onSurfaceVariant:     _lightOnSurfaceVariant,
    outline:              _lightOutline,
    outlineVariant:       _lightOutlineVariant,
    shadow:               Color(0xFF000000),
    scrim:                Color(0xFF000000),
    inverseSurface:       Color(0xFF2D3131),
    onInverseSurface:     Color(0xFFEBF2F1),
    inversePrimary:       Color(0xFF82CFC3),
  );

  // ── Dark ColorScheme ─────────────────────────
  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness:           Brightness.dark,
    primary:              _darkPrimary,
    onPrimary:            _darkOnPrimary,
    primaryContainer:     _darkPrimaryContainer,
    onPrimaryContainer:   _darkOnPrimaryContainer,
    secondary:            _darkSecondary,
    onSecondary:          _darkOnSecondary,
    secondaryContainer:   _darkSecondaryContainer,
    onSecondaryContainer: _darkOnSecondaryContainer,
    tertiary:             _darkTertiary,
    onTertiary:           _darkOnTertiary,
    tertiaryContainer:    _darkTertiaryContainer,
    onTertiaryContainer:  _darkOnTertiaryContainer,
    error:                Color(0xFFFFB4AB),
    onError:              Color(0xFF690005),
    errorContainer:       Color(0xFF93000A),
    onErrorContainer:     Color(0xFFFFDAD6),
    surface:              _darkSurface,
    onSurface:            _darkOnSurface,
    surfaceContainerHighest: _darkSurfaceContainerHighest,
    onSurfaceVariant:     _darkOnSurfaceVariant,
    outline:              _darkOutline,
    outlineVariant:       _darkOutlineVariant,
    shadow:               Color(0xFF000000),
    scrim:                Color(0xFF000000),
    inverseSurface:       Color(0xFFE0E8E7),
    onInverseSurface:     Color(0xFF2D3131),
    inversePrimary:       _primary,
  );

  // ── Text theme ───────────────────────────────
  static TextTheme _buildTextTheme(ColorScheme cs) => TextTheme(
    displayLarge:  TextStyle(fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.25, color: cs.onSurface),
    displayMedium: TextStyle(fontSize: 45, fontWeight: FontWeight.w300, color: cs.onSurface),
    displaySmall:  TextStyle(fontSize: 36, fontWeight: FontWeight.w400, color: cs.onSurface),
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600, color: cs.onSurface),
    headlineMedium:TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: cs.onSurface),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: cs.onSurface),
    titleLarge:    TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: cs.onSurface),
    titleMedium:   TextStyle(fontSize: 16, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: cs.onSurface),
    titleSmall:    TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1,  color: cs.onSurface),
    bodyLarge:     TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5,  color: cs.onSurface),
    bodyMedium:    TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: cs.onSurface),
    bodySmall:     TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4,  color: cs.onSurface),
    labelLarge:    TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1,  color: cs.onSurface),
    labelMedium:   TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.5,  color: cs.onSurface),
    labelSmall:    TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5,  color: cs.onSurface),
  );

  // ── Component themes ─────────────────────────
  static ({
    AppBarTheme appBarTheme,
    ElevatedButtonThemeData elevatedButtonTheme,
    FilledButtonThemeData filledButtonTheme,
    OutlinedButtonThemeData outlinedButtonTheme,
    TextButtonThemeData textButtonTheme,
    InputDecorationTheme inputDecorationTheme,
    CardThemeData cardTheme,
    ChipThemeData chipTheme,
    FloatingActionButtonThemeData floatingActionButtonTheme,
    NavigationBarThemeData navigationBarTheme,
    SnackBarThemeData snackBarTheme,
    DividerThemeData dividerTheme,
    ListTileThemeData listTileTheme,
    SwitchThemeData switchTheme,
  }) _buildComponents(ColorScheme cs) => (
    appBarTheme: AppBarTheme(
      backgroundColor: cs.surface,
      foregroundColor: cs.onSurface,
      elevation: 0,
      scrolledUnderElevation: 1,
      centerTitle: false,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size(64, 48),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: cs.outlineVariant),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: cs.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: cs.secondaryContainer,
      labelStyle: TextStyle(color: cs.onSecondaryContainer),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: cs.primaryContainer,
      foregroundColor: cs.onPrimaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: cs.surface,
      indicatorColor: cs.primaryContainer,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: cs.onPrimaryContainer);
        }
        return IconThemeData(color: cs.onSurfaceVariant);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(color: cs.primary, fontWeight: FontWeight.w600, fontSize: 12);
        }
        return TextStyle(color: cs.onSurfaceVariant, fontSize: 12);
      }),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: cs.inverseSurface,
      contentTextStyle: TextStyle(color: cs.onInverseSurface),
      actionTextColor: cs.inversePrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      behavior: SnackBarBehavior.floating,
    ),
    dividerTheme: DividerThemeData(
      color: cs.outlineVariant,
      thickness: 0.5,
      space: 0,
    ),
    listTileTheme: ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return cs.onPrimary;
        return cs.outline;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return cs.primary;
        return cs.surfaceContainerHighest;
      }),
    ),
  );

  // ── Public ThemeData getters ─────────────────
  static ThemeData get light {
    final cs   = _lightColorScheme;
    final comp = _buildComponents(cs);
    return ThemeData(
      useMaterial3:              true,
      colorScheme:               cs,
      textTheme:                 _buildTextTheme(cs),
      scaffoldBackgroundColor:   _lightBackground,
      appBarTheme:               comp.appBarTheme,
      elevatedButtonTheme:       comp.elevatedButtonTheme,
      filledButtonTheme:         comp.filledButtonTheme,
      outlinedButtonTheme:       comp.outlinedButtonTheme,
      textButtonTheme:           comp.textButtonTheme,
      inputDecorationTheme:      comp.inputDecorationTheme,
      cardTheme:                 comp.cardTheme,
      chipTheme:                 comp.chipTheme,
      floatingActionButtonTheme: comp.floatingActionButtonTheme,
      navigationBarTheme:        comp.navigationBarTheme,
      snackBarTheme:             comp.snackBarTheme,
      dividerTheme:              comp.dividerTheme,
      listTileTheme:             comp.listTileTheme,
      switchTheme:               comp.switchTheme,
    );
  }

  static ThemeData get dark {
    final cs   = _darkColorScheme;
    final comp = _buildComponents(cs);
    return ThemeData(
      useMaterial3:              true,
      colorScheme:               cs,
      textTheme:                 _buildTextTheme(cs),
      scaffoldBackgroundColor:   _darkBackground,
      appBarTheme:               comp.appBarTheme,
      elevatedButtonTheme:       comp.elevatedButtonTheme,
      filledButtonTheme:         comp.filledButtonTheme,
      outlinedButtonTheme:       comp.outlinedButtonTheme,
      textButtonTheme:           comp.textButtonTheme,
      inputDecorationTheme:      comp.inputDecorationTheme,
      cardTheme:                 comp.cardTheme,
      chipTheme:                 comp.chipTheme,
      floatingActionButtonTheme: comp.floatingActionButtonTheme,
      navigationBarTheme:        comp.navigationBarTheme,
      snackBarTheme:             comp.snackBarTheme,
      dividerTheme:              comp.dividerTheme,
      listTileTheme:             comp.listTileTheme,
      switchTheme:               comp.switchTheme,
    );
  }
}