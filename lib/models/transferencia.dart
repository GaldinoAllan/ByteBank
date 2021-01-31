class Transferencia {
  final double value;
  final int accountNumber;

  Transferencia(
    this.value,
    this.accountNumber,
  );

  String toStringValue() {
    return 'R\$ $value';
  }

  String toStringAccount() {
    return '$accountNumber';
  }
}
