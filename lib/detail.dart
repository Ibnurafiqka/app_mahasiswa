import 'package:flutter/material.dart';
import 'package:flutter_application_1/editdata.dart';

class DetailPage extends StatelessWidget {
  final Map listData;

  const DetailPage({Key? key, required this.listData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Mahasiswa"),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditDataPage(
                    ListData: {
                      'id': listData['id'],
                      'nim': listData['nim'],
                      'nama': listData['nama'],
                      'prodi': listData['prodi'],
                      'alamat': listData['alamat']
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Colors.blue,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Text(
                      listData['nama'][0].toUpperCase(),
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    listData['nama'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    listData['nim'],
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Informasi Akademik"),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            icon: Icons.school,
                            label: "Program Studi",
                            value: listData['prodi'],
                          ),
                          Divider(),
                          _buildInfoRow(
                            icon: Icons.grade,
                            label: "Semester",
                            value: listData['semester'] ?? "1",
                          ),
                          Divider(),
                          _buildInfoRow(
                            icon: Icons.corporate_fare,
                            label: "Fakultas",
                            value:
                                listData['fakultas'] ?? "Teknologi Informasi",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildSectionTitle("Informasi Pribadi"),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildInfoRow(
                            icon: Icons.location_on,
                            label: "Alamat",
                            value: listData['alamat'],
                          ),
                          Divider(),
                          _buildInfoRow(
                            icon: Icons.phone,
                            label: "No. Telepon",
                            value: listData['telepon'] ?? "-",
                          ),
                          Divider(),
                          _buildInfoRow(
                            icon: Icons.email,
                            label: "Email",
                            value: listData['email'] ??
                                "${listData['nim']}@student.ac.id",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  _buildSectionTitle("Status Akademik"),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildStatusItem(
                            "Status Mahasiswa",
                            "Aktif",
                            Colors.green,
                          ),
                          SizedBox(height: 12),
                          _buildStatusItem(
                            "Status Pembayaran",
                            "Lunas",
                            Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusItem(String label, String status, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
