import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/models.dart';

class ApplicationProvider with ChangeNotifier {
  List<Application> _applications = [];
  List<ChecklistItem> _checklist = [];
  
  List<Application> get applications => _applications;
  List<ChecklistItem> get checklist => _checklist;

  ApplicationProvider() {
    loadApplications();
    initializeChecklist();
  }

  void initializeChecklist() {
    _checklist = [
      ChecklistItem(
        title: 'Documento d\'identità scaduto o in scadenza',
        description: 'Porta con te la tua vecchia carta d\'identità',
      ),
      ChecklistItem(
        title: 'Codice fiscale',
        description: 'Tessera sanitaria o documento equivalente',
      ),
      ChecklistItem(
        title: 'Foto recente',
        description: 'Foto tessera formato 35x40mm, sfondo chiaro',
      ),
      ChecklistItem(
        title: 'Pagamento effettuato',
        description: 'Tassa di €22.21 (verifica importo aggiornato)',
      ),
      ChecklistItem(
        title: 'Email personale',
        description: 'Per ricevere comunicazioni sullo stato',
      ),
    ];
    loadChecklistState();
  }

  Future<void> loadChecklistState() async {
    final prefs = await SharedPreferences.getInstance();
    final String? checklistJson = prefs.getString('checklist');
    
    if (checklistJson != null) {
      final List<dynamic> decoded = json.decode(checklistJson);
      for (int i = 0; i < _checklist.length && i < decoded.length; i++) {
        _checklist[i].isCompleted = decoded[i]['isCompleted'] ?? false;
      }
      notifyListeners();
    }
  }

  Future<void> saveChecklistState() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> checklistData = _checklist.map((item) => {
      'isCompleted': item.isCompleted,
    }).toList();
    await prefs.setString('checklist', json.encode(checklistData));
  }

  void toggleChecklistItem(int index) {
    if (index >= 0 && index < _checklist.length) {
      _checklist[index].isCompleted = !_checklist[index].isCompleted;
      saveChecklistState();
      notifyListeners();
    }
  }

  Future<void> loadApplications() async {
    final prefs = await SharedPreferences.getInstance();
    final String? applicationsJson = prefs.getString('applications');
    
    if (applicationsJson != null) {
      final List<dynamic> decoded = json.decode(applicationsJson);
      _applications = decoded.map((item) => Application.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<void> saveApplications() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = json.encode(_applications.map((a) => a.toJson()).toList());
    await prefs.setString('applications', encoded);
  }

  Future<void> addApplication(Application application) async {
    _applications.add(application);
    await saveApplications();
    notifyListeners();
  }

  String getApplicationStatus(String id) {
    final statuses = [
      'Ricevuta',
      'In lavorazione',
      'Approvata',
      'Pronta per il ritiro',
    ];
    
    final app = _applications.firstWhere((a) => a.id == id);
    final daysSinceSubmission = DateTime.now().difference(app.submittedDate).inDays;
    
    if (daysSinceSubmission < 2) return statuses[0];
    if (daysSinceSubmission < 5) return statuses[1];
    if (daysSinceSubmission < 10) return statuses[2];
    return statuses[3];
  }

  double calculateFee({required int age, bool isUrgent = false}) {
    double baseFee = 22.21;
    
    if (age < 3) {
      baseFee = 10.00;
    } else if (age < 18) {
      baseFee = 16.79;
    }
    
    if (isUrgent) {
      baseFee += 5.00;
    }
    
    return baseFee;
  }
}