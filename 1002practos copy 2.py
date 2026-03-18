import os
import pickle
from abc import ABC, abstractmethod
from datetime import datetime
from pathlib import Path

# пользователи 
# абстрактный класс - 
class Person(ABC):
    def __init__(self, name):
        self._name = name  # инкапсуляция 
        # protected - доступно внутри класса и его наследников
    
    @property # получение защ.пременной
    def name(self):
        return self._name  
    
    @abstractmethod # абстракный метод да
    def display_role(self): # объявлен, релизован в user и librarion, возвращает роль
        pass
    
    def to_dict(self):
        return {"name": self._name}
    
    @classmethod
    def from_dict(cls, data):
        return cls(data["name"])

# книги
class Book:
    def __init__(self, title, author, status="в библиотеке"):
        self._title = title  
        self._author = author
        self._status = status
    
    @property
    def title(self):
        return self._title
    
    @property
    def author(self):
        return self._author
    
    @property
    def status(self):
        return self._status
    
    @status.setter
    def status(self, new_status):
        if new_status in ["в библиотеке", "выдана"]:
            self._status = new_status
    
    def __str__(self):
        return f"'{self._title}' - {self._author} ({self._status})"
    
    def to_dict(self):
        return {
            "title": self._title,
            "author": self._author,
            "status": self._status
        }
    
    @classmethod
    def from_dict(cls, data):
        """Создает объект из словаря"""
        return cls(data["title"], data["author"], data["status"])

# пользователи
class User(Person):
    def __init__(self, name, borrowed_books=None):
        super().__init__(name)
        self._borrowed_books = borrowed_books if borrowed_books else []
    
    @property
    def borrowed_books(self):
        return self._borrowed_books
    
    def display_role(self):
        return "Читатель"
    
    def add_borrowed_book(self, book_title):
        self._borrowed_books.append(book_title)
    
    def remove_borrowed_book(self, book_title):
        if book_title in self._borrowed_books:
            self._borrowed_books.remove(book_title)
    
    def get_borrowed_books(self):
        return self._borrowed_books
    
    def to_dict(self):
        data = super().to_dict()
        data["borrowed_books"] = self._borrowed_books
        return data
    
    @classmethod
    def from_dict(cls, data):
        """Создает объект из словаря"""
        return cls(data["name"], data["borrowed_books"])

# библиотекарь
class Librarian(Person):
    def __init__(self, name):
        super().__init__(name)  
    
    def display_role(self):
        return "Библиотекарь"
    
    # to_dict и from_dict наследуются от Person

# упралвение библиотекрй
class LibraryManager:
    def __init__(self):
        self.books = []
        self.users = []
        self.librarians = []
        self.current_user = None
        self.__data_dir = None
        self.reports_dir = "reports"
        
        # дирректории
        if not os.path.exists(self.reports_dir):
            os.makedirs(self.reports_dir)
        
        self.load_data()
    
    def save_data(self):  # сохраняет данные в pickle-файлы в папке library_data
        home_dir = Path.home()  # возвращает путь к домашней директории пользователя
        self.__data_dir = home_dir / "library_data"  # создает путь к папке library_data внутри домашней директории
        
        if not os.path.exists(self.__data_dir):  # проверка существования папки
            os.makedirs(self.__data_dir)
        
        # сохраняем книги
        books_data = [book.to_dict() for book in self.books]
        with open(f"{self.__data_dir}/books.pkl", 'wb') as f:
            pickle.dump(books_data, f)
        
        # сохраняем пользователей
        users_data = [user.to_dict() for user in self.users]
        with open(f"{self.__data_dir}/users.pkl", 'wb') as f:
            pickle.dump(users_data, f)
        
        # сохраняем библиотекарей
        librarians_data = [librarian.to_dict() for librarian in self.librarians]
        with open(f"{self.__data_dir}/librarians.pkl", 'wb') as f:
            pickle.dump(librarians_data, f)
        
        print("Данные сохранены в домашней директории")
    
    def load_data(self):  # загружает данные из pickle-файлов
        home_dir = Path.home()
        self.__data_dir = home_dir / "library_data"
        
        if not os.path.exists(self.__data_dir):
            os.makedirs(self.__data_dir)  # создает директорию для файлов (если не сущ-ет)
            print("Создана новая директория для данных")
            self.create_initial_data()
            return
        
        try:
            # загружаем книги
            books_file = f"{self.__data_dir}/books.pkl"
            if os.path.exists(books_file):
                with open(books_file, 'rb') as f:
                    books_data = pickle.load(f)
                self.books = [Book.from_dict(data) for data in books_data]
            
            # загружаем пользователей
            users_file = f"{self.__data_dir}/users.pkl"
            if os.path.exists(users_file):
                with open(users_file, 'rb') as f:
                    users_data = pickle.load(f)
                self.users = [User.from_dict(data) for data in users_data]
            
            # загружаем библиотекарей
            librarians_file = f"{self.__data_dir}/librarians.pkl"
            if os.path.exists(librarians_file):
                with open(librarians_file, 'rb') as f:
                    librarians_data = pickle.load(f)
                self.librarians = [Librarian.from_dict(data) for data in librarians_data]
            
            # если файлы есть, но данные пустые - создаем начальные данные
            if not self.books and not self.users and not self.librarians:
                self.create_initial_data()
            else:
                print("Данные загружены из домашней директории")
                
        except (FileNotFoundError, EOFError, pickle.PickleError):
            print("Созданы новые файлы данных")
            self.create_initial_data()
    
    def create_initial_data(self):
        # начальные книги
        initial_books = [
            ("Война и мир", "Лев Толстой"),
            ("Преступление и наказание", "Фёдор Достоевский"),
            ("Мастер и Маргарита", "Михаил Булгаков"),
            ("1984", "Джордж Оруэлл"),
            ("Гарри Поттер и философский камень", "Джоан Роулинг")
        ]
        
        for title, author in initial_books:
            self.books.append(Book(title, author))
        
        # отмечаем одну книгу как выданную
        for book in self.books:
            if book.title == "Мастер и Маргарита":
                book.status = "выдана"
                break
        
        # начальные пользователи
        self.users.append(User("Иван Иванов", ["Мастер и Маргарита"]))
        self.users.append(User("Анна Петрова"))
        self.users.append(User("Сергей Сидоров", ["1984"]))
        
        # начальные библиотекари
        self.librarians.append(Librarian("Мария Сергеевна"))
        self.librarians.append(Librarian("Алексей Владимирович"))
        
        print("Созданы начальные данные")
        self.save_data()  # сразу сохраняем созданные данные
    
    # аутентификация
    def authenticate(self, role, name):
        if role == "librarian":
            for librarian in self.librarians:
                if librarian.name == name:
                    self.current_user = librarian
                    return True
            # новый библиотекарь если нет
            new_librarian = Librarian(name)
            self.librarians.append(new_librarian)
            self.current_user = new_librarian
            return True
        elif role == "user":
            for user in self.users:
                if user.name == name:
                    self.current_user = user
                    return True
            # новый польз если нет
            new_user = User(name)
            self.users.append(new_user)
            self.current_user = new_user
            return True
        return False
    
    # функции билиотекаря
    def add_book(self, title, author):
        for book in self.books:
            if book.title == title and book.author == author:
                print("Книга уже существует в системе!")
                return
        
        new_book = Book(title, author)
        self.books.append(new_book)
        print(f"Книга '{title}' успешно добавлена!")
    
    def remove_book(self, title):
        for i, book in enumerate(self.books):
            if book.title == title:
                # проверка выдачи книги
                if book.status == "выдана":
                    print("Нельзя удалить книгу, так как она выдана читателю!")
                    return
                
                # уделиние книги из списка польз
                for user in self.users:
                    if title in user.borrowed_books:
                        user.remove_borrowed_book(title)
                
                del self.books[i]
                print(f"Книга '{title}' успешно удалена!")
                return
        print("Книга не найдена!")
    
    def register_user(self, name):
        # проверка не зареган ли польз
        for user in self.users:
            if user.name == name:
                print("Пользователь уже зарегистрирован!")
                return
        
        new_user = User(name)
        self.users.append(new_user)
        print(f"Пользователь '{name}' успешно зарегистрирован!")
    
    def create_users_report(self):
        if not self.users:
            print("В системе нет зарегистрированных пользователей.")
            return
        
        # файл с польз
        report_file = os.path.join(self.reports_dir, "все_пользователи.txt")
        with open(report_file, 'w', encoding='utf-8') as f:
            f.write("ОТЧЕТ: СПИСОК ВСЕХ ПОЛЬЗОВАТЕЛЕЙ\n")
            f.write(f"Дата создания: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"Всего пользователей: {len(self.users)}\n")
            f.write("\n")
            
            for user in self.users:
                borrowed_count = len(user.borrowed_books)
                user_info = f"Имя: {user.name}\nКоличество взятых книг: {borrowed_count}"
                
                if borrowed_count > 0:
                    user_info += f"\nВзятые книги: {', '.join(user.borrowed_books)}"
                
                # запись в файлик 
                f.write(user_info + "\n\n")
        
        print(f"Отчет сохранен в файл: {report_file}")
        print(f"Всего пользователей в системе: {len(self.users)}")
    
    def create_books_report(self):
        if not self.books:
            print("В библиотеке нет книг.")
            return
        
        # файл с книгами
        report_file = os.path.join(self.reports_dir, "все_книги.txt")
        with open(report_file, 'w', encoding='utf-8') as f:
            f.write("ОТЧЕТ: СПИСОК ВСЕХ КНИГ\n")
            f.write(f"Дата создания: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
            f.write(f"Всего книг: {len(self.books)}\n")
            books_in_library = sum(1 for book in self.books if book.status == 'в библиотеке')
            books_issued = sum(1 for book in self.books if book.status == 'выдана')
            f.write(f"Книг в библиотеке: {books_in_library}\n")
            f.write(f"Книг выдано: {books_issued}\n")
            f.write(f"{'№':<3} {'Название':<30} {'Автор':<20} {'Статус':<15}\n")
            f.write("-" * 70 + "\n")
            
            for i, book in enumerate(self.books, 1):
                f.write(f"{i:<3} '{book.title:<28}' {book.author:<20} {book.status:<15}\n")
        
        print(f"Отчет сохранен в файл: {report_file}")
        print(f"Всего книг в системе: {len(self.books)}")
        print(f"Книг доступно для выдачи: {books_in_library}")
    
    # функции пользователя
    def view_available_books(self):
        available_books = [book for book in self.books if book.status == "в библиотеке"]
        
        if not available_books:
            print("Нет доступных книг в данный момент.")
            return
        
        print(f"\nДоступно книг: {len(available_books)}")
        for i, book in enumerate(available_books, 1):
            print(f"{i}. '{book.title}' - {book.author}")
    
    def view_my_books(self):
        if not isinstance(self.current_user, User):
            print("Ошибка: текущий пользователь не является читателем!")
            return
        
        borrowed_books = self.current_user.get_borrowed_books()
        
        if not borrowed_books:
            print("У вас нет взятых книг.")
            return
        
        print(f"\nУ вас взято книг: {len(borrowed_books)}")
        for book_title in borrowed_books:
            # инфа о книгах
            for book in self.books:
                if book.title == book_title:
                    print(f"'{book.title}' - {book.author}")
                    break

# ОСНОВНОЙ КЛАСС
class LibraryApp:
    def __init__(self):
        self.manager = LibraryManager()
        self.running = True
    
    def run(self):
        print("Привет это кстати библиотека")
        
        while self.running:
            self.show_main_menu()
    
    def show_main_menu(self):
        print("\nВы кто?")
        print("1. библиотекарь")
        print("2. пользователь")
        print("3. пока я пошел")
        
        choice = input("Выберите действие (1-3): ")
        
        if choice == "1":
            self.librarian_login()
        elif choice == "2":
            self.user_login()
        elif choice == "3":
            self.exit_system()
        else:
            print("Неверный выбор. Попробуйте снова.")
    
    def librarian_login(self):
        print("\nвход библиотекаря")
        name = input("Введите ваше имя: ")
        
        if self.manager.authenticate("librarian", name):
            print(f"Добро пожаловать, библиотекарь {name}!")
            self.librarian_menu()
        else:
            print("Ошибка аутентификации.")
    
    def user_login(self):
        print("\nвход пользователя")
        name = input("Введите ваше имя: ")
        
        if self.manager.authenticate("user", name):
            print(f"Добро пожаловать, {name}!")
            self.user_menu()
        else:
            print("Ошибка аутентификации.")
    
    def librarian_menu(self):
        while True:
            print("\nДействия библиотекаря")
            print("1. Добавить новую книгу")
            print("2. Удалить книгу из системы")
            print("3. Зарегистрировать нового пользователя")
            print("4. Создать отчет по всем пользователям")
            print("5. Создать отчет по всем книгам")
            print("0. Выйти в главное меню")
            
            choice = input("Выберите действие (0-5): ")
            
            if choice == "1":
                self.add_book()
            elif choice == "2":
                self.remove_book()
            elif choice == "3":
                self.register_user()
            elif choice == "4":
                self.manager.create_users_report()
            elif choice == "5":
                self.manager.create_books_report()
            elif choice == "0":
                self.manager.current_user = None
                return
            else:
                print("Неверный выбор. Попробуйте снова.")
    
    def user_menu(self):
        while True:
            print("\nДействия польз")
            print("1. Просмотреть доступные книги")
            print("2. Просмотреть список взятых мной книг")
            print("0. Выйти в главное меню")
            
            choice = input("Выберите действие (0-2): ")
            
            if choice == "1":
                self.manager.view_available_books()
            elif choice == "2":
                self.manager.view_my_books()
            elif choice == "0":
                self.manager.current_user = None
                return
            else:
                print("Неверный выбор. Попробуйте снова.")
    
    def add_book(self):
        print("\nДобавление книги")
        title = input("Введите название книги: ")
        author = input("Введите автора книги: ")
        
        if title and author:
            self.manager.add_book(title, author)
        else:
            print("Название и автор не могут быть пустыми!")
    
    def remove_book(self):
        print("\nУдаление книги")
        if self.manager.books:
            title = input("Введите название книги для удаления: ")
            self.manager.remove_book(title)
        else:
            print("В библиотеке нет книг.")
    
    def register_user(self):
        print("\nРегист пользователя")
        name = input("Введите имя нового пользователя: ")
        
        if name:
            self.manager.register_user(name)
        else:
            print("Имя не может быть пустым!")
    
    def exit_system(self):
        print("\nСохранение данных...")
        self.manager.save_data()
        print("Данные успешно сохранены!")
        print("До свидания!")
        self.running = False

# запуск приложения
if __name__ == "__main__":
    app = LibraryApp()
    app.run()