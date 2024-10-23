

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class SpecificStop extends StatefulWidget {
//   final String stopName;

//   const SpecificStop({super.key, required this.stopName});

//   @override
//   State<SpecificStop> createState() => _SpecificStopState();
// }

// class _SpecificStopState extends State<SpecificStop> {
//   List<AttendanceData> attendanceList = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchAttendanceData(widget.stopName);
//   }

//   Future<void> fetchAttendanceData(String stopName) async {
//     try {
//       final response = await http.get(
//         Uri.parse('http://192.168.119.202:3000/attendance?stop_name=$stopName'),
//       );
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         setState(() {
//           attendanceList = data.map((item) => AttendanceData.fromJson(item)).toList();
//         });
//       } else {
//         print('Failed to load attendance data: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 114, 116, 247),
//         title: Text(
//           'Stop Name: ${widget.stopName}',
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Color.fromARGB(255, 252, 252, 252),
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
//       body: ListView.builder(
//         shrinkWrap: true,
//         physics: const AlwaysScrollableScrollPhysics(),
//         itemCount: attendanceList.length,
//         itemBuilder: (context, index) {
//           final attendance = attendanceList[index];
//           return AttendanceCard(
//             imageUrl:
//                 "https://static.vecteezy.com/system/resources/thumbnails/005/346/410/small_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg",
//             name: attendance.name,
//             roll_no: attendance.rollNumber,
//             seat_no: attendance.seatNo,
//             gender: attendance.gender,
//             stop_name: attendance.stopName,
//           );
//         },
//       ),
//     );
//   }
// }

// class AttendanceData {
//   final int id;
//   final String rollNumber;
//   final String name;
//   final String gender;
//   final String seatNo;
//   final String stopName;

//   AttendanceData({
//     required this.id,
//     required this.rollNumber,
//     required this.name,
//     required this.gender,
//     required this.seatNo,
//     required this.stopName,
//   });

//   factory AttendanceData.fromJson(Map<String, dynamic> json) {
//     return AttendanceData(
//       id: json['id'],
//       rollNumber: json['roll_number'],
//       name: json['name'],
//       gender: json['gender'],
//       seatNo: json['seat_no'],
//       stopName: json['stop_name'],
//     );
//   }
// }

// class AttendanceCard extends StatelessWidget {
//   final String imageUrl;
//   final String name;
//   final String roll_no;
//   final String seat_no;
//   final String gender;
//   final String stop_name;

//   const AttendanceCard({
//     Key? key,
//     required this.imageUrl,
//     required this.name,
//     required this.roll_no,
//     required this.seat_no,
//     required this.gender,
//     required this.stop_name,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(15),
//       ),
//       color: Colors.white,
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(7.0),
//         child: Row(
//           children: [
//             ClipOval(
//               child: Image.network(
//                 imageUrl,
//                 width: 50,
//                 height: 50,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Name: $name",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   Text(
//                     'Roll No: $roll_no',
//                     style: const TextStyle(
//                       fontSize: 14,
//                     ),
//                   ),
//                   Text(
//                     'Seat No: $seat_no',
//                     style: const TextStyle(
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:biometric_transport/total_seats.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SpecificStop extends StatefulWidget {
  final String stopName;

  const SpecificStop({super.key, required this.stopName});

  @override
  State<SpecificStop> createState() => _SpecificStopState();
}

class _SpecificStopState extends State<SpecificStop> {
  List<AttendanceData> attendanceList = [];

  @override
  void initState() {
    super.initState();
    fetchAttendanceData(widget.stopName);
  }

  Future<void> fetchAttendanceData(String stopName) async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.119.202:3000/attendance?stop_name=$stopName'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          attendanceList = data.map((item) => AttendanceData.fromJson(item)).toList();
        });
      } else {
        print('Failed to load attendance data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 114, 116, 247),
        title: Text(
          'Stop Name: ${widget.stopName}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 252, 252, 252),
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
      body: ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: attendanceList.length,
        itemBuilder: (context, index) {
          final attendance = attendanceList[index];
          return AttendanceCard(
            imageUrl: "https://static.vecteezy.com/system/resources/thumbnails/005/346/410/small_2x/close-up-portrait-of-smiling-handsome-young-caucasian-man-face-looking-at-camera-on-isolated-light-gray-studio-background-photo.jpg",
            name: attendance.name,
            roll_no: attendance.rollNumber,
            seat_no: attendance.seatNo,
            status: "Present", // Assuming you want to show a default status; change as needed
          );
        },
      ),
    );
  }
}

class AttendanceData {
  final int id;
  final String rollNumber;
  final String name;
  final String gender;
  final String seatNo;
  final String stopName;

  AttendanceData({
    required this.id,
    required this.rollNumber,
    required this.name,
    required this.gender,
    required this.seatNo,
    required this.stopName,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      id: json['id'],
      rollNumber: json['roll_number'],
      name: json['name'],
      gender: json['gender'],
      seatNo: json['seat_no'],
      stopName: json['stop_name'],
    );
  }
}
