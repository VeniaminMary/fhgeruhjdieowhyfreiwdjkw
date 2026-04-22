import socket
import threading

clients = []
clients_lock = threading.Lock()

def broadcast(message, sender_socket=None):
    """Отправить сообщение всем клиентам, кроме отправителя (если указан)"""
    with clients_lock:
        for client in clients[:]:
            if client != sender_socket:
                try:
                    client.send(message.encode('utf-8'))
                except:
                    if client in clients:
                        clients.remove(client)

def handle_client(client_socket, client_address):
    print(f'Клиент {client_address} подключён')
    # Отправляем приветствие с адресом и портом клиента
    try:
        client_socket.send(f"Вы зашли как {client_address[0]}, {client_address[1]}".encode('utf-8'))
    except:
        pass

    # Оповещаем остальных о новом участнике
    broadcast(f"Пользователь {client_address} присоединился к чату", sender_socket=client_socket)

    while True:
        try:
            data = client_socket.recv(1024)
            if not data:
                break
            message = data.decode('utf-8')
            print(f'От {client_address} пришло: {message}')
            broadcast(f"{client_address}: {message}", sender_socket=client_socket)
        except:
            break

    # Клиент отключился
    with clients_lock:
        if client_socket in clients:
            clients.remove(client_socket)
    client_socket.close()
    broadcast(f"Пользователь {client_address} покинул чат")
    print(f'Клиент {client_address} отключился')

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
server_socket.bind(("127.0.0.1", 5000))
server_socket.listen()

print('Сервер ждёт подключения клиентов')

while True:
    client_socket, client_address = server_socket.accept()
    with clients_lock:
        clients.append(client_socket)
    thread = threading.Thread(target=handle_client, args=(client_socket, client_address), daemon=True)
    thread.start()