SUDO ?= -K
ANSIBLE ?= ansible-playbook

.PHONY: bootstrap run check ping

bootstrap:
	@echo ">> Installing base dependencies (dnf + ansible)..."
	@sudo dnf -y install ansible git curl wget python3-dnf-plugins-core
	@ansible-galaxy collection install community.general

run:
	$(ANSIBLE) $(SUDO) -i inventory/hosts site.yml

check:
	$(ANSIBLE) $(SUDO) -i inventory/hosts site.yml --check

ping:
	ansible -i inventory/hosts all -m ping
