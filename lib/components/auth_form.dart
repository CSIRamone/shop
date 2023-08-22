import 'package:flutter/material.dart';

enum AuthMode { Sigunp, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  void _onSubmit() {}

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 320,
        width: deviceSize.width * 0.75,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (_email) {
                    final email = _email ?? '';
                    if (email.trim().isEmpty || !email.contains('@')) {
                      return 'Informe um email válido';
                    }
                    return null;
                  }),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Senha'),
                keyboardType: TextInputType.text,
                obscureText: true,
                controller: _passwordController,
                onSaved: (password) => _authData['password'] = password ?? '',
                validator: (_password) {
                  final password = _password ?? '';
                  if (password.isEmpty || password.length < 5) {
                    return 'Informe uma senha válida';
                  }
                  return null;
                },
              ),
              if (_authMode == AuthMode.Sigunp)
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Confirmar Senha'),
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: _authMode == AuthMode.Login
                      ? null
                      : (_password) {
                          final password = _password ?? '';
                          if (password != _passwordController) {
                            return 'Senhas informadas não conferem.';
                          }
                          return null;
                        },
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onSubmit,
                child: Text(
                  _authMode == AuthMode.Login ? 'Entrar' : 'Registrar',
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 8,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
