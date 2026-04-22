import socket
import threading
import sys

def receive_messages(client_socket):
    while True:
        try:
            data = client_socket.recv(1024)
            if not data:
                print("Сервер разорвал соединение.")
                break
            # Выводим полученное сообщение (без лишнего приглашения)
            print(f'\n{data.decode("utf-8")}')
        except:
            print("Ошибка приёма данных. Соединение потеряно.")
            break

def send_messages(client_socket):
    while True:
        try:
            message = input("Введите сообщение: ")
            if message.lower() == '/quit':
                print("Завершение чата...")
                client_socket.close()
                break
            if message.strip():
                client_socket.send(message.encode('utf-8'))
        except (ConnectionResetError, BrokenPipeError, OSError):
            print("Соединение с сервером потеряно.")
            break
        except Exception as e:
            print(f"Ошибка: {e}")
            break

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
    client_socket.connect(('127.0.0.1', 5000))
except ConnectionRefusedError:
    print("Не удалось подключиться к серверу. Убедитесь, что сервер запущен.")
    sys.exit(1)

receive_thread = threading.Thread(target=receive_messages, args=(client_socket,), daemon=True)
receive_thread.start()

send_messages(client_socket)