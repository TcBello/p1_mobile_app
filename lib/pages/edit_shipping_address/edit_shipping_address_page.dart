import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:p1_mobile_app/utils/validator_util.dart';
import 'package:tuple/tuple.dart';

class EditShippingAddressPage extends StatefulWidget {
  const EditShippingAddressPage({super.key});

  @override
  State<EditShippingAddressPage> createState() =>
      _EditShippingAddressPageState();
}

class _EditShippingAddressPageState extends State<EditShippingAddressPage> {
  late GlobalKey<FormState> _formKey;

  late TextEditingController _nameController;
  late TextEditingController _addressController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      context.pop(Tuple2<String, String>(
          _nameController.text, _addressController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Shipping Address",
          style: Theme.of(context)
              .textTheme
              .labelMedium
              ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          TextButton(
            onPressed: _handleSave,
            style: const ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(Colors.blue)),
            child: const Text("Save"),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              validator: ValidatorUtil.validateTextField,
              decoration: const InputDecoration(hintText: "Add name"),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: _addressController,
              validator: ValidatorUtil.validateTextField,
              decoration: const InputDecoration(hintText: "Add address"),
            )
          ],
        ),
      ),
    );
  }
}
