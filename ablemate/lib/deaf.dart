// import 'package:flutter/material.dart';
// import 'httplink.dart';

// class DeafPage extends StatefulWidget {
//   @override
//   _DeafPageState createState() => _DeafPageState();
// }

// class _DeafPageState extends State<DeafPage> {
//   final TextEditingController _TextController = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     _TextController.dispose();
//   }

//   void outputSign() {}

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Helping Deaf Page',
//           style: TextStyle(
//               fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(15),
//           child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 // TextFormField(
//                 //   maxLines: 30,
//                 //   controller: _TextController,
//                 //   decoration: InputDecoration(
//                 //     border: OutlineInputBorder(),
//                 //     labelText:
//                 //         "Please Enter the Text You Want to Convert It into Sign",
//                 //   ),
//                 //   validator: (value) {
//                 //     if (value == null || value.isEmpty) {
//                 //       return 'Please Enter the Text You Want to Convert It into Sign';
//                 //     }
//                 //     return null;
//                 //   },
//                 // ),
//                 // SizedBox(
//                 //   height: 15,
//                 // ),
//                 LinkButton(url: "https://wecapable.com/tools/text-to-sign-language-converter/", buttonText: "Convert to Sign Language"),
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     outputSign();
//                 //   },
//                 //   child: Text(
//                 //     "Convert",
//                 //     style: TextStyle(
//                 //         color: Colors.white,
//                 //         fontSize: 20,
//                 //         fontWeight: FontWeight.bold),
//                 //   ),
//                 //   style: ElevatedButton.styleFrom(
//                 //       backgroundColor: Colors.blue,
//                 //       shape: RoundedRectangleBorder(
//                 //         borderRadius: BorderRadius.circular(10),
//                 //       ),
//                 //       padding: EdgeInsets.all(15)),
//                 // ),
//               ],
//               ),
//         ),
//       ),
//     );
//   }
// }
