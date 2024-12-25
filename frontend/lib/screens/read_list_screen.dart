// import 'package:flutter/material.dart';
// import '../services/read_list_service.dart';

// class ReadListScreen extends StatefulWidget {
//   final String userId;

//   const ReadListScreen({Key? key, required this.userId}) : super(key: key);

//   @override
//   _ReadListScreenState createState() => _ReadListScreenState();
// }

// class _ReadListScreenState extends State<ReadListScreen> {
//   final ReadListService _readListService = ReadListService();
//   late Future<List<dynamic>> _readListFuture;

//   @override
//   void initState() {
//     super.initState();
//     _readListFuture = _readListService.fetchReadList(widget.userId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Read List")),
//       body: FutureBuilder<List<dynamic>>(
//         future: _readListFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Error: ${snapshot.error}"));
//           } else {
//             final readList = snapshot.data ?? [];
//             if (readList.isEmpty) {
//               return const Center(child: Text("Your read list is empty."));
//             }
//             return ListView.builder(
//               itemCount: readList.length,
//               itemBuilder: (context, index) {
//                 final book = readList[index];
//                 return ListTile(
//                   title: Text(book['title']),
//                   subtitle: Text(book['author']),
//                   leading: book['image'] != null
//                       ? Image.network(book['image'], width: 50, height: 50, fit: BoxFit.cover)
//                       : const Icon(Icons.book),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }

