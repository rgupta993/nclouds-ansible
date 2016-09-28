PWD=$(shell pwd)

requirements:
	test -d $(PWD)/installed_roles || mkdir $(PWD)/installed_roles
	pip install -r requirements.txt
	bash -c 'if [[ -z $$(tail -n 1 roles.yml | grep "after this line") ]]; then ansible-galaxy install -r roles.yml --force --ignore-errors; fi'
	ln -f -s $(PWD)/roles/* $(PWD)/installed_roles/

silent-install: requirements

install: silent-install

clean:
	rm -rf installed_roles
