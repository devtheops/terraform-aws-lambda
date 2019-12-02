TERRAFORM ?= terraform

test:
	@cd tests && $(TERRAFORM) init
	@cd tests && $(TERRAFORM) validate
	@cd tests && $(TERRAFORM) plan
