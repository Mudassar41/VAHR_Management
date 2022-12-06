void main() {
  // var obj = Person<Cat, Dog>();

  final shape1 = Shape(ShapeType.circle);
  final shape2 = Shape(ShapeType.square);
  shape1.draw();
  shape2.draw();

  var details = Person.getTypye(name: 'std', fee: 1000);

  print(details.toString());
  details.getdetails();
}

enum ShapeType { circle, square }

abstract class Shape {
  factory Shape(ShapeType type) {
    switch (type) {
      case ShapeType.circle:
        return Circle();
      case ShapeType.square:
        return Square();
      default:
        return Circle();
    }
  }
  void draw();
}

class Circle implements Shape {
  @override
  void draw() {
    print("Circle");
  }
}

class Square implements Shape {
  @override
  void draw() {
    print("this is Square");
  }
}

abstract class Person {
  final String name;
  getdetails();
  Person(this.name);

  factory Person.getTypye({required name, salary, fee}) {
    if (name == 'std') {
      return Student(name, fee);
    } else {
      return Teacher(name, salary);
    }
  }
}

class Student extends Person {
  final int fee;

  Student(super.name, this.fee);
  @override
  getdetails() {
    print('$name $fee');
  }

  @override
  String toString() {
    // TODO: implement toString
    return fee.toString();
  }
}

class Teacher extends Person {
  final int salary;

  Teacher(super.name, this.salary);
  @override
  getdetails() {
    print('$name $salary');
  }

  @override
  String toString() {
    // TODO: implement toString
    return salary.toString();
  }
}
