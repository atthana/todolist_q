import 'package:flutter/material.dart';
// http method package
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class AddPage extends StatefulWidget {
  const AddPage({ Key? key }) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController todo_title = TextEditingController();
  TextEditingController todo_detail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('เพิ่มรายการใหม่'),),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [

            // ช่องกรอกข้อมูล title 
            TextField(
                    controller: todo_title,
                    decoration: InputDecoration(
                        labelText: 'รายการที่ต้องทำ', 
                        border: OutlineInputBorder())),
            SizedBox(height: 30,),
            TextField(
                    minLines: 4,
                    maxLines: 8,
                    controller: todo_detail,
                    decoration: InputDecoration(
                        labelText: 'รายละเอียด', 
                        border: OutlineInputBorder())),
            SizedBox(height: 30,),
            // ปุ่มเพิ่มข้อมูล
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                    onPressed: () {
                        print('-----------');
                        print('title: ${todo_title.text}');
                        print('detail: ${todo_detail.text}');
                        postTodo();
                        setState(() {
                          todo_title.clear();
                          todo_detail.clear();
                        });

                    }, 
                    child: Text("เพิ่มรายการ"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(50, 20, 50, 20)),
                      textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))
                      ),
                      ),
            ),


          ],
        ),
      ),
      
    );
  }

  Future postTodo() async {
    // var url = Uri.https('00fb-125-24-172-36.ngrok.io','/api/post-todolist');
    var url = Uri.http('172.20.10.2:8000','/api/post-todolist');  // ip from server จริงๆมันเลือกได้ด้วยนะ ว่าจะเป็น http หรือ https แต่ตอนนี้เราใช้ localhost เลยเป็น http เท่านั้น
    Map<String, String> header = {"Content-type":"application/json"};  // ใน Flutter เราต้องใชั ip ของ Mac นะ (ไม่ใช่ 192.168 เหมือนกับเครื่อง windows)
    String jsondata = '{"title":"${todo_title.text}", "detail":"${todo_detail.text}"}';
    var response = await http.post(url, headers: header, body: jsondata);
    print('------result-------');
    print(response.body);
  }


}


