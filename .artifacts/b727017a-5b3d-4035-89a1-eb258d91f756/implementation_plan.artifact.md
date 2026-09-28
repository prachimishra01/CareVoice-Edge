# UI/UX Redesign Implementation Plan

Overhaul the CareVoice Edge Flutter application to a modern, clean, and animated UI inspired by the provided reference design. This includes fixing layout overflows, implementing a custom navigation bar, and introducing a light theme with soft aesthetics.

## User Review Required

> [!IMPORTANT]
> This plan involves switching from a Dark Theme to a Light Theme by default, as suggested by the reference image. Please confirm if this is desired.

> [!WARNING]
> Changing the navigation structure to a custom floating bar might slightly change how users interact with the app.

## Proposed Changes

### Theme & Styling

#### [MODIFY] [app_theme.dart](file:///E:/CareVoice-Edge-main/CareVoice-Edge-main/Flutter_app/lib/theme/app_theme.dart)
- Define a new `light` theme with a pastel color palette:
    - Background: Light gray/white.
    - Primary: Soft Indigo/Lavender.
    - Secondary: Mint/Emerald.
    - Card: White with subtle shadows and blur (Glassmorphism).

### Components & Widgets

#### [MODIFY] [stat_card.dart](file:///E:/CareVoice-Edge-main/CareVoice-Edge-main/Flutter_app/lib/widgets/stat_card.dart)
- Redesign the card layout to be more compact.
- Use `FittedBox` or responsive font sizes to prevent overflows.
- Add subtle entry animations.

#### [NEW] [custom_nav_bar.dart](file:///E:/CareVoice-Edge-main/CareVoice-Edge-main/Flutter_app/lib/widgets/custom_nav_bar.dart)
- Create a floating, animated bottom navigation bar.
- Include a prominent center button for quick actions (e.g., adding a reminder).

#### [MODIFY] [glass_card.dart](file:///E:/CareVoice-Edge-main/CareVoice-Edge-main/Flutter_app/lib/widgets/glass_card.dart)
- Enhance the glass effect to look better in both light and dark modes.

### Dashboard & Navigation

#### [MODIFY] [root_shell.dart](file:///E:/CareVoice-Edge-main/CareVoice-Edge-main/Flutter_app/lib/screens/root_shell.dart)
- Integrate the new `CustomNavBar`.
- Improve the AppBar design with a cleaner, more modern look.

#### [MODIFY] [dashboard_screen.dart](file:///E:/CareVoice-Edge-main/CareVoice-Edge-main/Flutter_app/lib/screens/dashboard_screen.dart)
- Adjust the `GridView` layout to be responsive.
- Add a new `HealthTrendChart` widget using `fl_chart`.
- Implement entry animations for all cards.

## Verification Plan

### Automated Tests
- Build the app to ensure no compilation errors.
- Verify that `minSdk` and `compileSdk` changes from previous steps are maintained.

### Manual Verification
- Verify the UI on an emulator (or screenshot tool if available).
- Check for any layout overflows on different screen sizes.
- Test the custom navigation bar functionality.
