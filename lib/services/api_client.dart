import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../models/patient.dart';
import '../models/reminder.dart';
import '../models/emergency_event.dart';
import '../models/analytics_summary.dart';
import '../models/live_status.dart';

/// Port of frontend/src/api/client.ts.
/// Android emulators can't reach `localhost` on the host machine, so the
/// default base URL points at the emulator's host loopback alias (10.0.2.2).
/// Physical devices need the host machine's LAN IP, editable in Settings.
class ApiClient {
  static const String defaultBaseUrl = 'http://10.0.2.2:8000/api/v1';
  static const String _prefsKey = 'carevoice_api_base_url';

  String _baseUrl = defaultBaseUrl;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _baseUrl = prefs.getString(_prefsKey) ?? defaultBaseUrl;
  }

  String get baseUrl => _baseUrl;

  Future<void> setBaseUrl(String url) async {
    _baseUrl = url;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, url);
  }

  Map<String, String> get _headers => {'Content-Type': 'application/json'};

  Future<dynamic> _request(
    String endpoint, {
    String method = 'GET',
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    late http.Response response;
    final encodedBody = body != null ? jsonEncode(body) : null;

    switch (method) {
      case 'POST':
        response = await http.post(uri, headers: _headers, body: encodedBody);
        break;
      case 'PUT':
        response = await http.put(uri, headers: _headers, body: encodedBody);
        break;
      case 'DELETE':
        response = await http.delete(uri, headers: _headers);
        break;
      default:
        response = await http.get(uri, headers: _headers);
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      String detail = 'API request failed';
      try {
        final decoded = jsonDecode(response.body);
        detail = decoded['detail']?.toString() ?? detail;
      } catch (_) {}
      throw Exception(detail);
    }

    if (response.body.isEmpty) return null;
    return jsonDecode(response.body);
  }

  // Auth
  Future<User> getCurrentUser() async {
    final json = await _request('/auth/me');
    return User.fromJson(json as Map<String, dynamic>);
  }

  // Patients
  Future<List<Patient>> getPatients() async {
    final json = await _request('/patients') as List<dynamic>;
    return json.map((e) => Patient.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Patient> updatePatient(int id, Map<String, dynamic> data) async {
    final json = await _request('/patients/$id', method: 'PUT', body: data);
    return Patient.fromJson(json as Map<String, dynamic>);
  }

  // Reminders
  Future<List<Reminder>> getReminders({int? patientId}) async {
    final endpoint = patientId != null ? '/reminders?patient_id=$patientId' : '/reminders';
    final json = await _request(endpoint) as List<dynamic>;
    return json.map((e) => Reminder.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Reminder> createReminder(Map<String, dynamic> data) async {
    final json = await _request('/reminders', method: 'POST', body: data);
    return Reminder.fromJson(json as Map<String, dynamic>);
  }

  Future<Reminder> updateReminder(int id, Map<String, dynamic> data) async {
    final json = await _request('/reminders/$id', method: 'PUT', body: data);
    return Reminder.fromJson(json as Map<String, dynamic>);
  }

  Future<void> deleteReminder(int id) async {
    await _request('/reminders/$id', method: 'DELETE');
  }

  Future<dynamic> announceReminder(int id) async {
    return _request('/reminders/$id/announce', method: 'POST');
  }

  Future<dynamic> confirmVoice(int reminderId, String patientSpeech) async {
    return _request('/reminders/confirm-voice',
        method: 'POST', body: {'reminder_id': reminderId, 'patient_speech': patientSpeech});
  }

  // Emergency
  Future<List<EmergencyEvent>> getEmergencies() async {
    final json = await _request('/emergency') as List<dynamic>;
    return json.map((e) => EmergencyEvent.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<EmergencyEvent> triggerEmergency({
    int? patientId,
    required String triggerSource,
    String? speechTranscript,
  }) async {
    final body = <String, dynamic>{'trigger_source': triggerSource};
    if (patientId != null) body['patient_id'] = patientId;
    if (speechTranscript != null) body['speech_transcript'] = speechTranscript;
    final json = await _request('/emergency/trigger', method: 'POST', body: body);
    return EmergencyEvent.fromJson(json as Map<String, dynamic>);
  }

  Future<EmergencyEvent> resolveEmergency(int id, {String? notes}) async {
    final json = await _request('/emergency/$id/resolve', method: 'PUT', body: {'notes': notes});
    return EmergencyEvent.fromJson(json as Map<String, dynamic>);
  }

  Future<dynamic> voiceSos(String transcript) async {
    final endpoint = '/emergency/voice-sos?speech_transcript=${Uri.encodeComponent(transcript)}';
    return _request(endpoint, method: 'POST');
  }

  // Analytics & Live Status
  Future<AnalyticsSummary> getAnalytics() async {
    final json = await _request('/analytics');
    return AnalyticsSummary.fromJson(json as Map<String, dynamic>);
  }

  Future<LiveStatus> getLiveStatus() async {
    final json = await _request('/live-status');
    return LiveStatus.fromJson(json as Map<String, dynamic>);
  }
}

final apiClient = ApiClient();
