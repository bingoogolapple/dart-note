library dart_note.src.student;

import 'person.dart';

class Student extends Person {
  Student(String name) : super(name);

  String id = '';

  String toString() => 'Name:$name  ID:$id';
}
