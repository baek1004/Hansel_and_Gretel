import 'package:flutter/material.dart';

void main() {

  runApp(HanselAndGretelApp());
}

class HanselAndGretelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '헨젤과 그레텔',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
//haha
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<String> _items = [];

  void _addItem(String item) {
    setState(() {
      _items.add(item);
    });
  }

  void _editItem(int index, String item) {
    setState(() {
      _items[index] = item;
    });
  }

  void _removeItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('헨젤과 그레텔'),
      ),
      body: _currentIndex == 0 ? MenuTab(
        items: _items,
        addItem: _addItem,
        editItem: _editItem,
        removeItem: _removeItem,
      ) : SettingsTab(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: '메뉴',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
      ),
    );
  }
}

class MenuTab extends StatelessWidget {
  final List<String> items;
  final Function(String) addItem;
  final Function(int, String) editItem;
  final Function(int) removeItem;

  MenuTab({required this.items, required this.addItem, required this.editItem, required this.removeItem});

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _textController,
          decoration: InputDecoration(
            hintText: '항목 입력',
          ),
          onSubmitted: (text) {
            addItem(text);
            _textController.clear();
          },
        ),
        Expanded(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(items[index]),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        _showEditDialog(context, index, items[index]);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        removeItem(index);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showEditDialog(BuildContext context, int index, String currentText) {
    final TextEditingController editController = TextEditingController(text: currentText);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('항목 수정'),
          content: TextField(
            controller: editController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                editItem(index, editController.text);
                Navigator.of(context).pop();
              },
              child: Text('저장'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('취소'),
            ),
          ],
        );
      },
    );
  }
}

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('설정 탭'),
    );
  }
}
//sujong hyeon
