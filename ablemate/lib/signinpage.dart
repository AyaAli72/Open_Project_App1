import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ablemate/main.dart';
import 'googlesheetAPI.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userAgeController = TextEditingController();
  final TextEditingController _userPhoneController = TextEditingController();
  String? selectedGender;
  bool _isLoading = false;
  bool _addAnotherUser = false;

  final List<String> genders = ['Female', 'Male'];

  @override
  void dispose() {
    _userNameController.dispose();
    _userAgeController.dispose();
    _userPhoneController.dispose();
    super.dispose();
  }

  void _resetForm() {
    _userNameController.clear();
    _userAgeController.clear();
    _userPhoneController.clear();
    selectedGender = null;
  }

  Future<void> _submitData() async {
    if (_isLoading || !_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      await GoogleSheetsApi.appendRow(
        spreadsheetId: '1ImOskhUNZtMarvFbyLM5AHs-yP-CkGtqEBxcn81cRGY',
        sheetName: 'SignIn',
        rowData: [
          _userNameController.text.trim(),
          _userAgeController.text.trim(),
          _userPhoneController.text.trim(),
          selectedGender ?? '',
          DateTime.now().toIso8601String(),
        ],
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_addAnotherUser
              ? "User saved! Add another."
              : "User data saved successfully!"),
        ),
      );

      if (_addAnotherUser) {
        _resetForm();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error saving data. Please try again.")),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Ablemate',
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Personal Information",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _userNameController,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Please enter your name' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _userAgeController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: "Age",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your age';
                  final age = int.tryParse(value!);
                  if (age == null || age < 1) return 'Enter valid age';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _userPhoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                  prefixText: '+20 ',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Phone number required';
                  if (value!.length != 10) return '10 digits required';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedGender,
                onChanged: (String? newValue) =>
                    setState(() => selectedGender = newValue),
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                items: genders.map<DropdownMenuItem<String>>((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Please select gender' : null,
              ),
            
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _submitData,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'SAVE USER',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
