import 'package:sqlite3/sqlite3.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

void main() {
  final dbPath = p.join(Directory.current.path, 'aluno.db');
  final db = sqlite3.open(dbPath);

  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL
    );
  ''');

  while (true) {
    print('\n--- MENU ---');
    print('1 - Adicionar Aluno');
    print('2 - Excluir Aluno');
    print('3 - Listar Alunos');
    print('4 - Sair');
    stdout.write('Escolha uma opção: ');
    final opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        adicionarAluno(db);
        break;
      case '2':
        excluirAluno(db);
        break;
      case '3':
        listarAlunos(db);
        break; // <- Importante para evitar cair na opção 4
      case '4':
        db.dispose();
        print('Encerrando o programa...');
        exit(0);
      default:
        print('Opção inválida. Tente novamente.');
    }
  }
}

void adicionarAluno(Database db) {
  stdout.write('Digite o nome do aluno: ');
  final nome = stdin.readLineSync();

  if (nome != null && nome.isNotEmpty) {
    db.execute('INSERT INTO TB_ALUNO (nome) VALUES (?)', [nome]);
    print('Aluno adicionado com sucesso!');
  } else {
    print('Nome inválido!');
  }
}

void excluirAluno(Database db) {
  listarAlunos(db);
  stdout.write('Digite o ID do aluno que deseja excluir: ');
  final input = stdin.readLineSync();
  final id = int.tryParse(input ?? '');

  if (id != null) {
    final result = db.select('SELECT * FROM TB_ALUNO WHERE id = ?', [id]);
    if (result.isNotEmpty) {
      db.execute('DELETE FROM TB_ALUNO WHERE id = ?', [id]);
      print('Aluno excluído com sucesso!');
    } else {
      print('ID não encontrado.');
    }
  } else {
    print('ID inválido.');
  }
}

void listarAlunos(Database db) {
  final result = db.select('SELECT * FROM TB_ALUNO');
  print('\n--- Lista de Alunos ---');
  if (result.isEmpty) {
    print('Nenhum aluno cadastrado.');
  } else {
    for (final row in result) {
      print('ID: ${row['id']} | Nome: ${row['nome']}');
    }
  }
}
