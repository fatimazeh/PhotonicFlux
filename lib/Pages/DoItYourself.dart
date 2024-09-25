import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velvetvnaity/Pages/DIYGuide.dart';


class DoItYourself extends StatefulWidget {
  const DoItYourself({super.key});
  static const String id = "doityourslef";

  @override
  _DoItYourselfState createState() => _DoItYourselfState();
}

class _DoItYourselfState extends State<DoItYourself> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? selectedArea;
  String? selectedSystem;
  String? selectedPanel;
  String? selectedStructure;
  int numberOfPanels = 0;
  int numberOfStands = 0;
  bool hasDuctingPiping = false;
  bool hasCivilWork = false;
  bool hasCables = false;
  bool hasSurgeProtectionDevices = false;
  bool completeNetMeteringServices = false;
  bool transportationAndLabour = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_validateForm()) {
      try {
        await FirebaseFirestore.instance.collection('DoItYourSelf').add({
          'name': _nameController.text,
          'email': _emailController.text,
          'area': selectedArea,
          'system': selectedSystem,
          'panel': selectedPanel,
          'structure': selectedStructure,
          'numberOfPanels': numberOfPanels,
          'numberOfStands': numberOfStands,
          'hasDuctingPiping': hasDuctingPiping,
          'hasCivilWork': hasCivilWork,
          'hasCables': hasCables,
          'hasSurgeProtectionDevices': hasSurgeProtectionDevices,
          'completeNetMeteringServices': completeNetMeteringServices,
          'transportationAndLabour': transportationAndLabour,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Submission Successful',
              style: TextStyle(
                color: Colors.white, // Text color
              ),
            ),
            backgroundColor: Colors.black, // Background color
            behavior: SnackBarBehavior.floating, // Optional: Makes the SnackBar float above the content
          ),
        );
        _clearForm();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Oops..! You forgot to fill the fields.',
            style: TextStyle(
              color: Colors.white, // Text color
            ),
          ),
          backgroundColor: Colors.black, // Background color
          behavior: SnackBarBehavior.floating, // Optional: Makes the SnackBar float above the content
        ),
      );
    }
  }

  void _clearForm() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      selectedArea = null;
      selectedSystem = null;
      selectedPanel = null;
      selectedStructure = null;
      numberOfPanels = 0;
      numberOfStands = 0;
      hasDuctingPiping = false;
      hasCivilWork = false;
      hasCables = false;
      hasSurgeProtectionDevices = false;
      completeNetMeteringServices = false;
      transportationAndLabour = false;
    });
  }

  bool _validateForm() {
    // Check if all required fields are filled
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        selectedArea == null ||
        selectedSystem == null ||
        selectedPanel == null ||
        selectedStructure == null ||
        numberOfPanels <= 0 ||
        numberOfStands <= 0) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DIY Solar System Installation"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFA80C0C),
              Colors.black,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                '../lib/images/Photoes/DIY_FULL.gif', // Update to match your assets path
                height: 500,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                'Name',
                _nameController,
              ),
              const SizedBox(height: 10),
              _buildTextField(
                'Email',
                _emailController,
              ),
              const SizedBox(height: 10),
              _buildDropdownField(
                'Select Area',
                [
                  '25 square yards',
                  '252 square yards',
                  '75 square yards',
                  '100 square yards',
                  '125 square yards',
                  '150 square yards and above'
                ],
                selectedArea,
                (String? value) {
                  setState(() {
                    selectedArea = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              _buildDropdownField(
                'Select System',
                ['On-Grid Solar Systems', 'Hybrid Solar Systems'],
                selectedSystem,
                (String? value) {
                  setState(() {
                    selectedSystem = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              _buildDropdownField(
                'Select Solar Panels',
                [
                  'Trina Solar',
                  'Hanwha Q Cells',
                  'SunPower',
                  'LG Solar',
                  'JinkoSolar',
                  'Canadian Solar',
                  'Panasonic Solar'
                ],
                selectedPanel,
                (String? value) {
                  setState(() {
                    selectedPanel = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              _buildNumberField(
                'Number of Panels',
                numberOfPanels.toString(),
                (String value) {
                  setState(() {
                    numberOfPanels = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(height: 10),
              _buildDropdownField(
                'Select Mounting Structure',
                [
                  'GI Structure 2 PV',
                  'GI Structure 3 PV',
                  'Aluminium Structure 2 PV',
                  'Aluminium Structure 3 PV'
                ],
                selectedStructure,
                (String? value) {
                  setState(() {
                    selectedStructure = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              _buildNumberField(
                'Number of Stands',
                numberOfStands.toString(),
                (String value) {
                  setState(() {
                    numberOfStands = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const SizedBox(height: 10),
              const Text(
                "Electrical Accessories",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              _buildCheckboxField(
                'Ducting + Piping',
                hasDuctingPiping,
                (bool? value) {
                  setState(() {
                    hasDuctingPiping = value ?? false;
                  });
                },
              ),
              _buildCheckboxField(
                'Civil Work',
                hasCivilWork,
                (bool? value) {
                  setState(() {
                    hasCivilWork = value ?? false;
                  });
                },
              ),
              _buildCheckboxField(
                'Cables',
                hasCables,
                (bool? value) {
                  setState(() {
                    hasCables = value ?? false;
                  });
                },
              ),
              _buildCheckboxField(
                'Surge Protection Devices',
                hasSurgeProtectionDevices,
                (bool? value) {
                  setState(() {
                    hasSurgeProtectionDevices = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 10),
              _buildRadioField(
                'Complete Net Metering Services',
                completeNetMeteringServices,
                (bool? value) {
                  setState(() {
                    completeNetMeteringServices = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildRadioField(
                'Transportation + Labour',
                transportationAndLabour,
                (bool? value) {
                  setState(() {
                    transportationAndLabour = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      minimumSize: const Size(150, 50),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DIYGuide()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      minimumSize: const Size(150, 50),
                    ),
                    child: const Text(
                      'DIY Guide',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "If you have any questions or need further assistance, don’t hesitate to reach out!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
  ) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.text,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(
    String label,
    List<String> options,
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
      ),
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(
            option,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildNumberField(
    String label,
    String initialValue,
    Function(String) onChanged,
  ) {
    return TextFormField(
      initialValue: initialValue,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a number';
        }
        return null;
      },
    );
  }

  Widget _buildCheckboxField(
    String label,
    bool isChecked,
    Function(bool?) onChanged,
  ) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: onChanged,
          checkColor: Colors.black,
          fillColor: MaterialStateProperty.resolveWith((states) => Colors.white),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildRadioField(
    String label,
    bool isChecked,
    Function(bool?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: isChecked,
              onChanged: onChanged,
              fillColor: MaterialStateProperty.resolveWith((states) => Colors.white),
            ),
            const Text('Yes', style: TextStyle(color: Colors.white)),
            Radio<bool>(
              value: false,
              groupValue: isChecked,
              onChanged: onChanged,
              fillColor: MaterialStateProperty.resolveWith((states) => Colors.white),
            ),
            const Text('No', style: TextStyle(color: Colors.white)),
          ],
        ),
      ],
    );
  }
}

