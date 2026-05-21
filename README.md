Simple Concurrent HTTP Server in x86-64 Assembly

This project implements a minimal web server entirely in Linux x86-64 assembly using direct system calls (without libc). The server supports handling multiple clients concurrently by creating a new process for each incoming connection using fork().

Features
Creates a TCP socket using socket()
Binds to 0.0.0.0:80 using bind()
Waits for connections using listen() and accept()
Handles multiple clients concurrently with fork()
Supports HTTP GET requests
Extracts requested file path
Opens the file
Reads its contents
Sends contents back to client
Supports HTTP POST requests
Extracts target file path
Finds request body after HTTP headers
Creates/writes data into file
Sends HTTP response:
HTTP/1.0 200 OK
Properly closes sockets and exits child processes
Workflow
Server startup
Create socket
socket()
Bind socket to:
0.0.0.0 : 80
Start listening:
listen()
Main loop

Server continuously:

accept()
fork()

Parent process:

closes client socket
continues waiting for new clients

Child process:

handles request
exits after responding

This allows concurrent requests.

Handling GET requests

Example request:

GET /file.txt HTTP/1.1

Steps:

Read incoming request
Extract path:
/file.txt
Open file
open()
Read file contents
read()
Send:
HTTP/1.0 200 OK
<file contents>
Handling POST requests

Example request:

POST /data.txt HTTP/1.1
Content-Length: ...

hello

Steps:

Read full request
Extract target path
/data.txt
Find body after:
\r\n\r\n
Create/open file
open(O_CREAT | O_WRONLY)
Write body to file
write()
Return:
HTTP/1.0 200 OK
Linux syscalls used
Syscall	Purpose
socket	Create TCP socket
bind	Attach socket to port
listen	Wait for connections
accept	Accept client
fork	Handle clients concurrently
read	Read requests/files
write	Send responses
open	Open/create files
close	Close descriptors
exit	Terminate process
Result

The final server behaves like a very small web server capable of:

serving files (GET)
storing uploaded data (POST)
handling multiple clients simultaneously

All implemented directly in assembly using Linux syscalls.
