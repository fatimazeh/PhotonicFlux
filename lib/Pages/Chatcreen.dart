// import 'package:flutter/material.dart';
// import 'package:velvetvnaity/main.dart';

// void main() {
//   runApp(const MyApp());
// }

// class  ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Solar Energy Chatbot',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController _controller = TextEditingController();
//   String _answer = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Solar Energy Chatbot'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: _controller,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: 'Ask a question',
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 setState(() {
//                   _answer = getAnswer(_controller.text);
//                 });
//               },
//               child: const Text('Ask'),
//             ),
//             const SizedBox(height: 20),
//             Text(_answer),
//           ],
//         ),
//       ),
//     );
//   }

//   String getAnswer(String question) {
//     switch (question.toLowerCase()) {
//       //Question1
//       case 'what is solar energy?':
//         return 'Solar energy is the energy harnessed from the sun\'s rays. It can be converted into electricity or heat using solar panels or other solar energy technologies.';
// //Question2
//       case 'how do solar panels work?':
//         return 'Solar panels are made up of photovoltaic (PV) cells that convert sunlight into electricity. When sunlight hits the PV cells, it creates an electric field that generates direct current (DC) electricity, which is then converted to alternating current (AC) electricity by an inverter for use in your home.';
//         //Question3
//       // case 'What are the benefits of using solar energy?':
//       //   return 'Solar energy is a renewable, clean source of energy that reduces your carbon footprint, lowers your electricity bills, increases energy independence, and can increase the value of your property.';
// //               //Question4
//       case ' How much can I save with solar energy?':
//         return 'The amount you can save depends on various factors such as your energy consumption, the size of your solar system, local electricity rates, and available incentives. On average, homeowners can save tens of thousands of dollars over the life of their solar energy system.';
// //       //Question5
// //       case ' Is solar energy environmentally friendly?':
// //         return 'The amount you can save depends on various factors such as your energy consumption, the size of your solar system, local electricity rates, and available incentives. On average, homeowners can save tens of thousands of dollars over the life of their solar energy system.';
// //             //Question6
// //       case 'How are solar panels installed?':
// //         return 'Modern solar mounting systems consist of roof attachments (with or without flashing), mounting rails, and module clamps. These products are designed to allow workers to quickly and effectively install solar panels that will last for decades on the roof, with minimal effect on the roofing materials and no roof leaks.';
// //                //Question7
// //       case 'What is the lifespan of a solar panel system?':
// //         return ' Most solar panels come with a warranty of 25-30 years, but they can continue to produce electricity for 40 years or more with proper maintenance.';
// //               //Question8
// //       case ' How much maintenance do solar panels require?':
// //         return '  Solar panels require minimal maintenance. Regular cleaning and periodic inspections to ensure there are no obstructions or damages are usually sufficient to keep them functioning optimally.';
// //                 //Question9
// //       case ' What happens if my solar panels are damaged?':
// //         return ' If your solar panels are damaged, contact your installer or manufacturer. Most systems come with warranties that cover repairs or replacements. Homeowners insurance may also cover damage due to certain events.';
// //         //Question10
// //       case ' What happens if my solar panels are damaged?':
// //         return ' If your solar panels are damaged, contact your installer or manufacturer. Most systems come with warranties that cover repairs or replacements. Homeowners insurance may also cover damage due to certain events.';
// //     //Question10
// //       case ' Can I install solar panels myself?':
// //         return ' While DIY solar panel kits are available, professional installation is recommended to ensure safety, compliance with local codes, and to maximize system efficiency and performance.';
// //  //Question11
// //       case '  How much does a solar energy system cost?':
// //         return ' The cost of a solar energy system varies based on its size, location, and other factors. On average, a residential system can cost between 15,000 Dollars and 25,000 Dollars before incentives.';
// //         //Question12
// //       case '  Are there any government incentives or rebates for installing solar panels?':
// //         return ' Yes, many governments offer incentives such as tax credits, rebates, and grants to encourage the adoption of solar energy. In the U.S., the federal solar tax credit (ITC) allows you to deduct a significant portion of the cost of installing a solar energy system from your federal taxes.';
// //          //Question13
// //       case ' What financing options are available for solar panel installation?':
// //         return ' Financing options include solar loans, leases, and power purchase agreements (PPAs). These options can make it more affordable to install solar panels by spreading out the cost over time.';
// //               //Question14
// //       case 'How long does it take to see a return on investment?':
// //         return ' The return on investment (ROI) for solar panels typically ranges from 5 to 10 years, depending on the cost of the system, local electricity rates, and available incentives.';
// //                    //Question15
// //       case 'Are there any tax benefits for installing solar panels?':
// //         return '  Yes, in many countries, there are tax benefits for installing solar panels. In the U.S., for example, the federal solar tax credit (ITC) provides a significant tax credit for solar energy systems.';
// //                   //Question16
// //       case 'What are the different types of solar panels?':
// //         return ' The main types of solar panels are monocrystalline, polycrystalline, and thin-film. Monocrystalline panels are more efficient and have a longer lifespan, while polycrystalline panels are more affordable. Thin-film panels are flexible and lightweight but generally less efficient.';
// //                 //Question17
// //       case 'How do I determine the size of the solar system I need?':
// //         return ' The size of your solar system depends on your energy consumption, the available roof space, and your budget. A solar installer can help you determine the optimal system size based on your specific needs.';
// //                //Question18
// //       case 'What is net metering and how does it work?':
// //         return ' Net metering is a billing mechanism that allows you to receive credit for excess electricity your solar panels produce and feed back into the grid. This can offset the cost of the electricity you consume from the grid when your panels are not producing enough power.';
//       // Add more cases for each question
//       default:
//         return 'I don\'t know the answer to that question.';
//     }
//   }
// }


import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _controller = TextEditingController();
  String _userInput = " ";
  String _botResponse = " ";

  void _handleUserInput() {
    setState(() {
      _userInput = _controller.text;
      _controller.clear();
    });

    switch (_userInput.toLowerCase()) {
      
      case 'hello':
      case 'hi':
        _botResponse = 'Hello! How can I assist you today?';
        break;
      case 'what is your name':
        _botResponse = 'My name is ChatBot!';
         case 'Where are you?':
        _botResponse = 'In USA';
        break;
      case 'what can you do':
        _botResponse = 'I can answer questions, provide information, and even tell jokes!';
        break;
      case 'tell me a joke':
        _botResponse = 'Why did the scarecrow win an award? Because he was outstanding in his field!';
        break;
        
      default:
        _botResponse = 'I didn\'t understand that. Can you please rephrase?';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot'),
          backgroundColor:Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(

          children: [
            
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter your message',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (input) => _handleUserInput(),
            ),
            const SizedBox(height: 20),
            Text(
              'You: $_userInput',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Bot: $_botResponse',
              style: const TextStyle(fontSize: 18, color: Color(0xFFEB340D)),
            ),
          ],
        ),
      ),
    );
  }
}