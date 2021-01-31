import 'package:bytebank/components/text_editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _titleAppBar = 'Receber Depósito';

const _labelValue = 'value';
const _hintValue = '0.00';
const _confirmTextButton = 'Confirmar';

class FormularioDeposito extends StatelessWidget {
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
              controller: _valueController,
              label: _labelValue,
              hint: _hintValue,
              icon: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text(_confirmTextButton),
              onPressed: () => _criaDeposito(context),
            ),
          ],
        ),
      ),
    );
  }

  _criaDeposito(context) {
    final double value = double.tryParse(_valueController.text);
    final depositoValido = _validaDeposito(value);

    if (depositoValido) {
      _atualizaState(context, value);

      Navigator.pop(context);
    }
  }

  _validaDeposito(value) {
    final _campoPreenchido = value != null;

    return _campoPreenchido;
  }

  _atualizaState(context, value) {
    Provider.of<Saldo>(context, listen: false).add(value);
  }
}
