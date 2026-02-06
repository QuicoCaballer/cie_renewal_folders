import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import '../providers/application_provider.dart';
import '../models/models.dart';

class TrackingScreen extends StatefulWidget {
  final Map<String, String>? scannedData;
  
  const TrackingScreen({super.key, this.scannedData});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _fiscalCodeController = TextEditingController();
  DateTime _birthDate = DateTime(1990, 1, 1);
  
  @override
  void initState() {
    super.initState();
    
    // Auto-completar con datos escaneados
    if (widget.scannedData != null) {
      final data = widget.scannedData!;
      
      // Nombre completo
      String fullName = '';
      if (data['name'] != null && data['surname'] != null) {
        fullName = '${data['name']} ${data['surname']}';
      } else if (data['name'] != null) {
        fullName = data['name']!;
      }
      
      if (fullName.isNotEmpty) {
        _nameController.text = fullName;
      }
      
      // Fecha de nacimiento
      if (data['birthDate'] != null) {
        try {
          final parts = data['birthDate']!.split('/');
          if (parts.length == 3) {
            _birthDate = DateTime(
              int.parse(parts[2]),
              int.parse(parts[1]),
              int.parse(parts[0]),
            );
          }
        } catch (e) {
          debugPrint('Error al parsear fecha: $e');
        }
      }
      
      // Generar Codice Fiscale simulado basado en nombre y fecha
      if (data['surname'] != null && data['name'] != null && data['birthDate'] != null) {
        final cf = _generateCodiceFiscale(
          data['surname']!,
          data['name']!,
          _birthDate,
          data['sex'] ?? 'M',
        );
        _fiscalCodeController.text = cf;
      }
      
      // Mostrar mensaje de confirmación
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: const [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text('Dati CIE caricati automaticamente!'),
                  ),
                ],
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
    }
  }
  
  String _generateCodiceFiscale(String surname, String name, DateTime birthDate, String sex) {
    // Genera un Codice Fiscale simulado (NO OFICIAL, solo para demo)
    // En producción, se debería usar una librería oficial o API
    
    String getConsonants(String str) {
      return str.toUpperCase().replaceAll(RegExp(r'[AEIOU\s]'), '');
    }
    
    String getVowels(String str) {
      return str.toUpperCase().replaceAll(RegExp(r'[^AEIOU]'), '');
    }
    
    String padString(String str, int length) {
      return (str + 'XXX').substring(0, length);
    }
    
    // Apellido (3 consonantes)
    String surnameCode = padString(getConsonants(surname) + getVowels(surname), 3);
    
    // Nombre (3 consonantes, con regla especial si hay más de 3)
    String nameConsonants = getConsonants(name);
    String nameCode = nameConsonants.length > 3 
        ? nameConsonants[0] + nameConsonants[2] + nameConsonants[3]
        : padString(nameConsonants + getVowels(name), 3);
    
    // Año (últimos 2 dígitos)
    String yearCode = birthDate.year.toString().substring(2);
    
    // Mes (letra)
    const months = 'ABCDEHLMPRST';
    String monthCode = months[birthDate.month - 1];
    
    // Día (40 si es mujer)
    int day = birthDate.day;
    if (sex.toUpperCase().startsWith('F')) {
      day += 40;
    }
    String dayCode = day.toString().padLeft(2, '0');
    
    // Código común (simulado)
    String placeCode = 'H501'; // Roma como ejemplo
    
    // Carácter de control (simplificado)
    String checkChar = 'Z';
    
    return '$surnameCode$nameCode$yearCode$monthCode$dayCode$placeCode$checkChar';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _fiscalCodeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthDate) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  void _submitApplication(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final applicationProvider = Provider.of<ApplicationProvider>(context, listen: false);
      
      final application = Application(
        id: const Uuid().v4().substring(0, 8).toUpperCase(),
        name: _nameController.text,
        fiscalCode: _fiscalCodeController.text.toUpperCase(),
        birthDate: _birthDate,
        status: 'Ricevuta',
        submittedDate: DateTime.now(),
      );
      
      applicationProvider.addApplication(application);
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Richiesta inviata!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('La tua richiesta è stata registrata con successo.'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Codice di tracciamento:',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      application.id,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Conserva questo codice per tracciare la tua richiesta',
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _nameController.clear();
                _fiscalCodeController.clear();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traccia Richiesta'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Consumer<ApplicationProvider>(
        builder: (context, applicationProvider, child) {
          return ListView(
            padding: const EdgeInsets.all(24),
            children: [
              // Existing applications
              if (applicationProvider.applications.isNotEmpty) ...[
                const Text(
                  'Le tue richieste',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...applicationProvider.applications.map((app) {
                  final status = applicationProvider.getApplicationStatus(app.id);
                  final statusColor = _getStatusColor(status);
                  final statusIcon = _getStatusIcon(status);
                  
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ExpansionTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(statusIcon, color: statusColor),
                      ),
                      title: Text(
                        app.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Codice: ${app.id}'),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow('Codice Fiscale', app.fiscalCode),
                              _buildInfoRow('Data di nascita', 
                                DateFormat('dd/MM/yyyy').format(app.birthDate)),
                              _buildInfoRow('Data richiesta', 
                                DateFormat('dd/MM/yyyy HH:mm').format(app.submittedDate)),
                              const SizedBox(height: 16),
                              const Divider(),
                              const SizedBox(height: 16),
                              
                              // Timeline
                              _buildTimeline(context, status),
                              
                              const SizedBox(height: 16),
                              
                              if (status == 'Pronta per il ritiro')
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.green.shade200),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.check_circle, color: Colors.green.shade700),
                                      const SizedBox(width: 12),
                                      const Expanded(
                                        child: Text(
                                          'La tua CIE è pronta! Puoi ritirarla presso l\'ufficio dove hai fatto richiesta.',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 32),
              ],
              
              // New application form
              const Text(
                'Nuova richiesta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Compila il form per registrare una nuova richiesta di CIE',
                style: TextStyle(color: Colors.grey),
              ),
              if (widget.scannedData != null)
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.qr_code_scanner, color: Colors.green.shade700),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Dati caricati dalla scansione CIE',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nome e Cognome',
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obbligatorio';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    TextFormField(
                      controller: _fiscalCodeController,
                      decoration: InputDecoration(
                        labelText: 'Codice Fiscale',
                        prefixIcon: const Icon(Icons.badge),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      textCapitalization: TextCapitalization.characters,
                      maxLength: 16,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Campo obbligatorio';
                        }
                        if (value.length != 16) {
                          return 'Il codice fiscale deve essere di 16 caratteri';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    InkWell(
                      onTap: () => _selectDate(context),
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Data di nascita',
                          prefixIcon: const Icon(Icons.calendar_today),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(_birthDate),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    ElevatedButton(
                      onPressed: () => _submitApplication(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text('Registra richiesta'),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info, color: Colors.blue.shade700),
                        const SizedBox(width: 8),
                        Text(
                          'Tempi di rilascio',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'La CIE viene rilasciata generalmente entro 6 giorni lavorativi dalla richiesta. Riceverai una notifica quando sarà pronta per il ritiro.',
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context, String currentStatus) {
    final statuses = [
      {'title': 'Ricevuta', 'icon': Icons.receipt},
      {'title': 'In lavorazione', 'icon': Icons.build},
      {'title': 'Approvata', 'icon': Icons.check},
      {'title': 'Pronta per il ritiro', 'icon': Icons.done_all},
    ];
    
    final currentIndex = statuses.indexWhere((s) => s['title'] == currentStatus);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stato della pratica',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 16),
        ...List.generate(statuses.length, (index) {
          final status = statuses[index];
          final isCompleted = index <= currentIndex;
          final isLast = index == statuses.length - 1;
          
          return Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isCompleted 
                          ? Theme.of(context).colorScheme.primary 
                          : Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      status['icon'] as IconData,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 40,
                      color: isCompleted 
                          ? Theme.of(context).colorScheme.primary 
                          : Colors.grey.shade300,
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  status['title'] as String,
                  style: TextStyle(
                    fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                    color: isCompleted ? Colors.black : Colors.grey,
                  ),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Ricevuta':
        return Colors.blue;
      case 'In lavorazione':
        return Colors.orange;
      case 'Approvata':
        return Colors.purple;
      case 'Pronta per il ritiro':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Ricevuta':
        return Icons.receipt;
      case 'In lavorazione':
        return Icons.build;
      case 'Approvata':
        return Icons.check_circle;
      case 'Pronta per il ritiro':
        return Icons.done_all;
      default:
        return Icons.info;
    }
  }
}