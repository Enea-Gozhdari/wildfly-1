# Ansible Playbook for WildFly Installation and Configuration

This Ansible playbook automates the installation and configuration of WildFly application server in standalone or domain mode. It also supports environment-specific configurations and creates a symbolic link for the WildFly log folder based on the server's hostname.

## Prerequisites

- Ansible installed on the control node.
- Access to the target servers with SSH keys set up for passwordless authentication.
- `vars.yml` file containing necessary variables (e.g., `wildfly_mode`, `wildfly_download_url`, `wildfly_version`, `wildfly_bin`, `domainadmin_test_pwd`, `target_env`, etc.).

## Usage

1. Clone this repository to your local machine:

   ```bash
   git clone <repository_url>

2. Navigate to the directory containing the playbook:
    cd <repository_directory>


3. Run the playbook using the following command:
    **ansible-playbook -i hosts.ini --ask-vault-pass main.yml**

*Replace inventory file with another inventory file after the **-i** switch*

## Explanations: 

## The playbook will execute the tasks to install and configure WildFly based on the provided configuration.

1. Create symlink for WildFly log folder at /opt/logs/wf-hostname_of_the_server
2. Install the following system packages: **java-11-openjdk.x86_64, net-tools, telnet, telnet-server, curl, bind-utils, python3-pip**
3. Stat path of java to /etc/alternatives/jre_openjdk
4. Create symbolic link to java at /opt/java
5. Configure bash_profile of user with the following variables:
    <pre>
        - "JAVA_HOME=/opt/java"
        - "export JAVA_HOME"
        - "JBOSS_HOME=/opt/wildfly"
        - "export JBOSS_HOME"
        - "PATH=$JAVA_HOME/bin:$PATH:$HOME/bin"
    </pre>
6. Configure domain.xml for environment **/opt/wildfly/domain/configuration/domain.xml** using templates/domain.xml.j2 when wildfly mode == "domain"  in vars.yml
7. Download WildFly distribution from the url and version specified in the vars.yml file
8. Changes ownership of the /opt/wildfly directory to the specified user
9. Creates wildfly systemd service using the template wildfly.service.j2 and reloads daemon config file and enables, and starts the service
10. Displays the Wildfly installed version in standalone and domain
11. Create user domainadmin in env Test with the specified parameters, Assign roles to users
12. Configure domain.xml for Prod environment, create users with the specified paramenters, Assign roles to users
13. Configure domain.xml for Dev environment, create users with the specified paramenters, Assign roles to users
14. Set Java heap memory in WildFly configuration 
15. **Deploy PROBE.war to WildFly instances and the playbook assumes that the probe.war file is located /opt/probe_war/PROBE.war**