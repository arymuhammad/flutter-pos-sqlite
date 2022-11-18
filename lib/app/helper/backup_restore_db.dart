import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';

import 'package:file_picker/file_picker.dart';

class BackupRestoreDb extends StatefulWidget {
  const BackupRestoreDb({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BackupRestoreDb> createState() => _BackupRestoreDbState();
}

class _BackupRestoreDbState extends State<BackupRestoreDb> {
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 29, 30, 32),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(message),
            ElevatedButton.icon(
              icon: const Icon(Icons.backup),
              onPressed: () async {
                final dbFolder = await getDatabasesPath();
                // if ((await copyTo.exists())) {
                // print("Path exist");
                var status = await Permission.manageExternalStorage.status;
                if (!status.isGranted) {
                  await Permission.manageExternalStorage.request();
                }

                var status1 = await Permission.storage.status;
                if (!status1.isGranted) {
                  await Permission.storage.request();
                }

                try {
                  File source1 = File('$dbFolder/penjualan.db');
                  // print(source1);
                  Directory copyTo = Directory('/storage/emulated/0/POSapp');
                  await copyTo.create();
                  await source1.copy('/storage/emulated/0/POSapp/penjualan.db');
                } catch (e) {
                  print("================== error =====${e.toString()}");
                }
                // }
                //  else {
                //   // print("not exist");
                //   if (await Permission.manageExternalStorage
                //       .request()
                //       .isGranted) {
                //     // Either the permission was already granted before or the user just granted it.
                //     await copyTo.create();
                //   } else {
                //     // print('Please give permission');
                //   }
                // }
                // copyTo.deleteSync(recursive: true);
                // await copyTo.create();
                // String newPath = "${copyTo.path}/penjualan.db";
                // print(newPath);

                setState(() {
                  message = 'Successfully Backup DataBase';
                });
              },
              label: const Text('Backup DataBase'),
            ),
            // ElevatedButton(
            //   onPressed: () async {
            //     var databasesPath = await getDatabasesPath();
            //     var dbPath = join(databasesPath, 'penjualan.db');
            //     await deleteDatabase(dbPath);
            //     setState(() {
            //       message = 'Successfully deleted DB';
            //     });
            //   },
            //   child: const Text('Delete DB'),
            // ),
            ElevatedButton.icon(
              icon: const Icon(Icons.cloud_download_rounded),
              onPressed: () async {
                var databasesPath = await getDatabasesPath();
                // var dbPath = join(databasesPath, 'penjualan.db');

                var status = await Permission.manageExternalStorage.status;
                if (!status.isGranted) {
                  await Permission.manageExternalStorage.request();
                }

                var status1 = await Permission.storage.status;
                if (!status1.isGranted) {
                  await Permission.storage.request();
                }

                try {
                  File savedDb =
                      File("/storage/emulated/0/POSapp/penjualan.db");
                  // File source1 = File('$savedDb/penjualan.db');
                  // print(source1);
                  await savedDb.copy('$databasesPath/penjualan.db');
                } catch (e) {
                  print("================== error =====${e.toString()}");
                }

                //   print(dbPath);
                //   FilePickerResult? result =
                //       await FilePicker.platform.pickFiles();
                //   print(result);
                //   if (result != null) {
                //     File source = File(result.files.single.path!);
                //     print(source);
                //     await source.copy(dbPath);
                setState(() {
                  message = 'Successfully Restored DB';
                });
                //   } else {
                //     // User canceled the picker
                //   }
              },
              label: const Text('Restore DataBase'),
            ),
          ],
        ),
      ),
    );
  }
}
