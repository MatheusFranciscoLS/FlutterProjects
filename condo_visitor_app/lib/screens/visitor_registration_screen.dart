import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../models/visitor.dart';

class VisitorRegistrationScreen extends StatefulWidget {
  @override
  _VisitorRegistrationScreenState createState() => _VisitorRegistrationScreenState();
}

class _VisitorRegistrationScreenState extends State<VisitorRegistrationScreen> {
  final GlobalKey qrKey = GlobalKey();
  QRViewController? controller;
  String qrCodeResult = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController documentController = TextEditingController();

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de Visitante')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Text('Resultado: $qrCodeResult'),
          Expanded(
            flex: 3,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Nome'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu nome';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: documentController,
                      decoration: InputDecoration(labelText: 'Documento'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu documento';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            Visitor visitor = Visitor(
                              nome: nameController.text,
                              documento: documentController.text,
                              horarioEntrada: DateTime.now(),
                              qrCode: qrCodeResult,
                            );

                            await FirebaseFirestore.instance.collection('visitantes').add(visitor.toMap());

                            // Limpar os campos após o envio
                            nameController.clear();
                            documentController.clear();
                            qrCodeResult = "";

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Visitante registrado com sucesso!')),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Erro ao registrar visitante: $e')),
                            );
                          }
                        }
                      },
                      child: Text('Enviar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

void _onQRViewCreated(QRViewController controller) {
  setState(() {
    this.controller = controller;
  });
  controller.scannedDataStream.listen((scanData) {
    setState(() {
      qrCodeResult = scanData.code ?? ""; // Garantir que qrCodeResult nunca seja nulo
    });
  });
}

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
