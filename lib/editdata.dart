import 'package:flutter/material.dart';
import 'package:flutter_application_1/homepage.dart';
import 'package:http/http.dart' as http;

class EditDataPage extends StatefulWidget {
  final Map ListData;
  EditDataPage({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController id = TextEditingController();
  TextEditingController nim = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController prodi = TextEditingController();
  TextEditingController alamat = TextEditingController();

  Future _update() async {
    final respone = await http
        .post(Uri.parse('http://192.168.1.6/crud_flutter/edit.php'), body: {
      "id": id.text,
      "nim": nim.text,
      "nama": nama.text,
      "prodi": prodi.text,
      "alamat": alamat.text,
    });
    if (respone.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    id.text = widget.ListData['id'];
    nim.text = widget.ListData['nim'];
    nama.text = widget.ListData['nama'];
    prodi.text = widget.ListData['prodi'];
    alamat.text = widget.ListData['alamat'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Rubah Data"),
      ),
      body: Form(
          key: formKey,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: nim,
                  decoration: InputDecoration(
                      hintText: "NIM",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nim tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: nama,
                  decoration: InputDecoration(
                      hintText: "Nama Lengkap",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: prodi,
                  decoration: InputDecoration(
                      hintText: "Program Studi",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Program Studi tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: alamat,
                  decoration: InputDecoration(
                      hintText: "Alamat",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Alamat tidak boleh kosong!";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _update().then((value) {
                          if (value) {
                            final snackBar = SnackBar(
                              content: const Text('Data Berhasil Di Update!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            final snackBar = SnackBar(
                              content: const Text('Data Gagal Di Update!'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        });
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => HomePage())),
                            (route) => false);
                      }
                    },
                    child: Text("Update"))
              ],
            ),
          )),
    );
  }
}
