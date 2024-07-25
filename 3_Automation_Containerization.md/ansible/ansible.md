# Ansible

## Overview

Ansible is an open-source automation tool for IT tasks such as configuration management, application deployment, and orchestration. It uses YAML for defining automation jobs, making it easy to read and write.

## Key Concepts

- **Playbooks**: Ansible configuration files written in YAML, defining tasks to be executed on managed hosts.
- **Inventory**: A list of hosts to be managed, defined in an inventory file.
- **Modules**: Pre-built units of work that can be executed on remote hosts.
- **Roles**: Collections of Ansible tasks, variables, and handlers, organized for reusability and maintainability.

## Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Getting Started with Ansible](https://www.ansible.com/resources/get-started)

## Practice Problems

### Easy Problem

**Task**: Write an Ansible playbook to install Nginx on a remote server.

1. Define an inventory file with the target server.
2. Create a playbook to install Nginx.

### Medium Problem

**Task**: Write an Ansible playbook to deploy a Node.js application.

1. Define tasks to install Node.js, clone the application repository, install dependencies, and start the application.

### Hard Problem

**Task**: Write an Ansible playbook to configure a LAMP stack (Linux, Apache, MySQL, PHP).

1. Define tasks to install and configure Apache, MySQL, and PHP.
2. Include steps to secure MySQL and deploy a sample PHP application.

## Solutions

### Easy Problem Solution

**Inventory File (`hosts`)**:
```ini
[web]
server.example.com
```

**Playbook (`install_nginx.yml`)**:
```yaml
- hosts: web
  become: yes
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
```

### Medium Problem Solution

**Playbook (`deploy_node_app.yml`)**:
```yaml
- hosts: web
  become: yes
  tasks:
    - name: Install Node.js
      apt:
        name: nodejs
        state: present

    - name: Install npm
      apt:
        name: npm
        state: present

    - name: Clone the application repository
      git:
        repo: 'https://github.com/user/repo.git'
        dest: /var/www/myapp

    - name: Install dependencies
      command: npm install
      args:
        chdir: /var/www/myapp

    - name: Start the application
      command: npm start
      args:
        chdir: /var/www/myapp
```

### Hard Problem Solution

**Playbook (`configure_lamp.yml`)**:
```yaml
- hosts: web
  become: yes
  tasks:
    - name: Install Apache
      apt:
        name: apache2
        state: present

    - name: Install MySQL
      apt:
        name: mysql-server
        state: present

    - name: Secure MySQL Installation
      mysql_secure_installation:
        login_user: root
        login_password: 'rootpassword'
        new_password: 'newpassword'
        change_root_password: yes
        remove_anonymous_users: yes
        disallow_root_login_remotely: yes
        remove_test_db: yes
        state: present

    - name: Install PHP
      apt:
        name: php
        state: present

    - name: Deploy sample PHP application
      copy:
        src: /path/to/sample_app
        dest: /var/www/html/
        owner: www-data
        group: www-data
        mode: '0755'