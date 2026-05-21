# x86 HTTP Server

A minimal concurrent HTTP server written entirely in x86-64 Linux assembly using direct Linux syscalls.

The server supports both **HTTP GET** and **HTTP POST** requests and handles multiple clients simultaneously using `fork()`.

---

## Features

- TCP socket creation using `socket()`
- Binds to `0.0.0.0:80`
- Waits for incoming connections using `listen()` and `accept()`
- Handles multiple clients concurrently with `fork()`
- Supports:

### GET Requests
The server:

1. Reads incoming request
2. Extracts requested file path
3. Opens target file
4. Reads contents
5. Sends:

```http
HTTP/1.0 200 OK

<file contents>
```

Example:

```http
GET /file.txt HTTP/1.1
```

---

### POST Requests

The server:

1. Reads full HTTP request
2. Extracts file path
3. Finds request body after:

```text
\r\n\r\n
```

4. Creates/opens file
5. Writes body contents into file
6. Sends:

```http
HTTP/1.0 200 OK
```

Example:

```http
POST /data.txt HTTP/1.1
Content-Length: ...

hello world
```

---

## Concurrency

Every incoming connection creates a child process using:

```text
fork()
```

Parent process:

- closes connected socket
- continues accepting new clients

Child process:

- handles GET/POST request
- sends response
- exits

This allows multiple requests to be processed simultaneously.

---

## Linux Syscalls Used

| Syscall | Purpose |
|----------|----------|
| socket | Create TCP socket |
| bind | Bind socket to port |
| listen | Listen for clients |
| accept | Accept connection |
| fork | Handle concurrent clients |
| read | Read requests/files |
| write | Send responses |
| open | Open/create files |
| close | Close file descriptors |
| exit | Terminate process |

---

## Build

Assemble:

```bash
as -o server.o file.s
```

Link:

```bash
ld -o server server.o
```

Run:

```bash
sudo ./server
```

Root privileges are required because the server binds to port `80`.

---

## Workflow

Server startup:

```text
socket()
bind()
listen()
```

Main loop:

```text
accept()
fork()
```

Request handling:

```text
GET  -> open file -> read -> write response
POST -> open/create file -> write body -> send response
```

---

## Learning Goals

This project was built to understand:

- x86-64 Assembly
- Linux syscalls
- Socket programming
- Process creation with `fork()`
- HTTP protocol basics
- Concurrent servers
- Low-level systems programming

---

## Result

The final program behaves as a small web server capable of:

- serving files through GET requests
- storing uploaded data through POST requests
- handling multiple clients at the same time

All implemented directly in assembly without using libc or external libraries.
