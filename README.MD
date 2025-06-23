# Inception Project

This project, part of the 42 curriculum, involves setting up a comprehensive infrastructure using Docker. The goal is to containerize several services (NGINX, WordPress, MariaDB) and orchestrate them using Docker Compose, all while adhering to strict security and system administration best practices.

## 🚀 Table of Contents

- [About The Project](#-about-the-project)
- [Architecture Diagram](#-architecture-diagram)
- [Technologies Used](#-technologies-used)
- [Project Structure](#-project-structure)
- [Configuration Deep Dive](#-configuration-deep-dive)
  - [Docker Compose](#docker-compose)
  - [NGINX](#nginx)
  - [WordPress](#wordpress)
  - [MariaDB](#mariadb)
  - [Adminer (Bonus)](#adminer-bonus)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
- [Makefile Commands](#-makefile-commands)

## 📖 About The Project

The "Inception" project challenges us to go beyond a single container and build a multi-service application. It demonstrates a practical understanding of containerization, networking, and system administration in a sandboxed virtual machine environment.

Key requirements included:
* **Custom Docker Images:** Building NGINX, WordPress, and MariaDB images from scratch using `Debian:Bullseye` as a base.
* **Persistent Data:** Using Docker volumes to ensure that website files and database data persist even when containers are removed.
* **Secure Networking:** Creating a dedicated bridge network for inter-container communication, with NGINX as the sole entry point to the outside world via port 443.
* **Security:** Implementing TLSv1.3 encryption, using environment variables for credentials (no hardcoded passwords), and setting up a secure database.

## 🏗️ Architecture Diagram

The infrastructure consists of three core services and one bonus service, all communicating over a private Docker network. NGINX acts as a reverse proxy, directing traffic to the appropriate service.

```
+-----------------------------------------------------------------+
|                        Host Virtual Machine                     |
|                                                                 |
|  +---------------------------+      +-------------------------+ |
|  | /home/rmoutaou/data/      |      | /etc/hosts              | |
|  | +-----------------------+ |      | 127.0.0.1 rmoutaou.42.fr| |
|  | |      website/         |&lt;----->|                         | |
|  | +-----------------------+ |      +-------------------------+ |
|  | +-----------------------+ |                                  |
|  | |     database/         |&lt;----->|                            |
|  | +-----------------------+ |                                  |
|  +---------------------------+                                  |
|                                                                 |
|       |                                                         |
| (Port 443)                                                      |
|       |                                                         |
|  +----v-------------------------------------------------------+ |
|  |                      Docker Network                         | |
|  |                                                             | |
|  |  +-----------+   +-------------+   +-----------+  +---------+ |
|  |  |   NGINX   |-->|  WordPress  |-->|  MariaDB  |  | Adminer | |
|  |  | (port 443)|   |  (port 9000)|   | (port 3306)|  | (port 8080)|
|  |  +-----------+   +-------------+   +-----------+  +---------+ |
|  |       ^                                 ^             |       |
|  |       |                                 |             |       |
|  |       +---------------------------------+-------------+       |
|  |                                                             | |
|  +-----------------------------------------------------------+ |
+-----------------------------------------------------------------+
```

