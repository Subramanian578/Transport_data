// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// // ignore: depend_on_referenced_packages
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Total_Seats extends StatefulWidget {
//   final String busNumber;
//   const Total_Seats({super.key, required this.busNumber});

//   @override
//   State<Total_Seats> createState() => _Total_SeatsState();
// }

// class _Total_SeatsState extends State<Total_Seats> {
//   int Total_Seats = 55;
//   List<Map<String, dynamic>> stuDetails = [];
//   final DraggableScrollableController _controller =
//       DraggableScrollableController();
//   int maleCount = 0;
//   int femaleCount = 0;

//   // Function to create a row of SVG seats
//   Widget _buildSeatRow(Color color, int seatCount) {
//     return Row(
//       children: List.generate(seatCount, (index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SvgPicture.asset(
//             "assets/Red_Bus_Seat.svg",
//             color: color,
//             height: 25,
//             width: 25,
//           ),
//         );
//       }),
//     );
//   }

//   void _closeSheet() {
//     _controller.animateTo(
//       0.0, // 0.0 represents the fully closed position
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   void _expandSheet() {
//     _controller.animateTo(
//       0.25, // Adjust to your desired expanded size
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchBusStops();
//   }

//   Future<void> fetchBusStops() async {
//     try {
//       final response =
//           await http.get(Uri.parse('http://192.168.119.202:3000/m_students'));
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         setState(() {
//           stuDetails = data.map((item) {
//             return {
//               "gender": item['gender'],
//               "seat_no": item['seat_no'],
//               "name": item['name'],
//               "roll_no": item['roll_number'],
//               "bus-no": item['bus_no']
//             };
//           }).toList();
//           maleCount =
//               stuDetails.where((student) => student['gender'] == 'M').length;
//           femaleCount =
//               stuDetails.where((student) => student['gender'] == 'F').length;
//         });
//       } else {
//         print('Failed to load bus stops. Status code: ${response.statusCode}');
//         print('Response body: ${response.body}');
//       }
//     } catch (e) {
//       print('Error fetching bus stops: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Get screen width and height for responsiveness
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     // Calculate padding based on screen size
//     double horizontalPadding = screenWidth * 0.15; // 15% of screen width

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 114, 116, 247),
//         title: Text(
//           "Total - ${stuDetails.length} seats",
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//         ),
//       ),
//       body: InkWell(
//         splashColor: Colors.transparent,
//         onTap: _closeSheet,
//         child: Stack(
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: horizontalPadding),
//                     child: Column(
//                       children: [
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 20, horizontal: 10),
//                             child: SvgPicture.asset(
//                               "assets/car-steering-wheel.svg",
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: 1,
//                           width: double.infinity,
//                           color: Colors.grey,
//                         ),
//                         _buildSeatRow(Colors.grey, 1),
//                         for (int i = 0; i < 10; i++)
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               _buildSeatRow(Colors.grey, 2),
//                               const SizedBox(width: 20),
//                               _buildSeatRow(Colors.grey, 3),
//                             ],
//                           ),
//                       ],
//                     ),
//                   ),
//                   // Separate padding for AttendanceCard
//                   const SizedBox(height: 20),
//                   const Align(
//                     alignment: Alignment.centerLeft,
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       child: Text(
//                         "Overall Students",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: stuDetails.length,
//                     itemBuilder: (context, index) {
//                       final student = stuDetails[index];
//                       return AttendanceCard(
//                         imageUrl:
//                             "https://static.vecteezy.com/system/resources/thumbnails/005/346/410/small_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg",
//                         name: student['name'] ?? 'Unknown',
//                         roll_no: student['roll_no'] ?? 'N/A',
//                         seat_no: student['seat_no']?.toString() ?? 'N/A',
//                         status: "Present",
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 90), // Add some padding at the bottom
//                 ],
//               ),
//             ),
//             DraggableScrollableSheet(
//               controller: _controller,
//               initialChildSize: 0.1,
//               minChildSize: 0.1,
//               maxChildSize: 0.25,
//               builder:
//                   (BuildContext context, ScrollController scrollController) {
//                 return GestureDetector(
//                   onTap: _expandSheet,
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: Color.fromARGB(255, 114, 116, 247),
//                       borderRadius: BorderRadius.vertical(
//                         top: Radius.circular(30),
//                       ),
//                     ),
//                     child: ListView(
//                       controller: scrollController,
//                       padding: const EdgeInsets.symmetric(horizontal: 30),
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             buildCustomColumnLayout(
//                               title: "Male",
//                               onClick1: () {},
//                               onClick2: () {},
//                               onClick3: () {},
//                               onClick4: () {},
//                               text1: maleCount.toString(),
//                               text2: "PR",
//                               text3: "05",
//                               text4: "AB",
//                             ),
//                             buildCustomColumnLayout(
//                               title: "Female",
//                               onClick1: () {},
//                               onClick2: () {},
//                               onClick3: () {},
//                               onClick4: () {},
//                               text1: femaleCount.toString(),
//                               text2: "PR",
//                               text3: "09",
//                               text4: "AB",
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Function to create the customized layout
//   Widget buildCustomColumnLayout({
//     required String title,
//     required VoidCallback onClick1,
//     required VoidCallback onClick2,
//     required VoidCallback onClick3,
//     required VoidCallback onClick4,
//     required String text1,
//     required String text2,
//     required String text3,
//     required String text4,
//     double fontSize = 20,
//     FontWeight fontWeight = FontWeight.bold,
//     Color textColor = Colors.white,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 30),
//       child: Column(
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               color: textColor,
//               fontSize: fontSize,
//               fontWeight: fontWeight,
//             ),
//           ),
//           const SizedBox(height: 10),
//           Row(
//             children: [
//               Column(
//                 children: [
//                   buildCustomText(
//                     text: text1,
//                     onClick: onClick1,
//                     fontSize: fontSize,
//                     fontWeight: fontWeight,
//                     textColor: textColor,
//                   ),
//                   buildCustomText(
//                     text: text2,
//                     onClick: onClick2,
//                     fontSize: fontSize,
//                     fontWeight: fontWeight,
//                     textColor: textColor,
//                   ),
//                 ],
//               ),
//               const SizedBox(width: 15),
//               Column(
//                 children: [
//                   buildCustomText(
//                     text: text3,
//                     onClick: onClick3,
//                     fontSize: fontSize,
//                     fontWeight: fontWeight,
//                     textColor: textColor,
//                   ),
//                   buildCustomText(
//                     text: text4,
//                     onClick: onClick4,
//                     fontSize: fontSize,
//                     fontWeight: fontWeight,
//                     textColor: textColor,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   // Function to create a customizable Text widget
//   Widget buildCustomText({
//     required String text,
//     required VoidCallback onClick,
//     double fontSize = 16,
//     FontWeight fontWeight = FontWeight.normal,
//     Color textColor = Colors.white,
//   }) {
//     return GestureDetector(
//       onTap: onClick,
//       child: Text(
//         text,
//         style: TextStyle(
//           color: textColor,
//           fontSize: fontSize,
//           fontWeight: fontWeight,
//         ),
//       ),
//     );
//   }
// }

// class AttendanceCard extends StatelessWidget {
//   final String imageUrl;
//   final String name;
//   final String roll_no;
//   final String seat_no;
//   final String status;

//   const AttendanceCard({
//     Key? key,
//     required this.imageUrl,
//     required this.name,
//     required this.roll_no,
//     required this.seat_no,
//     required this.status,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Get screen width to adjust card layout
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//       child: ListTile(
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: Colors.grey, width: 1.5),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         leading: Padding(
//           padding: const EdgeInsets.only(right: 10),
//           child: CircleAvatar(
//             radius: 25,
//             backgroundImage: NetworkImage(imageUrl),
//           ),
//         ),
//         title: Row(
//           children: [
//             const Text("Name: "),
//             Text(
//               name,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Roll No: $roll_no'),
//             Text('Seat No: $seat_no'),
//           ],
//         ),
//         trailing: Text(
//           status,
//           style: TextStyle(
//             color: status == "Present" ? Colors.green : Colors.red,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // // ignore: depend_on_referenced_packages
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // class Total_Seats extends StatefulWidget {
// //   final String busNumber; // Accept the bus number from the dashboard

// //   const Total_Seats({super.key, required this.busNumber}); // Constructor

// //   @override
// //   State<Total_Seats> createState() => _Total_SeatsState();
// // }

// // class _Total_SeatsState extends State<Total_Seats> {
// //   int Total_Seats = 55;
// //   List<Map<String, dynamic>> stuDetails = [];
// //   final DraggableScrollableController _controller = DraggableScrollableController();
// //   int maleCount = 0;
// //   int femaleCount = 0;

// //   // Function to create a row of SVG seats
// //   Widget _buildSeatRow(Color color, int seatCount) {
// //     return Row(
// //       children: List.generate(seatCount, (index) {
// //         return Padding(
// //           padding: const EdgeInsets.all(8.0),
// //           child: SvgPicture.asset(
// //             "assets/Red_Bus_Seat.svg",
// //             color: color,
// //             height: 25,
// //             width: 25,
// //           ),
// //         );
// //       }),
// //     );
// //   }

// //   void _closeSheet() {
// //     _controller.animateTo(
// //       0.0, // 0.0 represents the fully closed position
// //       duration: const Duration(milliseconds: 300),
// //       curve: Curves.easeInOut,
// //     );
// //   }

// //   void _expandSheet() {
// //     _controller.animateTo(
// //       0.25, // Adjust to your desired expanded size
// //       duration: const Duration(milliseconds: 300),
// //       curve: Curves.easeInOut,
// //     );
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     fetchBusStops();
// //   }

// //   Future<void> fetchBusStops() async {
// //     try {
// //       final response = await http.get(Uri.parse('http://192.168.119.202:3000/m_students'));
// //       if (response.statusCode == 200) {
// //         final List<dynamic> data = json.decode(response.body);
// //         setState(() {
// //           // Filter student details based on the bus number
// //           stuDetails = data
// //               .where((item) => item['bus_number'] == widget.busNumber)
// //               .map((item) {
// //             return {
// //               "gender": item['gender'],
// //               "seat_no": item['seat_no'],
// //               "name": item['name'],
// //               "roll_no": item['roll_number']
// //             };
// //           }).toList();
// //           maleCount = stuDetails.where((student) => student['gender'] == 'M').length;
// //           femaleCount = stuDetails.where((student) => student['gender'] == 'F').length;
// //         });
// //       } else {
// //         print('Failed to load bus stops. Status code: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       print('Error fetching bus stops: $e');
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     double screenWidth = MediaQuery.of(context).size.width;
// //     double horizontalPadding = screenWidth * 0.15; // 15% of screen width

// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: const Color.fromARGB(255, 114, 116, 247),
// //         title: Text(
// //           "Total - ${stuDetails.length} seats",
// //           style: const TextStyle(
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //             color: Colors.white,
// //           ),
// //         ),
// //         leading: IconButton(
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //           icon: const Icon(
// //             Icons.arrow_back,
// //             color: Colors.white,
// //           ),
// //         ),
// //       ),
// //       body: InkWell(
// //         splashColor: Colors.transparent,
// //         onTap: _closeSheet,
// //         child: Stack(
// //           children: [
// //             SingleChildScrollView(
// //               child: Column(
// //                 children: [
// //                   Padding(
// //                     padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
// //                     child: Column(
// //                       children: [
// //                         Align(
// //                           alignment: Alignment.centerRight,
// //                           child: Padding(
// //                             padding: const EdgeInsets.symmetric(
// //                                 vertical: 20, horizontal: 10),
// //                             child: SvgPicture.asset(
// //                               "assets/car-steering-wheel.svg",
// //                               color: Colors.grey,
// //                             ),
// //                           ),
// //                         ),
// //                         Container(
// //                           height: 1,
// //                           width: double.infinity,
// //                           color: Colors.grey,
// //                         ),
// //                         _buildSeatRow(Colors.grey, 1),
// //                         for (int i = 0; i < 10; i++)
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               _buildSeatRow(Colors.grey, 2),
// //                               const SizedBox(width: 20),
// //                               _buildSeatRow(Colors.grey, 3),
// //                             ],
// //                           ),
// //                       ],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   const Align(
// //                     alignment: Alignment.centerLeft,
// //                     child: Padding(
// //                       padding: EdgeInsets.symmetric(horizontal: 15),
// //                       child: Text(
// //                         "Overall Students",
// //                         style: TextStyle(
// //                           fontSize: 20,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                   ListView.builder(
// //                     shrinkWrap: true,
// //                     physics: const NeverScrollableScrollPhysics(),
// //                     itemCount: stuDetails.length,
// //                     itemBuilder: (context, index) {
// //                       final student = stuDetails[index];
// //                       return AttendanceCard(
// //                         imageUrl:
// //                             "https://static.vecteezy.com/system/resources/thumbnails/005/346/410/small_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg",
// //                         name: student['name'] ?? 'Unknown',
// //                         roll_no: student['roll_no'] ?? 'N/A',
// //                         seat_no: student['seat_no']?.toString() ?? 'N/A',
// //                         status: "Present",
// //                       );
// //                     },
// //                   ),
// //                   const SizedBox(height: 90),
// //                 ],
// //               ),
// //             ),
// //             DraggableScrollableSheet(
// //               controller: _controller,
// //               initialChildSize: 0.1,
// //               minChildSize: 0.1,
// //               maxChildSize: 0.25,
// //               builder: (BuildContext context, ScrollController scrollController) {
// //                 return GestureDetector(
// //                   onTap: _expandSheet,
// //                   child: Container(
// //                     decoration: const BoxDecoration(
// //                       color: Color.fromARGB(255, 114, 116, 247),
// //                       borderRadius: BorderRadius.vertical(
// //                         top: Radius.circular(30),
// //                       ),
// //                     ),
// //                     child: ListView(
// //                       controller: scrollController,
// //                       padding: const EdgeInsets.symmetric(horizontal: 30),
// //                       children: [
// //                         Row(
// //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                           children: [
// //                             buildCustomColumnLayout(
// //                               title: "Male",
// //                               onClick1: () {},
// //                               onClick2: () {},
// //                               onClick3: () {},
// //                               onClick4: () {},
// //                               text1: maleCount.toString(),
// //                               text2: "PR",
// //                               text3: "05",
// //                               text4: "AB",
// //                             ),
// //                             buildCustomColumnLayout(
// //                               title: "Female",
// //                               onClick1: () {},
// //                               onClick2: () {},
// //                               onClick3: () {},
// //                               onClick4: () {},
// //                               text1: femaleCount.toString(),
// //                               text2: "PR",
// //                               text3: "09",
// //                               text4: "AB",
// //                             ),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget buildCustomColumnLayout({
// //     required String title,
// //     required VoidCallback onClick1,
// //     required VoidCallback onClick2,
// //     required VoidCallback onClick3,
// //     required VoidCallback onClick4,
// //     required String text1,
// //     required String text2,
// //     required String text3,
// //     required String text4,
// //     double fontSize = 20,
// //     FontWeight fontWeight = FontWeight.bold,
// //     Color textColor = Colors.white,
// //   }) {
// //     return Padding(
// //       padding: const EdgeInsets.all(8.0),
// //       child: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         children: [
// //           Text(
// //             title,
// //             style: TextStyle(
// //               fontSize: fontSize,
// //               fontWeight: fontWeight,
// //               color: textColor,
// //             ),
// //           ),
// //           const SizedBox(height: 10),
// //           GestureDetector(
// //             onTap: onClick1,
// //             child: Text(
// //               text1,
// //               style: TextStyle(
// //                 fontSize: fontSize,
// //                 fontWeight: fontWeight,
// //                 color: textColor,
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 10),
// //           GestureDetector(
// //             onTap: onClick2,
// //             child: Text(
// //               text2,
// //               style: TextStyle(
// //                 fontSize: fontSize,
// //                 fontWeight: fontWeight,
// //                 color: textColor,
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 10),
// //           GestureDetector(
// //             onTap: onClick3,
// //             child: Text(
// //               text3,
// //               style: TextStyle(
// //                 fontSize: fontSize,
// //                 fontWeight: fontWeight,
// //                 color: textColor,
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 10),
// //           GestureDetector(
// //             onTap: onClick4,
// //             child: Text(
// //               text4,
// //               style: TextStyle(
// //                 fontSize: fontSize,
// //                 fontWeight: fontWeight,
// //                 color: textColor,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// class AttendanceCard extends StatelessWidget {
//   final String imageUrl;
//   final String name;
//   final String roll_no;
//   final String seat_no;
//   final String status;

//   const AttendanceCard({
//     super.key,
//     required this.imageUrl,
//     required this.name,
//     required this.roll_no,
//     required this.seat_no,
//     required this.status,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundImage: NetworkImage(imageUrl),
//         ),
//         title: Text(name),
// subtitle: Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//     Text("Roll No: $roll_no"),
//     Text("Seat No: $seat_no"),
//   ],
// ),
//         trailing: Text(
//           status,
//           style: TextStyle(
//             color: status == "Present" ? Colors.green : Colors.red,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Total_Seats extends StatefulWidget {
  final String busNumber;
  const Total_Seats({super.key, required this.busNumber});

  @override
  State<Total_Seats> createState() => _Total_SeatsState();
}

class _Total_SeatsState extends State<Total_Seats> {
  int Total_Seats = 55;
  List<Map<String, dynamic>> stuDetails = [];
  final DraggableScrollableController _controller =
      DraggableScrollableController();
  int maleCount = 0;
  int femaleCount = 0;

  // Function to create a row of SVG seats
  Widget _buildSeatRow(Color color, int seatCount) {
    return Row(
      children: List.generate(seatCount, (index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            "assets/Red_Bus_Seat.svg",
            color: color,
            height: 25,
            width: 25,
          ),
        );
      }),
    );
  }

  void _closeSheet() {
    _controller.animateTo(
      0.0, // 0.0 represents the fully closed position
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _expandSheet() {
    _controller.animateTo(
      0.25, // Adjust to your desired expanded size
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    fetchBusStops();
  }

  Future<void> fetchBusStops() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.119.202:3000/m_students?bus_no=${widget.busNumber}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          stuDetails = data.map((item) {
            return {
              "gender": item['gender'],
              "seat_no": item['seat_no'],
              "name": item['name'],
              "roll_no": item['roll_number'],
              "bus-no": item['bus_no']
            };
          }).toList();
          maleCount =
              stuDetails.where((student) => student['gender'] == 'M').length;
          femaleCount =
              stuDetails.where((student) => student['gender'] == 'F').length;
        });
      } else {
        print('Failed to load bus stops. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching bus stops: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width and height for responsiveness
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Calculate padding based on screen size
    double horizontalPadding = screenWidth * 0.15; // 15% of screen width

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 116, 247),
        title: Text(
          "Total - ${stuDetails.length} seats",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: InkWell(
        splashColor: Colors.transparent,
        onTap: _closeSheet,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: SvgPicture.asset(
                              "assets/car-steering-wheel.svg",
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Colors.grey,
                        ),
                        _buildSeatRow(Colors.grey, 1),
                        for (int i = 0; i < 10; i++)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildSeatRow(Colors.grey, 2),
                              const SizedBox(width: 20),
                              _buildSeatRow(Colors.grey, 3),
                            ],
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Overall Students",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: stuDetails.length,
                    itemBuilder: (context, index) {
                      final student = stuDetails[index];
                      return AttendanceCard(
                        imageUrl:
                            "https://static.vecteezy.com/system/resources/thumbnails/005/346/410/small_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg",
                        name: student['name'] ?? 'Unknown',
                        roll_no: student['roll_no'] ?? 'N/A',
                        seat_no: student['seat_no']?.toString() ?? 'N/A',
                        status: "Present",
                      );
                    },
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
            DraggableScrollableSheet(
              controller: _controller,
              initialChildSize: 0.1,
              minChildSize: 0.1,
              maxChildSize: 0.25,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return GestureDetector(
                  onTap: _expandSheet,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 114, 116, 247),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    child: ListView(
                      controller: scrollController,
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildCustomColumnLayout(
                              title: "Male",
                              onClick1: () {},
                              onClick2: () {},
                              onClick3: () {},
                              onClick4: () {},
                              text1: maleCount.toString(),
                              text2: "PR",
                              text3: "05",
                              text4: "AB",
                            ),
                            buildCustomColumnLayout(
                              title: "Female",
                              onClick1: () {},
                              onClick2: () {},
                              onClick3: () {},
                              onClick4: () {},
                              text1: femaleCount.toString(),
                              text2: "PR",
                              text3: "09",
                              text4: "AB",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCustomColumnLayout({
    required String title,
    required VoidCallback onClick1,
    required VoidCallback onClick2,
    required VoidCallback onClick3,
    required VoidCallback onClick4,
    required String text1,
    required String text2,
    required String text3,
    required String text4,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.bold,
    Color textColor = Colors.white,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                children: [
                  buildCustomText(
                    text: text1,
                    onClick: onClick1,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    textColor: textColor,
                  ),
                  buildCustomText(
                    text: text2,
                    onClick: onClick2,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    textColor: textColor,
                  ),
                ],
              ),
              const SizedBox(width: 15),
              Column(
                children: [
                  buildCustomText(
                    text: text3,
                    onClick: onClick3,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    textColor: textColor,
                  ),
                  buildCustomText(
                    text: text4,
                    onClick: onClick4,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    textColor: textColor,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildCustomText({
    required String text,
    required VoidCallback onClick,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    Color textColor = Colors.white,
  }) {
    return GestureDetector(
      onTap: onClick,
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

class AttendanceCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String roll_no;
  final String seat_no;
  final String status;

  const AttendanceCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.roll_no,
    required this.seat_no,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width to adjust card layout
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListTile(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        title: Row(
          children: [
            const Text("Name: "),
            Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Roll No: $roll_no'),
            Text('Seat No: $seat_no'),
          ],
        ),
        trailing: Text(
          status,
          style: TextStyle(
            color: status == "Present" ? Colors.green : Colors.red,
          ),
        ),
      ),
    );
  }
}
