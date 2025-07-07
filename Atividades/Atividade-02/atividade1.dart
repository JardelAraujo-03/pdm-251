import 'dart:convert';

// Classe Dependente
class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  // Método para conversão em JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
    };
  }
}

// Classe Funcionario
class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  // Método para conversão em JSON
  Map<String, dynamic> toJson() {
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((d) => d.toJson()).toList(),
    };
  }
}

// Classe EquipeProjeto
class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  // Método para conversão em JSON
  Map<String, dynamic> toJson() {
    return {
      'nomeProjeto': _nomeProjeto,
      'funcionarios': _funcionarios.map((f) => f.toJson()).toList(),
    };
  }
}

void main() {
  var dep1 = Dependente("Ana");
  var dep2 = Dependente("Carlos");
  var dep3 = Dependente("Juliana");
  var dep4 = Dependente("Lucas");

  var func1 = Funcionario("João", [dep1, dep2]);
  var func2 = Funcionario("Maria", [dep3]);
  var func3 = Funcionario("Pedro", [dep4]);

  var listaFuncionarios = [func1, func2, func3];

  var equipe = EquipeProjeto("Projeto Alpha", listaFuncionarios);

 // String json = jsonEncode(equipe.toJson());
 // print(json);
  var encoder = JsonEncoder.withIndent('  '); // 2 espaços de indentação
  print(encoder.convert(equipe.toJson()));

}