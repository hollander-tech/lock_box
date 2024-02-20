import 'package:flutter/material.dart';
import 'package:lock_box/providers/passwords.dart';
import 'package:provider/provider.dart';

import '../../models/password.dart';
import '../../widgets/body_container.dart';

class AddPasswordScreen extends StatefulWidget {
  const AddPasswordScreen({Key? key}) : super(key: key);

  @override
  AddPasswordScreenState createState() => AddPasswordScreenState();
}

class AddPasswordScreenState extends State<AddPasswordScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _urlController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> save() async {
    if (_formKey.currentState?.validate() ?? false) {
      PasswordProvider passwordProvider =
      Provider.of<PasswordProvider>(context, listen: false);
      await passwordProvider.addPassword(Password(
        docId: "",
        title: _titleController.text.trim(),
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
        url: _urlController.text.trim(),
        notes: _notesController.text.trim(),
        lastUpdated: DateTime.now(),
      ));
      await passwordProvider.fetch();
      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Password'),
      ),
      body: BodyContainer(
        child: Form(
          key: _formKey,
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    style: Theme.of(context).textTheme.headlineMedium,
                    decoration: const InputDecoration(
                      labelText: 'Website Title',
                      contentPadding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Username/Email',
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    controller: _usernameController,
                    style: Theme.of(context).textTheme.bodyLarge,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a username/email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    controller: _passwordController,
                    style: Theme.of(context).textTheme.bodyLarge,
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'URL',
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    controller: _urlController,
                    style: Theme.of(context).textTheme.bodyLarge,
                    validator: (value) {
                      // Add any specific URL validation if needed
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Notes',
                      hintText: 'Optional',
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    controller: _notesController,
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: null,
                    minLines: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: save,
        child: const Icon(Icons.save),
      ),
    );
  }
}
