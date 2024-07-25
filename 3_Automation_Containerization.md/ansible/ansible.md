# Automation and Containerization Tools - Ansible

## Overview

Ansible is a powerful automation tool used for configuration management, application deployment, and task automation. It simplifies the process of managing and orchestrating IT infrastructure, making it a critical tool for DevOps and system administrators.

## Detailed Explanation

### Basic Concepts

- **Playbooks**: YAML files that define the set of tasks to be executed on managed nodes. Example:
  ```yaml
  - hosts: webservers
    tasks:
      - name: Install nginx
        apt:
          name: nginx
          state: present
  ```
- **Inventory**: A file that lists the hosts and groups of hosts managed by Ansible. Example:
  ```ini
  [webservers]
  web1.example.com
  web2.example.com

  [dbservers]
  db1.example.com
  ```
- **Modules**: Reusable units of code that perform specific tasks. Examples include `apt`, `yum`, `copy`, and `file`.
  ```yaml
  - name: Copy a file
    copy:
      src: /path/to/source
      dest: /path/to/destination
  ```
- **Roles**: Reusable components that bundle tasks, handlers, and other elements. Roles help organize playbooks and make them easier to manage.

### Advanced Concepts

- **Ansible Tower**: A web-based user interface that provides a dashboard for managing Ansible projects, inventories, and playbooks.
- **Dynamic Inventory**: A method to create an inventory dynamically from external sources like cloud providers or databases.
- **Jinja2 Templating**: Allows for dynamic content generation within playbooks. Example:
  ```yaml
  - name: Create a configuration file
    template:
      src: config.j2
      dest: /etc/myapp/config.conf
  ```

## Setup and Installation

### Installing Ansible

1. **On Linux/macOS**:
   - Use `pip` to install Ansible:
     ```bash
     pip install ansible
     ```
   - Alternatively, use the package manager:
     ```bash
     sudo apt update
     sudo apt install ansible  # For Debian-based systems
     sudo yum install ansible  # For Red Hat-based systems
     ```

2. **On Windows**:
   - Install Windows Subsystem for Linux (WSL) and follow the Linux installation steps, or use the [Windows installer](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-windows).

3. **Verify Installation**:
   ```bash
   ansible --version
   ```

### Configuring Ansible

- **Create an Inventory File**: Define your hosts in `/etc/ansible/hosts` or another location.
  ```ini
  [webservers]
  server1.example.com
  server2.example.com
  ```

- **Write a Simple Playbook**: Create a YAML file, e.g., `setup.yml`.
  ```yaml
  - hosts: webservers
    tasks:
      - name: Install Apache
        apt:
          name: apache2
          state: present
  ```

- **Run the Playbook**:
  ```bash
  ansible-playbook -i /path/to/inventory setup.yml
  ```

## Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Ansible GitHub Repository](https://github.com/ansible/ansible)
- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)

## Exercises

### Easy Problem

**Task**: Write a simple Ansible playbook to ensure that Nginx is installed on a server.

**Solution**:
```yaml
- hosts: webservers
  tasks:
    - name: Install Nginx
      apt:
        name: nginx
        state: present
```

### Medium Problem

**Task**: Write a playbook to configure a web server by installing Apache and deploying a static HTML file.

**Solution**:
```yaml
- hosts: webservers
  tasks:
    - name: Install Apache
      apt:
        name: apache2
        state: present

    - name: Deploy index.html
      copy:
        content: |
          <html>
          <head><title>Welcome</title></head>
          <body><h1>Welcome to the web server!</h1></body>
          </html>
        dest: /var/www/html/index.html
```

### Hard Problem

**Task**: Write a playbook that uses roles to set up a LAMP stack (Linux, Apache, MySQL, PHP) on a server.

**Solution**:

1. **Create Directory Structure**:
   ```bash
   ansible-galaxy init lamp
   ```

2. **Write Roles**:

   - **lamp/roles/apache/tasks/main.yml**:
     ```yaml
     - name: Install Apache
       apt:
         name: apache2
         state: present
     ```

   - **lamp/roles/mysql/tasks/main.yml**:
     ```yaml
     - name: Install MySQL
       apt:
         name: mysql-server
         state: present
     ```

   - **lamp/roles/php/tasks/main.yml**:
     ```yaml
     - name: Install PHP
       apt:
         name: php
         state: present
     ```

3. **Create Main Playbook**:

   - **lamp/playbook.yml**:
     ```yaml
     - hosts: webservers
       roles:
         - apache
         - mysql
         - php
     ```

4. **Run the Playbook**:
   ```bash
   ansible-playbook -i /path/to/inventory lamp/playbook.yml
   ```

## Cheat Sheet

### Basic Commands

- **Run Playbook**:
  ```bash
  ansible-playbook -i inventory_file playbook.yml
  ```

- **Ping All Hosts**:
  ```bash
  ansible all -m ping
  ```

### Playbook Elements

- **Task**:
  ```yaml
  - name: Task description
    module_name:
      option: value
  ```

- **Handler**:
  ```yaml
  handlers:
    - name: Restart service
      service:
        name: service_name
        state: restarted
  ```

- **Variable**:
  ```yaml
  vars:
    variable_name: value
  ```

- **Template**:
  ```yaml
  - name: Deploy template
    template:
      src: template.j2
      dest: /path/to/destination
  ```

### Roles

- **Create Role**:
  ```bash
  ansible-galaxy init role_name
  ```

- **Include Role**:
  ```yaml
  - hosts: webservers
    roles:
      - role_name
  ```