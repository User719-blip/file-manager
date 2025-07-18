import 'package:file_manager/feature/categories/download/presentation/pages/download_page.dart';
import 'package:file_manager/feature/categories/images/presentation/pages/image_page.dart';
import 'package:file_manager/feature/home/presentation/widgets/chip.dart';
import 'package:file_manager/feature/home/presentation/widgets/searchbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FILE MANAGER')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Searchbar(),
            SizedBox(height :20),
            GridChipSection(
              title: 'Categories',
              items: ['Documents', 'Images', 'Videos' , 'Audio' , 'Apps' , 'Downloads'],
              onTap: (label) {
                if (label == 'Downloads') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => DownloadsPage()));
                }
                if (label == 'Images') {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => ImagePage()));
                }
              },
            ),
            SizedBox(height: 20),
            GridChipSection(
              title: 'Storage Options',
              items: ['Internal Storage', 'Send To database'],
              onTap: (label) {
                // 
              },
            ),
            SizedBox(height: 20),
            GridChipSection(
              title: 'Tools',
              items: ['Image to pdf', 'Compress Files', 'Extract Zip' , 'Convert zip'],
              onTap: (label) {
                // Handle tool tap
              },
            ),
          ],
        ),
      ),

    );
  }
}


//  title: "Categories",
//   items: ["Downloads", "Images", "Videos"],
//   onTap: (label) {
//     if (label == "Downloads") {
//       Navigator.push(context, MaterialPageRoute(builder: (_) => DownloadsPage()));
//     } else if (label == "Images") {
//       Navigator.push(context, MaterialPageRoute(builder: (_) => ImagesPage()));
//     }
//     // and so on...
//   },
