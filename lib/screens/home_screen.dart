import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/appointment_provider.dart';
import '../providers/application_provider.dart';
import 'appointment_screen.dart';
import 'photo_validator_screen.dart';
import 'checklist_screen.dart';
import 'tracking_screen.dart';
import 'requirements_screen.dart';
import 'barcode_scanner_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildDataRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.credit_card,
                      size: 64,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Rinnovo CIE',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Gestisci il rinnovo della tua Carta d\'Identità Elettronica',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      _MenuCard(
                        icon: Icons.qr_code_scanner,
                        title: 'Scansiona CIE',
                        description: 'Leggi il codice a barre per auto-compilare',
                        color: Colors.teal,
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BarcodeScannerScreen(),
                            ),
                          );
                          
                          if (result != null && result is Map<String, String>) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: Colors.green),
                                    const SizedBox(width: 12),
                                    const Text('CIE Scansionata'),
                                  ],
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.green.shade50,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (result['surname'] != null) ...[
                                              _buildDataRow('Cognome', result['surname']!),
                                              const SizedBox(height: 8),
                                            ],
                                            if (result['name'] != null) ...[
                                              _buildDataRow('Nome', result['name']!),
                                              const SizedBox(height: 8),
                                            ],
                                            if (result['birthDate'] != null) ...[
                                              _buildDataRow('Data di nascita', result['birthDate']!),
                                              const SizedBox(height: 8),
                                            ],
                                            if (result['sex'] != null) ...[
                                              _buildDataRow('Sesso', result['sex']!),
                                              const SizedBox(height: 8),
                                            ],
                                            if (result['documentNumber'] != null) ...[
                                              _buildDataRow('Numero documento', result['documentNumber']!),
                                              const SizedBox(height: 8),
                                            ],
                                            if (result['expiryDate'] != null) ...[
                                              _buildDataRow('Data di scadenza', result['expiryDate']!),
                                              const SizedBox(height: 8),
                                            ],
                                            if (result['country'] != null) ...[
                                              _buildDataRow('Paese', result['country']!),
                                            ],
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Puoi usare questi dati per compilare automaticamente il modulo di richiesta.',
                                        style: TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Chiudi'),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => TrackingScreen(
                                            scannedData: result,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.arrow_forward),
                                    label: const Text('Vai a Traccia Richiesta'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).colorScheme.primary,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                      ),
                      
                      _MenuCard(
                        icon: Icons.checklist_rounded,
                        title: 'Verifica Requisiti',
                        description: 'Scopri cosa ti serve per il rinnovo',
                        color: Colors.blue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RequirementsScreen(),
                            ),
                          );
                        },
                      ),
                      
                      _MenuCard(
                        icon: Icons.photo_camera,
                        title: 'Valida Foto',
                        description: 'Verifica che la tua foto sia conforme',
                        color: Colors.purple,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PhotoValidatorScreen(),
                            ),
                          );
                        },
                      ),
                      
                      _MenuCard(
                        icon: Icons.calendar_today,
                        title: 'Prenota Appuntamento',
                        description: 'Prenota la tua visita in comune',
                        color: Colors.green,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AppointmentScreen(),
                            ),
                          );
                        },
                      ),
                      
                      _MenuCard(
                        icon: Icons.list_alt,
                        title: 'Checklist Documenti',
                        description: 'Prepara tutto il necessario',
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChecklistScreen(),
                            ),
                          );
                        },
                      ),
                      
                      _MenuCard(
                        icon: Icons.track_changes,
                        title: 'Traccia Richiesta',
                        description: 'Monitora lo stato della tua pratica',
                        color: Colors.red,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TrackingScreen(),
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      Consumer2<AppointmentProvider, ApplicationProvider>(
                        builder: (context, appointmentProvider, applicationProvider, child) {
                          return Card(
                            color: Colors.grey.shade50,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _StatItem(
                                    icon: Icons.event_available,
                                    label: 'Appuntamenti',
                                    value: '${appointmentProvider.appointments.length}',
                                  ),
                                  _StatItem(
                                    icon: Icons.description,
                                    label: 'Pratiche',
                                    value: '${applicationProvider.applications.length}',
                                  ),
                                  _StatItem(
                                    icon: Icons.check_circle,
                                    label: 'Completati',
                                    value: '${applicationProvider.checklist.where((c) => c.isCompleted).length}/${applicationProvider.checklist.length}',
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _MenuCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey.shade400),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}