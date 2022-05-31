import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:note/global/enviroment.dart';
import 'package:note/model/note.dart';
import 'dart:convert';

class Service {

  static Future<List<Note>> getNotes() async {
    var url = Uri.parse('${Environment.apiUrl}');

    List<Note> listNote = [];
    try { 
      var response = await http.get(url,headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });

      var body = response.body; 
      listNote = noteFromMap(body);        
    } catch (e) { 
        return listNote;
    }
      return listNote; 
  }



  
  static Future<Note> createNote(Note note)async {
    var url = Uri.parse('${Environment.apiUrl}');
    Map<String, String> qParams = {
    'isImportant': note.isImportant.toString(),  
    'tittle': note.title,
    'description': note.description,
    };

    Map<String, String> header = {
    HttpHeaders.contentTypeHeader: "application/json"
    };

    final finalUri = url.replace(queryParameters: qParams); 

    try { 
      final response = await http.put(
        finalUri,
        headers: header,
      );


      if(response.statusCode >=  400) {
        return note;
      }
      if(response.statusCode ==  200) {
        return note;
      }          
    } catch (e) { 
      throw Exception(e);
    }
      return note; 
  }


  static Future<int> deleteNote(int id)async {
    var url = Uri.parse('${Environment.apiUrl}');
    Map<String, String> qParams = {
    'id': id.toString()
    };

    Map<String, String> header = {
    HttpHeaders.contentTypeHeader: "application/json"
    };

    final finalUri = url.replace(queryParameters: qParams); 
    var status;
    try { 
      final response = await http.delete(
        finalUri,
        headers: header,
      );
      status = response.statusCode;         
    } catch (e) { 
      throw Exception(e);
    }
      return status; 
  }


  static Future<Note> getNote(int id)async {
    var url = Uri.parse('${Environment.apiUrl}/${id}');

    Note note; 
    try { 
       var response = await http.get(url,headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        });
      var body = response.body; 
      print(body);      


      Map<String, dynamic> noteObjet = jsonDecode(body);
      note = Note.fromJson(noteObjet);
             
    } catch (e) { 
      throw Exception(e);
    }
      return note; 
  }
}
