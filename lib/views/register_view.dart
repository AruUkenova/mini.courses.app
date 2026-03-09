import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../presenters/register_presenter.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final emailC = TextEditingController();
  final passC = TextEditingController();

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<RegisterPresenter>();


    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (c.error != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                color: Colors.red.withValues(alpha: 0.1),
                child: Text(c.error!, style: const TextStyle(color: Colors.red)),
              ),
            TextField(controller: emailC, decoration: const InputDecoration(labelText: "Email")),
            const SizedBox(height: 12),
            TextField(
              controller: passC,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: c.isLoading
                    ? null
                    : () async {
                        final ok = await c.register(emailC.text.trim(), passC.text.trim());
                        if (ok && context.mounted) Navigator.pop(context);
                      },
                child: c.isLoading
                    ? const SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text("Create"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}