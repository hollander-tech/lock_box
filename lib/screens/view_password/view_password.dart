import 'package:flutter/material.dart';
import 'package:lock_box/providers/passwords.dart';
import 'package:lock_box/screens/view_password/widgets/delete_button.dart';
import 'package:lock_box/screens/view_password/widgets/notes.dart';
import 'package:lock_box/screens/view_password/widgets/password.dart';
import 'package:lock_box/screens/view_password/widgets/title.dart';
import 'package:lock_box/screens/view_password/widgets/url.dart';
import 'package:lock_box/screens/view_password/widgets/username.dart';
import 'package:provider/provider.dart';

import '../../models/password.dart';
import '../../widgets/body_container.dart';

class ViewPasswordScreen extends StatefulWidget {
  final Password password;
  const ViewPasswordScreen(this.password, {super.key});

  @override
  ViewPasswordScreenState createState() => ViewPasswordScreenState();
}

class ViewPasswordScreenState extends State<ViewPasswordScreen> {
  bool _isEditing = false;
  late TextEditingController _titleController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _urlController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.password.title);
    _usernameController = TextEditingController(text: widget.password.username);
    _passwordController = TextEditingController(text: widget.password.password);
    _urlController = TextEditingController(text: widget.password.url);
    _notesController = TextEditingController(text: widget.password.notes);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _urlController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Future<void> _saveChanges() async {
    PasswordProvider passwordProvider = Provider.of<PasswordProvider>(context, listen: false);
    await passwordProvider
        .updatePassword(Password(
      docId: widget.password.docId,
      title: _titleController.text.trim(),
      username: _usernameController.text.trim(),
      password: _passwordController.text.trim(),
      url: _urlController.text.trim(),
      notes: _notesController.text.trim(),
      lastUpdated: DateTime.now(),
    ));
    await passwordProvider.fetch();
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Password Details')),
      body: BodyContainer(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 22.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleField(controller: _titleController, isEditing: _isEditing),
                      const SizedBox(
                        height: 24.0,
                      ),
                      UsernameField(
                          controller: _usernameController, isEditing: _isEditing),
                      const SizedBox(
                        height: 18.0,
                      ),
                      PasswordField(
                          controller: _passwordController, isEditing: _isEditing),
                      const SizedBox(
                        height: 18.0,
                      ),
                      UrlField(controller: _urlController, isEditing: _isEditing),
                      const SizedBox(
                        height: 18.0,
                      ),
                      NotesField(controller: _notesController, isEditing: _isEditing),
                      const SizedBox(
                        height: 28.0,
                      )
                    ],
                  ),
                ),
              ),
              DeleteButton(widget.password.docId)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isEditing ? _saveChanges : _toggleEdit,
        child: Icon(_isEditing ? Icons.save : Icons.edit),
      ),
    );
  }
}
