import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';
import 'package:velvetvnaity/Pages/HomePage.dart';
import 'package:velvetvnaity/model/data-file.dart';

class ContactUs extends StatefulWidget {
    static const String id = "UserContact";
  const ContactUs({super.key});
  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController locationcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color.fromARGB(204, 199, 118, 121),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ContactUs",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Add Yourself",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(left: 20.0, top: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: namecontroller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  const Text(
                    "Age",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: agecontroller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  const Text(
                    "Designation",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10.0),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: locationcontroller,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7.0,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        String Id = randomAlphaNumeric(10);
                        Map<String, dynamic> usercontactMap = {
                          "Id": Id,
                          "Name": namecontroller.text,
                          "Age": agecontroller.text,
                          "Location": locationcontroller.text
                        };

                        await DatabaseMethods()
                            .ContactDetails(usercontactMap, Id)
                            .then((value) {
                          Fluttertoast.showToast(
                            msg: "Record Inserted Sucessfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.white,
                            textColor: const Color.fromARGB(204, 199, 118, 121),
                            fontSize:
                                20.0, // change the font size of the toast message
                          );
                        });
                        await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Homepage()));
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50)),
                      child: const Text(
                        "Done",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(204, 199, 118, 121),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }
}
