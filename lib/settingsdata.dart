import 'package:flutter/material.dart';

class SettingsData extends StatefulWidget {
  const SettingsData({super.key});

  @override
  State<SettingsData> createState() => _SettingsDataState();
}

class _SettingsDataState extends State<SettingsData> {
  bool _isDarkMode = false;
  bool _showNotifications = true;
  String _selectedLanguage = 'Indonesia';
  double _fontSize = 14.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pengaturan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: [
          // Appearance Section
          _buildSectionHeader('Tampilan'),
          SwitchListTile(
            title: Text('Mode Gelap'),
            subtitle: Text('Mengaktifkan tema gelap'),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
                // Implementasi perubahan tema bisa ditambahkan di sini
              });
            },
          ),
          ListTile(
            title: Text('Ukuran Font'),
            subtitle: Text('${_fontSize.round()}'),
            trailing: SizedBox(
              width: 200,
              child: Slider(
                value: _fontSize,
                min: 12.0,
                max: 20.0,
                divisions: 8,
                label: _fontSize.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _fontSize = value;
                  });
                },
              ),
            ),
          ),

          // Notifications Section
          _buildSectionHeader('Notifikasi'),
          SwitchListTile(
            title: Text('Notifikasi'),
            subtitle: Text('Terima pemberitahuan tentang pembaruan data'),
            value: _showNotifications,
            onChanged: (bool value) {
              setState(() {
                _showNotifications = value;
              });
              // Tambahkan logika notifikasi di sini
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    value ? 'Notifikasi diaktifkan' : 'Notifikasi dinonaktifkan',
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),

          // Language Section
          _buildSectionHeader('Bahasa'),
          ListTile(
            title: Text('Pilih Bahasa'),
            subtitle: Text(_selectedLanguage),
            trailing: DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLanguage = newValue;
                  });
                  // Tambahkan logika pergantian bahasa di sini
                }
              },
              items: <String>['Indonesia', 'English']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),

          // Data Management Section
          _buildSectionHeader('Manajemen Data'),
          ListTile(
            leading: Icon(Icons.sync),
            title: Text('Sinkronisasi Data'),
            subtitle: Text('Terakhir sync: Belum pernah'),
            onTap: () {
              // Tambahkan logika sinkronisasi di sini
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Memulai sinkronisasi data...'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.cleaning_services),
            title: Text('Bersihkan Cache'),
            subtitle: Text('Hapus data temporary'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Bersihkan Cache'),
                    content: Text('Apakah Anda yakin ingin membersihkan cache?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Batal'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Ya'),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Tambahkan logika pembersihan cache di sini
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Cache berhasil dibersihkan'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),

          // About Section
          _buildSectionHeader('Tentang'),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Versi Aplikasi'),
            subtitle: Text('1.0.0'),
          ),
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Bantuan'),
            subtitle: Text('Panduan penggunaan aplikasi'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Bantuan'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Cara Penggunaan Aplikasi:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text('1. Tambah Data: Gunakan tombol + di bawah'),
                          Text('2. Edit Data: Tekan icon pensil pada data'),
                          Text('3. Hapus Data: Tekan icon tempat sampah'),
                          Text('4. Lihat Detail: Tekan pada item data'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Tutup'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text('Kebijakan Privasi'),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Kebijakan Privasi'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Kebijakan Privasi Aplikasi:',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text(
                              'Aplikasi ini menyimpan data mahasiswa untuk keperluan administrasi. Data yang disimpan meliputi:'),
                          Text('• Nama'),
                          Text('• NIM'),
                          Text('• Program Studi'),
                          Text('• Alamat'),
                          SizedBox(height: 8),
                          Text(
                              'Data tersebut hanya digunakan untuk keperluan internal dan tidak akan dibagikan kepada pihak ketiga.'),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Tutup'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }
}