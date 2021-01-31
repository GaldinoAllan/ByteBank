import 'package:bytebank/components/text_editor.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _titleAppBar = 'Criando Transferência';

const _labelAccountNumber = 'Número da conta';
const _hintAccountNumber = '0000';

const _labelValue = 'Valor';
const _hintValue = '0.00';

const _confirmTextButton = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titleAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextEditor(
              controller: _accountNumberController,
              label: _labelAccountNumber,
              hint: _hintAccountNumber,
            ),
            TextEditor(
              controller: _valueController,
              label: _labelValue,
              hint: _hintValue,
              icon: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text(_confirmTextButton),
              onPressed: () => _criaTransferencia(context),
            ),
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int accountNumber = int.tryParse(_accountNumberController.text);
    final double value = double.tryParse(_valueController.text);

    if (accountNumber != null && value != null) {
      final transferenciaCriada = Transferencia(value, accountNumber);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
