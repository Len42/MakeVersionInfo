VERSION_FILE = $(SOLUTIONDIR)VersionInfo.txt

all: $(TARGETS)

clean:
	del $(TARGETS) "$(VERSION_FILE)""

rebuild: clean all

# All targets get the version info from $(VERSION_FILE)
$(TARGETS): $(VERSION_FILE)

# Powershell command line
PSCMD = powershell -executionpolicy unrestricted

$(VERSION_FILE):
	@echo Updating build number
	$(PSCMD) -command "&{.\Write-VersionInfo.ps1 -File '$@'}"

# Rules to create header files with version info from corresponding template files
.SUFFIXES: .txttemplate .htemplate .cstemplate

.txttemplate.txt:
	$(PSCMD) -command "&{cat '$*.txttemplate' | .\Write-FileWithVersionInfo.ps1 -VersionFile '$(VERSION_FILE)' }" >$@

.htemplate.h:
	$(PSCMD) -command "&{cat '$*.htemplate' | .\Write-FileWithVersionInfo.ps1 -VersionFile '$(VERSION_FILE)' }" >$@

.cstemplate.cs:
	$(PSCMD) -command "&{cat '$*.cstemplate' -Encoding OEM | .\Write-FileWithVersionInfo.ps1 -VersionFile '$(VERSION_FILE)' }" >$@
