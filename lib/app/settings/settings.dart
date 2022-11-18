import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_first_app/app/helper/backup_restore_db.dart';

import '../../print_setting.dart';

class SettingsView extends GetView {
  const SettingsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pengaturan'),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 29, 30, 32),
        ),
        body: SizedBox(
          child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                ListTile(
                leading: const Icon(Icons.local_printshop_rounded),
                  title: const Text('Printer Setting'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => Get.to(() => const PrintSetting(data: null)),
                ),
                const Divider(),
                ListTile(
                leading: const Icon(Icons.backup),
                  title: const Text('Backup / Restore Database'),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () => Get.to(() => const BackupRestoreDb(title: 'Backup / Restore')),
                ),
                const Divider(),
              ]),
        ));
  }
}
