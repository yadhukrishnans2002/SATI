import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class NotesVideosScreen extends StatefulWidget {
  final String deptid, semid, subid, modid;
  const NotesVideosScreen(
      {super.key,
      required this.deptid,
      required this.semid,
      required this.subid,
      required this.modid});

  @override
  State<NotesVideosScreen> createState() => _NotesVideosScreenState();
}

class _NotesVideosScreenState extends State<NotesVideosScreen> {
  final _formKey = GlobalKey<FormState>();
  final _videonameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final modid = widget.modid;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('${modid}videos')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            List<DocumentSnapshot> documents = snapshot.data!.docs;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                String downloadUrl = documents[index].get('downloadUrl');
                return Column(
                  children: [
                    const Divider(
                      height: 10,
                      color: Colors.white,
                      thickness: 0.0,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(7),
                      tileColor: Colors.white,
                      title: Text(
                        documents[index].get('name'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // trailing: IconButton(
                      //   onPressed: () async {
                      //     String docId = documents[index].id;
                      //     Reference ref =
                      //         FirebaseStorage.instance.refFromURL(downloadUrl);
                      //     await ref.delete();
                      //     await FirebaseFirestore.instance
                      //         .collection('${modid}videos')
                      //         .doc(docId)
                      //         .delete();
                      //   },
                      //   icon: Icon(Icons.delete_forever),
                      //   color: Colors.purple,
                      // ),
                      leading: IconButton(
                          color: Colors.purple,
                          onPressed: () async {
                            if (await Permission.storage.request().isGranted) {
                              final dir = await getExternalStorageDirectory();
                              final file = File(
                                  '${dir!.path}/${documents[index].get('name')}.mp4');
                              print(dir.path);
                              Reference ref = FirebaseStorage.instance
                                  .refFromURL(downloadUrl);
                              print(downloadUrl);
                              await ref.writeToFile(file);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('File downloaded successfully'),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Permission denied'),
                              ));
                            }
                          },
                          icon: const Icon(Icons.download)),
                      onTap: () async {
                        print(downloadUrl);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => PDFView(
                        //             filePath: downloadUrl,
                        //           )
                        //       // PdfViewScreen(
                        //       //   Urls: downloadUrl,
                        //       // ),
                        //       ),
                        // );
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _showBottomSheet(context);
      //   },
      //   child: Icon(Icons.picture_as_pdf_outlined),
      // ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    final modid = widget.modid;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200.0,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _videonameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Module Name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _videonameController.text = value!;
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.catching_pokemon_outlined),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: 'Module Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                icon: Icon(Icons.upload),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final videoname = _videonameController.text;
                    final status = await Permission.storage.request();
                    if (status.isGranted) {
                      File videoFile = await pickPDFFile();
                      String downloadUrl = await uploadPDF(videoFile);
                      FirebaseFirestore.instance
                          .collection('${modid}videos')
                          .add({
                        'name': basename(videoname),
                        // pdfFile.path
                        'downloadUrl': downloadUrl,
                      });
                    }
                    _videonameController.clear();
                    Navigator.pop(context);
                  } else {
                    print('permission not granted');
                  }
                },
                label: Text('Upload File'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<String> uploadPDF(File videoFile) async {
    final modid = widget.modid;
    String fileName = basename(videoFile.path);
    Reference ref =
        FirebaseStorage.instance.ref('${modid}videos/').child(fileName);
    TaskSnapshot task = await ref.putFile(videoFile);
    return await task.ref.getDownloadURL();
  }

  Future<File> pickPDFFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['MP4', 'AVI'],
    );
    if (result != null) {
      return File(result.files.single.path!);
    } else {
      throw Exception('No file selected');
    }
  }

  Future<void> requestPermission() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      // Permission is granted. You can now upload files.
    } else {
      // Permission is denied. You should handle this case appropriately.
    }
  }
}
