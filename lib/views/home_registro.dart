import 'package:bike/widgets/registo_bike.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _allData = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  void _refreshData() async {
    final data = await SQLHelper.getAllData();
    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  Future<void> _addData() async {
    await SQLHelper.createData(_titleController.text,_blocoController.text,_tipodabikeController.text,
    _marcaController.text,_modeloController.text,_corController.text);
    _refreshData();
  }

  Future<void> _updateData(int id) async {
    await SQLHelper.updateData(id,_titleController.text,_blocoController.text,_tipodabikeController.text,
    _marcaController.text,_modeloController.text,_corController.text);
    _refreshData();
  }

  void _deleteData(int id) async {
    await SQLHelper.deleteData(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text("Dados excluídos"),
      ),
    );
    _refreshData();
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _blocoController = TextEditingController();
  final TextEditingController _tipodabikeController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _corController = TextEditingController();


  void showBottomSheet(int? id) async {
    if (id != null) {
      final existingData = _allData.firstWhere((element) => element['id'] == id);
      _titleController.text = existingData['title'];
      _blocoController.text = existingData['bloco'];
      _tipodabikeController.text = existingData['tipodabike'];
      _marcaController.text = existingData['marca'];
      _modeloController.text = existingData['modelo'];
      _corController.text = existingData['cor'];
      
    }

    showModalBottomSheet(
      elevation: 5,
      isScrollControlled: true,
      context: context,
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 30,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Título",
              ),
            ),
            SizedBox(height: 10),
             TextField(
              controller: _blocoController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Bloco",
              ),
            ),
            SizedBox(height: 10),
             TextField(
              controller: _tipodabikeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Tipo de bike",
              ),
            ),
            SizedBox(height: 10),
             TextField(
              controller: _marcaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Marca",
              ),
            ),
            SizedBox(height: 10),
             TextField(
              controller: _modeloController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Modelo",
              ),
            ),
            SizedBox(height: 10),
             TextField(
              controller: _corController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Cor",
              ),
            ),
            SizedBox(height: 10),
          
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addData();
                  } else {
                    await _updateData(id);
                  }
                  _titleController.text = "";
                  _blocoController.text = "";
                  _tipodabikeController.text = "";
                  _marcaController.text = "";
                  _modeloController.text = "";
                  _corController.text = "";
                

                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: EdgeInsets.all(18),
                  child: Text(
                    id == null ? "Adicionar dados" : "Atualizar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECEAF4),
      appBar: AppBar(
        title: Text("REGISTRO DA BIKE"),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _allData.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.all(15),
                child: ListTile(
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      _allData[index]['title'],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  subtitle: Text(_allData[index]['bloco']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => showBottomSheet(_allData[index]['id']),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteData(_allData[index]['id']),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: Icon(Icons.add),
      ),
    );
  }
}