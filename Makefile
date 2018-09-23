#
# Functions
#

#
# Build Target Environments
#

.PHONY: all
all: install_dependency

.PHONY: install_dependency 
install_dependency:
	carthage update --platform iOS
