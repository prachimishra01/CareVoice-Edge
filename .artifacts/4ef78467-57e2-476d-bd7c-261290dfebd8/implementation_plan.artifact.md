# Robust Emergency Communication Implementation Plan

The goal is to ensure that emergency SMS and phone calls are reliably triggered, even if backend logging fails, and that they operate independently of each other.

## User Review Required

> [!IMPORTANT]
> - This implementation relies on the Android `SEND_SMS` and `CALL_PHONE` permissions.
> - Testing the actual SMS and Call functionality **requires a physical Android device with a working SIM card**. It will not work on an emulator.

## Proposed Changes

### Flutter Services

#### [MODIFY] [emergency_manager.dart](file:///D:/Flutter_app/lib/services/emergency_manager.dart)
- Refactor `_executeEmergencyCommunication` to:
    - Prioritize SMS and Phone Call over backend logging.
    - Initiate SMS and Call in parallel or separate try-catch blocks so one failure doesn't stop the other.
    - Move the `apiClient.triggerEmergency` call to the end and ensure its failure is ignored by the primary emergency flow.
    - Add robust phone number validation (trimming and non-empty check).

### Android Native

#### [MODIFY] [MainActivity.kt](file:///D:/Flutter_app/android/app/src/main/kotlin/com/carevoice/carevoice_edge/MainActivity.kt)
- Refine the `SmsManager` acquisition to be compatible across different Android versions while adhering to the latest APIs.
- Ensure `Intent.ACTION_CALL` is correctly handled.

## Verification Plan

### Automated Tests
- `flutter clean`
- `flutter pub get`
- `flutter analyze`
- `flutter build apk --debug` (To ensure native Kotlin changes compile correctly)

### Manual Verification
- **Simulated Test**: Use the "TEST FALL DETECTION" button on an emulator.
    - Verify the 10-second countdown works.
    - Verify that logs show SMS/Call attempts even if the backend URL is invalid/unreachable.
- **Physical Device Test**:
    - Trigger emergency.
    - Verify SMS is sent to the caretaker.
    - Verify the phone dialer opens and initiates a call.
