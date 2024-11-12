import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VisitorRegistrationScreen extends StatefulWidget {
  const VisitorRegistrationScreen({super.key});

  @override
  _VisitorRegistrationScreenState createState() => _VisitorRegistrationScreenState();
}

class _VisitorRegistrationScreenState extends State<VisitorRegistrationScreen> {
  final GlobalKey qrKey = GlobalKey();
  QRViewController? controller;
  String qrCodeResult = "";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController documentController = TextEditingController();

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrCodeResult = scanData.code ?? "";
      });
    });
  }

  Future<void> _registerVisitor() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Você precisa estar logado!')),
        );
        return;
      }

      await FirebaseFirestore.instance.collection('visitantes').add({
        'nome': nameController.text,
        'documento': documentController.text,
        'qr_code': qrCodeResult,
        'horario_entrada': DateTime.now(),
        'uid': currentUser.uid,
      });

      // Limpar os campos após o envio
      nameController.clear();
      documentController.clear();
      qrCodeResult = "";

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Visitante registrado com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao registrar visitante: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro de Visitante')),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nome'),
                  ),
                  TextField(
                    controller: documentController,
                    decoration: const InputDecoration(labelText: 'Documento'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _registerVisitor,
                    child: const Text('Registrar Visitante'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
