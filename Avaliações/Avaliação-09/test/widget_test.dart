import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:busca_produtos_api/main.dart'; // nome correto do pacote

void main() {
  testWidgets('Verifica se título principal é exibido',
      (WidgetTester tester) async {
    // Monta o app
    await tester.pumpWidget(const MyApp());

    // Verifica se o título está visível
    expect(find.text('Produtos (Estilo Mercado Livre)'), findsOneWidget);
  });
}
