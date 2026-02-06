class Appointment {
  final String id;
  final String office;
  final String address;
  final DateTime date;
  final String timeSlot;
  final String status;

  Appointment({
    required this.id,
    required this.office,
    required this.address,
    required this.date,
    required this.timeSlot,
    this.status = 'Confermato',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'office': office,
        'address': address,
        'date': date.toIso8601String(),
        'timeSlot': timeSlot,
        'status': status,
      };

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json['id'],
        office: json['office'],
        address: json['address'],
        date: DateTime.parse(json['date']),
        timeSlot: json['timeSlot'],
        status: json['status'] ?? 'Confermato',
      );
}

class Application {
  final String id;
  final String name;
  final String fiscalCode;
  final DateTime birthDate;
  final String status;
  final DateTime submittedDate;
  final String? photoPath;

  Application({
    required this.id,
    required this.name,
    required this.fiscalCode,
    required this.birthDate,
    required this.status,
    required this.submittedDate,
    this.photoPath,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'fiscalCode': fiscalCode,
        'birthDate': birthDate.toIso8601String(),
        'status': status,
        'submittedDate': submittedDate.toIso8601String(),
        'photoPath': photoPath,
      };

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json['id'],
        name: json['name'],
        fiscalCode: json['fiscalCode'],
        birthDate: DateTime.parse(json['birthDate']),
        status: json['status'],
        submittedDate: DateTime.parse(json['submittedDate']),
        photoPath: json['photoPath'],
      );
}

class MunicipalOffice {
  final String name;
  final String address;
  final String city;
  final String phone;
  final List<String> availableSlots;

  MunicipalOffice({
    required this.name,
    required this.address,
    required this.city,
    required this.phone,
    required this.availableSlots,
  });
}

class ChecklistItem {
  final String title;
  final String description;
  bool isCompleted;

  ChecklistItem({
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}