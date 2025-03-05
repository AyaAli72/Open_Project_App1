import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Just a minute."),
              titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 35.2,
                  fontWeight: FontWeight.w800),
              backgroundColor: Colors.blue,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 5, width: 5),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Patient",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5, width: 5),
                  ElevatedButton(
                    onPressed: () {},
                    // style:  ElevatedButton.styleFrom(
                    //   shape:  RoundedRectangleBorder(
                    //     borderRadius:  BorderRadius.circular(10)
                    //   )
                    // ),
                    child: const Text(
                      "Doctor",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5, width: 5),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Hospital",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5, width: 5),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Pharmacy",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5, width: 5),
                ],
              ),
            )
            // body: Container(

            //     alignment: Alignment.bottomCenter,
            //     padding: const EdgeInsets.all(20),
            //     margin: const EdgeInsets.all(20),
            //     decoration: BoxDecoration(
            //         color: const Color.fromARGB(255, 88, 137, 221),
            //         borderRadius: BorderRadius.circular(20)),
            //     width: 400,
            //     height: 700,
            //     child: const Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       children: [
            //         Text(
            //           "Patient",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 30,
            //               fontWeight: FontWeight.bold,
            //               textBaseline: TextBaseline.alphabetic),
            //         ),
            //         Text(
            //           "Doctore",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 30,
            //               fontWeight: FontWeight.bold,
            //               textBaseline: TextBaseline.alphabetic),
            //         ),
            //         Text(
            //           "Pharmacy",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 30,
            //               fontWeight: FontWeight.bold,
            //               textBaseline: TextBaseline.alphabetic),
            //         ),
            //         Text(
            //           "Hospital",
            //           style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 30,
            //               fontWeight: FontWeight.bold,
            //               textBaseline: TextBaseline.alphabetic),
            //         )
            //       ],
            // ))
            ));
  }
}
