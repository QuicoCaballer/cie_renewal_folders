import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/application_provider.dart';

class RequirementsScreen extends StatefulWidget {
  const RequirementsScreen({super.key});

  @override
  State<RequirementsScreen> createState() => _RequirementsScreenState();
}

class _RequirementsScreenState extends State<RequirementsScreen> {
  int _age = 30;
  bool _isUrgent = false;
  bool _isFirstTime = false;

  @override
  Widget build(BuildContext context) {
    final applicationProvider = Provider.of<ApplicationProvider>(context);
    final fee = applicationProvider.calculateFee(age: _age, isUrgent: _isUrgent);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifica Requisiti'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Rispondi ad alcune domande per sapere cosa ti serve',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 32),
          
          // Age selector
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quanti anni hai?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: _age.toDouble(),
                          min: 0,
                          max: 100,
                          divisions: 100,
                          label: '$_age anni',
                          onChanged: (value) {
                            setState(() {
                              _age = value.toInt();
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$_age',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Urgent checkbox
          Card(
            child: CheckboxListTile(
              title: const Text('Richiesta urgente'),
              subtitle: const Text('Necessito della CIE in tempi ridotti (+€5.00)'),
              value: _isUrgent,
              onChanged: (value) {
                setState(() {
                  _isUrgent = value ?? false;
                });
              },
            ),
          ),
          
          const SizedBox(height: 16),
          
          // First time checkbox
          Card(
            child: CheckboxListTile(
              title: const Text('Prima richiesta'),
              subtitle: const Text('È la prima volta che richiedo la CIE'),
              value: _isFirstTime,
              onChanged: (value) {
                setState(() {
                  _isFirstTime = value ?? false;
                });
              },
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Fee display
          Card(
            color: Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Costo totale:',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '€${fee.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Documents required
          const Text(
            'Documenti necessari:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          _buildDocumentItem(
            icon: Icons.credit_card,
            title: _isFirstTime ? 'Documento di riconoscimento valido' : 'Carta d\'identità scaduta o in scadenza',
            required: true,
          ),
          
          _buildDocumentItem(
            icon: Icons.confirmation_number,
            title: 'Codice fiscale',
            required: true,
          ),
          
          _buildDocumentItem(
            icon: Icons.photo_camera,
            title: 'Foto tessera (35x40mm, sfondo chiaro)',
            required: true,
          ),
          
          if (_age < 18)
            _buildDocumentItem(
              icon: Icons.people,
              title: 'Consenso di entrambi i genitori',
              required: true,
            ),
          
          if (_isFirstTime)
            _buildDocumentItem(
              icon: Icons.description,
              title: 'Certificato di nascita',
              required: true,
            ),
          
          _buildDocumentItem(
            icon: Icons.euro,
            title: 'Ricevuta di pagamento (€${fee.toStringAsFixed(2)})',
            required: true,
          ),
          
          const SizedBox(height: 32),
          
          // Info box
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.blue.shade700),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'La validità della CIE è di 10 anni per maggiorenni, 5 anni per minori tra 3 e 18 anni, 3 anni per minori di 3 anni',
                    style: TextStyle(color: Colors.blue.shade900, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem({
    required IconData icon,
    required String title,
    required bool required,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: required ? Colors.red.shade50 : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: required ? Colors.red : Colors.grey,
          ),
        ),
        title: Text(title),
        trailing: required
            ? Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'OBBLIGATORIO',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : null,
      ),
    );
  }
}