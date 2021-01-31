import 'package:bytebank/models/transferencias.dart';
import 'package:bytebank/screens/transferencia/lista_transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _title = 'Últimas Tranferências';

class UltimasTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Consumer<Transferencias>(
          builder: (context, transferencias, child) {
            final _quantity = transferencias.transferencias.length;
            final _ultimasTransferencias =
                transferencias.transferencias.reversed.toList();

            int size = 6;

            if (_quantity == 0) {
              return SemTransferenciasCadastradas();
            }

            if (_quantity < 7) {
              size = _quantity;
            }

            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: size,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ItemTransferencia(_ultimasTransferencias[index]);
              },
            );
          },
        ),
        RaisedButton(
          child: Text('Ver todas as transferências'),
          color: Colors.green,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {
                return ListaTransferencias();
              }),
            );
          },
        ),
      ],
    );
  }
}

class SemTransferenciasCadastradas extends StatelessWidget {
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(40),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          'Voce ainda nao cadastrou nenhuma transferencia',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
