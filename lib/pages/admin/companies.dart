import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firestore_example/model/company.dart';
import 'package:flutter_firestore_example/pages/login_screen.dart';
import 'package:flutter_firestore_example/services/company_services.dart';
import 'package:flutter_firestore_example/utils/auth_provider.dart';
import 'package:provider/provider.dart';

class CompanyPage extends StatefulWidget {
  CompanyPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _recycleTypeController = TextEditingController();
  final TextEditingController _pricePerTonController = TextEditingController();
  final companyRepository = CompanyServices.companyService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.key,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.moon_stars,
              color: Colors.deepOrange,
              size: 30.0,
            ),
            onPressed: () {
              Provider.of<UserRepository>(context, listen: false).signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginPage.routeName, (route) => false);
            },
          ),
        ],
      ),
      body: Center(
        child: StreamBuilder(
          stream:
              companyRepository.orderBy("name", descending: true).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final documentSnapshots = streamSnapshot.data!.docs;
                  final DocumentSnapshot documentSnapshot =
                      documentSnapshots[index];
                  Company company = documentSnapshot.data() as Company;
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(company.name),
                      onTap: null,
                      subtitle: Text(company.pricePerTon.toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () =>
                                    _createOrUpdate(context, company)),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () => _deleteCompany(company.uid)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(context, null),
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _createOrUpdate(context, [Company? company]) async {
    String action = 'create';
    if (company != null) {
      action = 'update';
      _companyNameController.text = company.name;
      _recycleTypeController.text = company.type;
      _pricePerTonController.text = company.pricePerTon.toString();
    }
    print("@${_companyNameController.text}");
    await showModalBottomSheet(
        enableDrag: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _companyNameController,
                  decoration: InputDecoration(labelText: 'Company Name'),
                  autofocus: true,
                  cursorColor: Colors.black,
                ),
                TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: _pricePerTonController,
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _pricePerTonController,
                  decoration: InputDecoration(
                    labelText: 'Recycle Type',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(onPressed: () => {}, child: Text("hellow ")),
                TextButton(
                  child: Text(
                    action == 'create' ? 'Create' : 'Update',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    final String? name = _companyNameController.text;
                    final String? type = _recycleTypeController.text;
                    final double? price =
                        double.tryParse(_pricePerTonController.text)!
                            .toDouble();

                    print("name $name");
                    print("type $type");
                    if (name != null && price != null) {
                      if (action == 'create') {
                        await companyRepository.add(
                            {name: name, type: type, "pricePerTon": price});
                      }
                      if (action == 'update') {
                        await companyRepository.doc(company!.uid).update(
                            {"name": name, "type": type, "pricePerTon": price});
                      }
                      _companyNameController.text = '';
                      _recycleTypeController.text = '';
                      _pricePerTonController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleting a product by id
  Future<void> _deleteCompany(String companyId) async {
    await companyRepository.doc(companyId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have successfully deleted a product')));
  }
}
