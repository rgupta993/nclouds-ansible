# ansible

Ansible code-base for configuration management, deployment and automation of node application. In this ansible setup, consul is being used for service discovery.

## Installation and Setup

### Dependencies

* pip
* python-dev

### Installation

```
$ sudo make install
```

### Configuration

1. In the `ansible.cfg`, set `remote_user` and `remote_port` to the username and port you use to SSH in
the machine.

2. Edit file at path `environments/prod/inventory` to add server IP's for each group(edit only the IP's to proper values). It requires two server IP's on which main app will be deployed, one redis instance and one server on which consul server and nginx will be running.

3. If nginx needs to be deployed on a different machine, then uncomment line including consul role for `nginx` hosts in file `app-deployment.yml`.

## Running

```
$ ansible-playbook -i environments/prod/inventory app-deployment.yml --private-key /path/to/machine/pem/file -v
```

## Dynamic Inventory

Instead of managing static inventory files with list of IP's, we can use dynamic inventory. As of now i have used static inventory but with proper ec2 machine Name/Tags configured, will add support for dynamic inventory in next release.

## Accessing API's

After playbook has finished running, api's can be accessed using ip of the machine on which nginx is deployed like

`<machine_ip>:80/<api_path>`

More info on available API's can be found [here](https://github.com/rgupta993/nclouds-app#apis).

## Conventions

1. Have structured the playbooks according to different env's like test/stage/prod. With dynamic inventory, deploying to multiple env's using this structure becomes seamless.

2. Variables common to all the env's are added to appropriate files(names after inventory groups) at path `environments/common` and env specific variables to `environments/<env>`.

## Ansible Resources

* [Variable Precedence][1]

[1]: http://docs.ansible.com/ansible/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable
[2]: https://github.com/ansible/ansible/issues/11266
