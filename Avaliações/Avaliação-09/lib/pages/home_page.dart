import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> _futureUsers;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _carregarUsuarios();
  }

  void _carregarUsuarios() {
    setState(() {
      _futureUsers = _apiService.fetchUsers();
    });
  }

  Future<void> _atualizarLista() async {
    _carregarUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuários'),
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          // ✅ 1. Indicador de progresso
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ✅ 2. Mensagem amigável em caso de erro
          else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text(
                    'Erro ao carregar usuários.\nVerifique sua conexão ou a chave da API.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _carregarUsuarios,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }

          // ✅ 3. Lista eficiente com suporte a grande volume de dados
          else if (snapshot.hasData) {
            final usuarios = snapshot.data!;
            return RefreshIndicator(
              onRefresh: _atualizarLista, // ✅ 4. Pull-to-refresh
              child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  final user = usuarios[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    elevation: 2,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(user.avatar),
                      ),
                      title: Text('${user.firstName} ${user.lastName}'),
                      subtitle: Text(user.email),
                    ),
                  );
                },
              ),
            );
          }

          // Fallback
          return const Center(child: Text('Nenhum dado disponível.'));
        },
      ),
    );
  }
}
