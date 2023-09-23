import 'package:flutter/material.dart';
import 'package:letters/services/letters_service.dart';
import 'package:letters/utils/extensions.dart';

class CreateLetterScreen extends StatefulWidget {
  const CreateLetterScreen({super.key});

  @override
  State<CreateLetterScreen> createState() => _CreateLetterScreenState();
}

class _CreateLetterScreenState extends State<CreateLetterScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool fetchState = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      final res = await LetterService.postLetter({
        "title": _titleController.text,
        "body": _bodyController.text,
      });

      setState(() {
        isLoading = false;
        fetchState = res.$2;
      });

      // context should never be used across async gaps
      // we have to check if the widget is still mounted
      if (context.mounted && res.$2) {
        context.showSnackBar("Letter saved successfully");
      }

      if (context.mounted && !res.$2) {
        context.showSnackBar("Error saving letter");
      }

      _titleController.clear();
      _bodyController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Material(
          child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Letters.",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  // Title
                  const SizedBox(height: 16),
                  Text("Subject",
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  TextFormField(
                    autofocus: true,
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "Once upon a Flutter app...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Title cannot be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Text("Write a letter to your esteemed readers.",
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: context.width,
                      minHeight: context.height * .5,
                    ),
                    child: TextFormField(
                        autofocus: false,
                        controller: _bodyController,
                        decoration: InputDecoration(
                          hintText: "Down the rabbit hole...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return "Body cannot be empty";
                          }
                          if (v.length < 100) {
                            return "Body must be at least 100 characters";
                          }
                          return null;
                        },
                        maxLines: 10,
                        maxLength: 512,
                        buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                maxLength}) =>
                            Text(
                              "$currentLength/$maxLength",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.5),
                                  ),
                            )),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: isLoading
                        ? const CircularProgressIndicator.adaptive()
                        : InkWell(
                            onTap: _save,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "Save",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
