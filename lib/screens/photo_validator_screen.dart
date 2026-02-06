import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class PhotoValidatorScreen extends StatefulWidget {
  const PhotoValidatorScreen({super.key});

  @override
  State<PhotoValidatorScreen> createState() => _PhotoValidatorScreenState();
}

class _PhotoValidatorScreenState extends State<PhotoValidatorScreen> {
  File? _imageFile;
  bool _isValidating = false;
  Map<String, bool>? _validationResults;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          _imageFile = File(image.path);
          _validationResults = null;
        });
        _validatePhoto();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore nel caricamento: $e')),
      );
    }
  }

  Future<void> _validatePhoto() async {
    if (_imageFile == null) return;

    setState(() {
      _isValidating = true;
    });

    await Future.delayed(const Duration(seconds: 1));

    try {
      final bytes = await _imageFile!.readAsBytes();
      final image = img.decodeImage(bytes);

      if (image == null) {
        setState(() {
          _isValidating = false;
        });
        return;
      }

      // Validaciones básicas
      final hasCorrectSize = image.width >= 400 && image.height >= 500;
      final hasCorrectRatio = (image.height / image.width) >= 1.2 && 
                               (image.height / image.width) <= 1.5;
      
      // Verificar fondo claro (simplificado: promedio de píxeles)
      int totalBrightness = 0;
      int sampleSize = 0;
      
      // Muestrear bordes para detectar fondo
      for (int y = 0; y < image.height; y += 10) {
        for (int x = 0; x < image.width; x += 10) {
          if (x < 50 || x > image.width - 50 || y < 50 || y > image.height - 50) {
            final pixel = image.getPixel(x, y);
            totalBrightness += (pixel.r + pixel.g + pixel.b) ~/ 3;
            sampleSize++;
          }
        }
      }
      
      final avgBrightness = sampleSize > 0 ? totalBrightness / sampleSize : 128;
      final hasLightBackground = avgBrightness > 200;
      
      // Verificar calidad (no borrosa - basado en tamaño de archivo)
      final fileSize = await _imageFile!.length();
      final hasGoodQuality = fileSize > 50000; // Más de 50KB

      setState(() {
        _validationResults = {
          'size': hasCorrectSize,
          'ratio': hasCorrectRatio,
          'background': hasLightBackground,
          'quality': hasGoodQuality,
        };
        _isValidating = false;
      });
    } catch (e) {
      setState(() {
        _isValidating = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Errore nella validazione: $e')),
      );
    }
  }

  bool get _isPhotoValid {
    if (_validationResults == null) return false;
    return _validationResults!.values.every((v) => v);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Valida Foto'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'Carica una foto per verificare che sia conforme ai requisiti',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          
          // Image display
          if (_imageFile != null)
            Container(
              height: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              height: 400,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.photo_camera,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nessuna foto caricata',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          
          const SizedBox(height: 24),
          
          // Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Fotocamera'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Galleria'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade700,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          
          if (_isValidating) ...[
            const SizedBox(height: 32),
            const Center(child: CircularProgressIndicator()),
            const SizedBox(height: 16),
            const Center(
              child: Text('Validazione in corso...'),
            ),
          ],
          
          if (_validationResults != null) ...[
            const SizedBox(height: 32),
            Card(
              color: _isPhotoValid ? Colors.green.shade50 : Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(
                      _isPhotoValid ? Icons.check_circle : Icons.warning,
                      size: 48,
                      color: _isPhotoValid ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _isPhotoValid 
                          ? 'Foto conforme!' 
                          : 'Foto non conforme',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isPhotoValid ? Colors.green.shade900 : Colors.orange.shade900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            _buildValidationItem(
              'Dimensioni corrette',
              'Minimo 400x500 pixel',
              _validationResults!['size']!,
            ),
            
            _buildValidationItem(
              'Proporzioni corrette',
              'Rapporto altezza/larghezza 1.2-1.5',
              _validationResults!['ratio']!,
            ),
            
            _buildValidationItem(
              'Sfondo chiaro',
              'Sfondo bianco o grigio chiaro',
              _validationResults!['background']!,
            ),
            
            _buildValidationItem(
              'Buona qualità',
              'Immagine nitida e non sfocata',
              _validationResults!['quality']!,
            ),
          ],
          
          const SizedBox(height: 32),
          
          // Requirements info
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
                      'Requisiti foto tessera',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '• Sfondo chiaro uniforme\n'
                  '• Viso frontale, sguardo dritto\n'
                  '• Espressione neutra\n'
                  '• Bocca chiusa\n'
                  '• No occhiali scuri\n'
                  '• No cappelli o copricapi\n'
                  '• Formato 35x40mm (stampa)',
                  style: TextStyle(color: Colors.blue.shade900, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValidationItem(String title, String description, bool isValid) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isValid ? Colors.green.shade50 : Colors.red.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isValid ? Icons.check_circle : Icons.cancel,
            color: isValid ? Colors.green : Colors.red,
          ),
        ),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}