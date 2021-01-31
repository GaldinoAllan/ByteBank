import 'package:bytebank/components/text_editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _titleAppBar = 'Criando Transferência';

const _labelAccountNumber = 'Número da conta';
const _hintAccountNumber = '0000';

const _labelValue = 'value';
const _hintValue = '0.00';

const _confirmTextButton = 'Confirmar';

class FormularioTransferencia extends StatelessWidget {
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

    final transferenciaValida =
        _validaTransferencia(context, accountNumber, value);

    if (transferenciaValida) {
      final novaTransferencia = Transferencia(value, accountNumber);

      _atualizaState(context, novaTransferencia, value);

      Navigator.pop(context);
    }
  }

  _validaTransferencia(context, accountNumber, value) {
    final _camposPreenchidos = accountNumber != null && value != null;
    final _saldoSuficiente = value <=
        Provider.of<Saldo>(
          context,
          listen: false,
        ).value;

    return _camposPreenchidos && _saldoSuficiente;
  }

  _atualizaState(context, novaTransferencia, value) {
    Provider.of<Transferencias>(context, listen: false).add(novaTransferencia);
    Provider.of<Saldo>(context, listen: false).subtract(value);
  }
}
