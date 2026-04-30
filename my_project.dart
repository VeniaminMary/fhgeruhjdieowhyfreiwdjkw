import 'dart:math';
// class Person{

//     String name;
//     int age;     

//     factory Person(String name, int age)
//     {
//         if(name.length <2)
//         {
//             name = "Undefined";
//         }
//         if(age <1 || age > 110)
//         {
//             age = 18;
//         }
//         return Person._create(name, age);
//     }

//     Person._create(this.name, this.age);

//     void display() => print("Name: $name \tAge: $age");
// }



// class Singleton{
//   Singleton._();
//   static Singleton _instance = Singleton._();
//   factory Singleton() => _instance;

// }

// void main(){
//   Person pers3=Person("в", 7);

// }

// class Bank{
//   double _balance;
//   Bank(double _balance): this._create(_balance);
//   Bank._create(this._balance);
// //сокрытие поведения объектов 
// //создается шаблонная сущность с определнием но без реализации

//   double deposit(double amount){
//     if(amount<0){
//       print("Невозможно пополнить");
//     }
//     return amount+=_balance;
//   }

//   double get balance=> _balance;
//   set setBalance(double value){
//     if(value<0){
//       print("нельзя");
//     }
//     else{
//       value=_balance;
//     }
//   }
// }

// void main1(){
//   var bank=Bank(100);
//   print(bank.balance);
//   bank.setBalance=-100;
//   print(bank.balance);
// }

// class A{
//   int a;
//   int b;

//   //именованный и фабричный конструкторы
//   //может быть множество конструкторов
//   A(this.a,this.b);

//   int sum(){
//     return a+b;
//   }
// }

// class B extends A{
//   int c;
//   B(super.a,super.b,this.c);//консруктор
//   // B(int a,int b,this.c):super(a,b);

//   @override //анотация для переопределния
//   //это проявление полиморфизма
//   int sum(){
//     return a+b+c;
//   }//без конструктора должны быть присвоины значения по умолчанию
// }

// class C{
//   late String name;

//   C(String name){
//   if (name!="admin") this.name=name;
//   else{
//     this.name="неизвестно";
//   }
//   }
// }

// void main(){
//   A a=A(4,5);
//   print(a.sum());
//   B b=B(4,5,6);
//   print(b.sum());
// }


// class Person{
//   String name;
//   int age;
//   Person(this.name,this.age);
//   static const int pensionAge=60;//потребляет память только в момент использования

//   void info()=> print("$name $age $pensionAge");
//   void check(){
//     if(age>=pensionAge){
//       print("тебе пора на пенсию, $name");
//     } else{
//       print("осталочь до пенсии ${pensionAge-age}");
//     }

//   }
// static void p(int value){
//   print("Вы выиграли $value рублей");
// }
// }


// void main(){
//   Person pers=Person("анатолий", 76);
//   Person pers1=Person("петр", 15);
//   pers1.check();
//   pers.check();
//   pers.info();

//   // Person.pensionAge=14;
//   // pers1.check();
//   // pers.check();
//   Person.p(10000000); 
//   //в дарте существует одиночное, иерархичное, многоуровневое наследования
// } //множественное реализуется сложно


// class A{}
// class B extends A{}

// class C{}
// class D extends C{}
// class E extends C{}

// class F{}
// class R extends F{}
// class G extends F{}



// interface class Worker{
//   String company;
//   Worker(this.company);
//   void info()=> print("Сотрудник работает в $company");
// }

// interface class Student{
//   String vyz;
//   Student(this.vyz);
//   void info()=> print("Студень учится в $vyz");
// }
// //шаблон класса для классов 

// class WorkStud implements Worker, Student{
//   @override
//   String vyz;
//     @override
//   String company; 

//   WorkStud(this.company,this.vyz);

//     @override
//   void info(){
//     print("$company");
//   }

//       @override
//   void info1(){
//     print("$vyz");
//   }

//   void main(){
//     WorkStud st=WorkStud("компания", "институт");
//     st.info();
//     st.info1();
//   }
  
// }
  



// abstract class A{
//   void sum();
//   void div();
// }

// class Sum extends A{
//   int a;
//   int b;
//   Sum(this.a,this.b);
//     @override
//   void div(){print(a-b);}
//   void sum(){print(a+b);}
// }

// void main(){
//   Sum s=Sum(5, 9);
//   s.sum();
//   s.div();
// }




//поздняя инцилизация


// mixin F{}
// mixin C{}
// class FC with F,C{}

// //класс миксин и чистый миксин
// mixin Fly{
//   void fly() => print("я летаю");
// }

// mixin Swim{
//   void swim() => print("я плаваюю");
// }

// class Duck with Fly,Swim{
//   String name;
//   Duck(this.name);
//   @override
//   void swim(){
//     print("$name плавает");
//   }
//   @override
//   void fly(){
//     print("$name летает");
//   }
  
// }

// void main(){
//   Duck duck=Duck("дональд");
//   duck.fly();
//   duck.swim();
// }




// 1. Реализуйте класс «Кружка» и «Человек». Дайте возможность человеку пить из кружки.
// 2. Реализуйте класс «Шкаф», в состав которого входит несколько систем хранения. У пользователя должна быть возможность поместить вещи в шкаф и забрать их оттуда.
// 3. Реализуйте класс «Гриф» и «Блин». На гриф с левой и с правой стороны можно навешивать блины. В конструкторе класса «Гриф» передавайте параметр максимальной загрузки грифа по весу.
// 4. Реализуйте класс для конвертации денег из одной валюты в другую.
// 5. Посредством дженериков реализуйте класс «Гараж», где можно хранить различные объекты.
// 6. Напишите класс, в котором перегружены все базовые арифметические операции и класс. Проверьте его работу.
// 7. Напишите класс «Автомобиль», для таких состояний, как: стоп, ехать, повернуть, используйте перечисления.
// 8. Напишите базовый класс «Геометрическая фигура» и несколько производных классов (прямоугольник, треугольник, окружность и т.д.).
// 9. Напишите класс для перевода значения числа из одной системы счисления (десятичная, шестнадцатеричная и восьмеричная) в другую.
// 10. Напишите класс, который содержит список с геометрическими фигурами и позволяет находить фигуру с максимальной площадью.
// 11. Напишите класс «Стол», на который можно ставить различные столовые приборы (производные классы от базового) и убирать их со стола.





import 'dart:io';

//1 Задание
class Kruzka{
  void drink(){
    print("пить из кружки");
  }
}

class Human extends Kruzka{
  String name;
  Human(this.name);
  @override
  void drink(){
    print("$name пьет");
  }
}


//2 ЗАДАНИЕ
class Skaf{

  List<String> items = [];

  void put(String item) {
    items.add(item);
    print("ты положил $item");
  }

  void take() {
    if (items.isNotEmpty) {
      String taken = items.removeLast();
      print("ты взял $taken");
    } else {
      print("на полке ничего нет");
    }
  }
}

class Polka1 extends Skaf{
  @override
  void put(String item) {
    super.put(item);
    print("ты положил на 1 полку $item");
  }
  @override
  void take() {
    if (items.isNotEmpty) {
      String taken = items.removeLast();
      print("ты взял с первой полки $taken");
    } else {
      print("на первой полке ничего нет");
    }
  }
}

class Polka2 extends Skaf{
  @override
  void put(String item) {
    super.put(item);
    print("ты положил на 2 полку $item");
  }
  @override
  void take() {
    if (items.isNotEmpty) {
      String taken = items.removeLast();
      print("ты взял со второй полки $taken");
    } else {
      print("на второй полке ничего нет");
    }
  }
}



//3 ЗАДАНИЕ
class Gruf {
  int maxdrif = 100; 
  int gruff = 0;     
}

class Blin extends Gruf {
  int blinn = 25;

  void right() {
    if (gruff + blinn <= maxdrif) {
      gruff += blinn;
      print("вы повесили блин справа");
      print("у вас осталось места: ${maxdrif - gruff}");
    } else {
      print("Перегруз! Блин не помещается");
    }
  }

  void left() {
    if (gruff + blinn <= maxdrif) {
      gruff += blinn;
      print("вы повесили блин слева");
      print("у вас осталось места: ${maxdrif - gruff}");
    } else {
      print("Перегруз! Блин не помещается");
    }
  }
}

//4 ЗАДАНИЕ
class Converter {
  void start() {
    print('1: RUB → JPY\n2: JPY → RUB\n3: RUB → USD\n4: USD → RUB');
    int choice = int.parse(stdin.readLineSync()!);
  
    print('Введите сумму:');
    double amount = double.parse(stdin.readLineSync()!);
  
    if (choice == 1) {
      print('${amount * 2.13} JPY');
    } else if (choice == 2) {
      print('${amount / 2.13} RUB');
    } else if (choice == 3) {
      print('${amount * 0.011} USD');
    } else if (choice == 4) {
      print('${amount / 0.011} RUB');
    } else {
      print('Неверный выбор');
    }
  }
}



//5 ЗАДАНИЕ
class Garage<Car, Vodka, Pistolet, German> {
  Car car;
  Vodka vodka;
  Pistolet pistolet;
  German german;
  
  Garage(this.car, this.vodka, this.pistolet, this.german);
  
  void lies() => print("Здесь лежит водка, пистолет, машина и Германия");
}


//6 ЗАДАНИЕ
class Peregruz {
  final num value;
  Peregruz(this.value);
  // Перегрузка оператора +
  Peregruz operator +(Peregruz other) => Peregruz(value + other.value);
  // Перегрузка оператора -
  Peregruz operator -(Peregruz other) => Peregruz(value - other.value);
  // Перегрузка оператора *
  Peregruz operator *(Peregruz other) => Peregruz(value * other.value);
  // Перегрузка оператора / (результат - double)
  Peregruz operator /(Peregruz other) => Peregruz(value / other.value);
  @override
  String toString() => '$value';
}


//7 ЗАДАНИЕ
enum CarState {
  stop,
  drive,
  povorot;
  
  @override
  String toString() {
    switch (this) {
      case CarState.stop:
        return 'стоп';
      case CarState.drive:
        return 'едем';
      case CarState.povorot:
        return 'поворачивает';
    }
  }
}

class Car {
  CarState state = CarState.stop;
  
  void stop() {
    if (state == CarState.stop) {
      print('Машина уже стоит');
    } else {
      state = CarState.stop;
      print('Машина стоит');
    }
  }
  
  void drive() {
    if (state == CarState.drive) {
      print('Машина уже едет');
    } else {
      state = CarState.drive;
      print('Машина поехала');
    }
  }
  
  void povorot() {
    if (state == CarState.stop) {
      print('Машина стоит, сначала нужно поехать');
    } else if (state == CarState.povorot) {
      print('Машина уже поворачивает');
    } else {
      state = CarState.povorot;
      print('Машина поворачивает');
    }
  }
  
  void showStatus() {
    print('Машина: $state');
  }
}




//8 ЗАДАНИЕ
class Figure{
  void perimetrrr(){
    print("ну ...");
  }
  
}

class Kvadrat extends Figure{
  String name="квадрат";
  @override
  void perimetrrr(){
    print("введите величину стороны: ");
    double str = double.parse(stdin.readLineSync()!);
    double p = str * 4;
    print("$name имеет периметр $p");
  }
}

class Treygolnik extends Figure{
  String name="треугольник";
  @override
  void perimetrrr(){
    print("введите величину 1 стороны: ");
    double str1 = double.parse(stdin.readLineSync()!);
    print("введите величину 1 стороны: ");
    double str2 = double.parse(stdin.readLineSync()!);
    print("введите величину 1 стороны: ");
    double str3 = double.parse(stdin.readLineSync()!);
    double p = str1 + str2+ str3;
    print("$name имеет периметр $p");
  }
}



//9 ЗАДАНИЕ
class NumberConverter {
  void start() {
    print("Введите число, которое будет конвертироваться: ");
    int number = int.parse(stdin.readLineSync()!);
    
    print("Выберите систему счисления:");
    print("1 - десятичная (10)");
    print("2 - шестнадцатеричная (16)");
    print("3 - восьмеричная (8)");
    int choice = int.parse(stdin.readLineSync()!);
    
    String result = convert(number, choice);
    print(result);
  }

  String convert(int number, int choice) {
    switch (choice) {
      case 1: return number.toRadixString(10); //преобразует целое число в строковое представление в системе счисления с основанием radix (от 2 до 36).
      case 2: return number.toRadixString(16);
      case 3: return number.toRadixString(8);
      default: return "Некорректный выбор (1, 2 или 3)";
    }
  }
}



//10 ЗАДАНИЕ
abstract class Shape {
  double get area;
  String get russianName; // русское название фигуры
}

// Круг
class Circle extends Shape {
  double radius;
  Circle(this.radius);
  @override
  double get area => pi * radius * radius;
  @override
  String get russianName => "Круг";
}

// Прямоугольник
class Rectangle extends Shape {
  double width, height;
  Rectangle(this.width, this.height);
  @override
  double get area => width * height;
  @override
  String get russianName => "Прямоугольник";
}

// Квадрат
class Square extends Rectangle {
  Square(double side) : super(side, side);
  @override
  String get russianName => "Квадрат";
}

//класс, содержащий список фигур
class FigureCollection {
  List<Shape> figures;
  FigureCollection(this.figures);
  
  Shape? getMaxAreaFigure() {
    if (figures.isEmpty) return null;
    return figures.reduce((a, b) => a.area > b.area ? a : b);
  }
}



//11 ЗАДАНИЕ
// Абстрактный класс для столовых приборов
abstract class StolovyPribor {
  void polozhitNaStol(Stol stol, int kolvo);
  void vziatSoStola(Stol stol, int kolvo);
}

class Stol {
  int lozhki = 0;
  int vilki = 0;
  int nozhi = 0;

  void pokazatSchetchiki() {
    print('Ложек на столе: $lozhki');
    print('Вилок на столе: $vilki');
    print('Ножей на столе: $nozhi');
  }

  void dobavitLozhki(int kolvo) => lozhki += kolvo;
  void dobavitVilki(int kolvo) => vilki += kolvo;
  void dobavitNozhi(int kolvo) => nozhi += kolvo;

  void ubratLozhki(int kolvo) {
    if (kolvo > lozhki) {
      print('Недостаточно ложек на столе!');
    } else {
      lozhki -= kolvo;
      print('Со стола взяли $kolvo ложек.');
    }
  }

  void ubratVilki(int kolvo) {
    if (kolvo > vilki) {
      print('Недостаточно вилок на столе!');
    } else {
      vilki -= kolvo;
      print('Со стола взяли $kolvo вилок.');
    }
  }

  void ubratNozhi(int kolvo) {
    if (kolvo > nozhi) {
      print('Недостаточно ножей на столе!');
    } else {
      nozhi -= kolvo;
      print('Со стола взяли $kolvo ножей.');
    }
  }

  void polozhitLozhki(int kolvo) => dobavitLozhki(kolvo);
  void polozhitVilki(int kolvo) => dobavitVilki(kolvo);
  void polozhitNozhi(int kolvo) => dobavitNozhi(kolvo);

  void vziatLozhki(int kolvo) => ubratLozhki(kolvo);
  void vziatVilki(int kolvo) => ubratVilki(kolvo);
  void vziatNozhi(int kolvo) => ubratNozhi(kolvo);

  void zapusk() {
    while (true) {
      print('\nЧто вы хотите сделать?');
      print('1 — Положить прибор на стол');
      print('2 — Взять прибор со стола');
      print('3 — Показать количество приборов на столе');
      print('0 — Выйти');
      stdout.write('Ваш выбор: ');
      String? input = stdin.readLineSync();
      if (input == null) continue;
      int? vibor = int.tryParse(input);
      if (vibor == null) {
        print('Ошибка: введите число!');
        continue;
      }

      if (vibor == 0) {
        print('До свидания!');
        break;
      }

      switch (vibor) {
        case 1:
          obrabotatPolozhit();
          break;
        case 2:
          obrabotatVziat();
          break;
        case 3:
          pokazatSchetchiki();
          break;
        default:
          print('Неверный выбор. Попробуйте снова.');
      }
    }
  }

  void obrabotatPolozhit() {
    print('Выберите прибор: 1 — Ложка, 2 — Вилка, 3 — Нож');
    stdout.write('Ваш выбор: ');
    String? viborPrib = stdin.readLineSync();
    int? tip = int.tryParse(viborPrib ?? '');
    if (tip == null || tip < 1 || tip > 3) {
      print('Неверный тип прибора.');
      return;
    }

    stdout.write('Сколько приборов положить? ');
    String? kolStr = stdin.readLineSync();
    int? kolvo = int.tryParse(kolStr ?? '');
    if (kolvo == null || kolvo <= 0) {
      print('Некорректное количество.');
      return;
    }

    switch (tip) {
      case 1:
        polozhitLozhki(kolvo);
        print('На стол положили $kolvo ложек.');
        break;
      case 2:
        polozhitVilki(kolvo);
        print('На стол положили $kolvo вилок.');
        break;
      case 3:
        polozhitNozhi(kolvo);
        print('На стол положили $kolvo ножей.');
        break;
    }
  }

  void obrabotatVziat() {
    print('Выберите прибор: 1 — Ложка, 2 — Вилка, 3 — Нож');
    stdout.write('Ваш выбор: ');
    String? viborPrib = stdin.readLineSync();
    int? tip = int.tryParse(viborPrib ?? '');
    if (tip == null || tip < 1 || tip > 3) {
      print('Неверный тип прибора.');
      return;
    }

    stdout.write('Сколько приборов взять? ');
    String? kolStr = stdin.readLineSync();
    int? kolvo = int.tryParse(kolStr ?? '');
    if (kolvo == null || kolvo <= 0) {
      print('Некорректное количество.');
      return;
    }

    switch (tip) {
      case 1:
        vziatLozhki(kolvo);
        break;
      case 2:
        vziatVilki(kolvo);
        break;
      case 3:
        vziatNozhi(kolvo);
        break;
    }
  }
}

class Lozhka implements StolovyPribor {
  @override
  void polozhitNaStol(Stol stol, int kolvo) {
    stol.polozhitLozhki(kolvo);
  }

  @override
  void vziatSoStola(Stol stol, int kolvo) {
    stol.vziatLozhki(kolvo);
  }
}

class Vilka implements StolovyPribor {
  @override
  void polozhitNaStol(Stol stol, int kolvo) {
    stol.polozhitVilki(kolvo);
  }

  @override
  void vziatSoStola(Stol stol, int kolvo) {
    stol.vziatVilki(kolvo);
  }
}

class Nozh implements StolovyPribor {
  @override
  void polozhitNaStol(Stol stol, int kolvo) {
    stol.polozhitNozhi(kolvo);
  }

  @override
  void vziatSoStola(Stol stol, int kolvo) {
    stol.vziatNozhi(kolvo);
  }
}


void main(){

  print("1 ЗАДАНИЕ");
  Human humanl = Human ("Мишель");
  humanl.drink();


  print("2 ЗАДАНИЕ");
  Polka1 polka1 = Polka1();
  Polka2 polka2 = Polka2();

  while (true) {
    print("Шкаф");
    print("1 - положить вещь");
    print("2 - взять вещь");
    print("0 - закрыть шкаф");
    String? choice = stdin.readLineSync();
    //выйти
    if (choice == '0') break;
    //положить
    if (choice == '1') {
      print("На какую полку (1,2)?");
      String? shelf = stdin.readLineSync();
      print("Что положить?");
      String? item = stdin.readLineSync();
      if (item != null && item.isNotEmpty) {
        if (shelf == '1') polka1.put(item);
        else if (shelf == '2') polka2.put(item);
        else print("Неверная полка");
      }
    //взять
    } else if (choice == '2') {
      print("С какой полки взять (1,2)?");
      String? shelf = stdin.readLineSync();
      if (shelf == '1') polka1.take();
      else if (shelf == '2') polka2.take();
      else print("Неверная полка");
    }
  }


  print("3 ЗАДАНИЕ");
  Blin barbell = Blin(); 
  while (true) {
    print("1 - повесить блин слева");
    print("2 - повесить блин справа");
    print("0 - выйти");
    String? choice = stdin.readLineSync();
    if (choice == '0') break;
    if (choice == '1') barbell.left();
    else if (choice == '2') barbell.right();
  }



  print("4 ЗАДАНИЕ");
  Converter().start();



  print("5 ЗАДАНИЕ");
  var gargar = Garage("БМВ", 0.7, 25, "германия");
  print(gargar.car.runtimeType);      // String
  print(gargar.vodka.runtimeType);    // double
  print(gargar.german.runtimeType);   // String
  print(gargar.pistolet.runtimeType); // String
  gargar.lies(); // Здесь лежит водка, пистолет, машина и Германия



  print("6 ЗАДАНИЕ");
  Peregruz a = Peregruz(10);
  Peregruz b = Peregruz(3);
  print('$a + $b = ${a + b}');
  print('$a - $b = ${a - b}');
  print('$a * $b = ${a * b}');
  print('$a / $b = ${a / b}');



  print("7 ЗАДАНИЕ");
  Car e = Car();
  while (true) {
    e.showStatus();
    print('Выберите действие:');
    print('1. Стоп (остановить)');
    print('2. Ехать (начать движение)');
    print('3. Повернуть');
    print('0. Выход');
    String input = stdin.readLineSync()!;
    int choice = int.parse(input); 
    if (choice == 0) {
      print('Программа завершена.');
      break;
    }
    switch (choice) {
      case 1:
        e.stop();
        break;
      case 2:
        e.drive();
        break;
      case 3:
        e.povorot();
        break;
    }
  }




  print("8 ЗАДАНИЕ");
  print('Квадрат');
  Kvadrat kvadrat = Kvadrat();
  kvadrat.perimetrrr();

  print('\nТреугольник');
  Treygolnik treygolnik = Treygolnik();
  treygolnik.perimetrrr();




  print("9 ЗАДАНИЕ");
  NumberConverter conv = NumberConverter();
  conv.start();



  print("10 ЗАДАНИЕ");
  var figures = [
    Circle(5),
    Rectangle(3, 4),
    Square(6),
  ];

  var collection = FigureCollection(figures);
  Shape? maxFigure = collection.getMaxAreaFigure();

  print('Фигура с максимальной площадью: ${maxFigure?.russianName}');
  print('Площадь: ${maxFigure?.area}');




  print("11 ЗАДАНИЕ");
  Stol stol = Stol();
  stol.zapusk();

}
