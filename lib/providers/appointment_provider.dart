import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/models.dart';

class AppointmentProvider with ChangeNotifier {
  List<Appointment> _appointments = [];
  
  List<Appointment> get appointments => _appointments;

  AppointmentProvider() {
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final String? appointmentsJson = prefs.getString('appointments');
    
    if (appointmentsJson != null) {
      final List<dynamic> decoded = json.decode(appointmentsJson);
      _appointments = decoded.map((item) => Appointment.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> saveAppointments() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(_appointments.map((a) => a.toJson()).toList());
    await prefs.setString('appointments', encoded);
  }

  Future<void> addAppointment(Appointment appointment) async {
    _appointments.add(appointment);
    await saveAppointments();
    notifyListeners();
  }

  Future<void> cancelAppointment(String id) async {
    _appointments.removeWhere((a) => a.id == id);
    await saveAppointments();
    notifyListeners();
  }

  List<MunicipalOffice> getOffices() {
    return [
      MunicipalOffice(
        name: 'Comune di Milano - Centro',
        address: 'Via Larga 12',
        city: 'Milano',
        phone: '02 88451',
        availableSlots: ['09:00', '10:00', '11:00', '14:00', '15:00', '16:00'],
      ),
      MunicipalOffice(
        name: 'Comune di Milano - Zona 2',
        address: 'Via Tonale 27',
        city: 'Milano',
        phone: '02 88452',
        availableSlots: ['09:30', '10:30', '11:30', '14:30', '15:30'],
      ),
      MunicipalOffice(
        name: 'Comune di Roma - EUR',
        address: 'Viale Europa 175',
        city: 'Roma',
        phone: '06 67101',
        availableSlots: ['09:00', '10:00', '11:00', '12:00', '15:00', '16:00'],
      ),
      MunicipalOffice(
        name: 'Comune di Torino - Centro',
        address: 'Piazza Palazzo di Città 1',
        city: 'Torino',
        phone: '011 011',
        availableSlots: ['09:00', '10:30', '12:00', '14:00', '15:30'],
      ),
    ];
  }
}