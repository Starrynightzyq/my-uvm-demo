## 
## -------------------------------------------------------------
##    Copyright 2010-2011 Synopsys, Inc.
##    All Rights Reserved Worldwide
## 
##    Licensed under the Apache License, Version 2.0 (the
##    "License"); you may not use this file except in
##    compliance with the License.  You may obtain a copy of
##    the License at
## 
##        http://www.apache.org/licenses/LICENSE-2.0
## 
##    Unless required by applicable law or agreed to in
##    writing, software distributed under the License is
##    distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
##    CONDITIONS OF ANY KIND, either express or implied.  See
##    the License for the specific language governing
##    permissions and limitations under the License.
## -------------------------------------------------------------
## 

TOP ?= top_tb
TEST_CASE ?= my_case0

export LD_LIBRARY_PATH=${VERDI_HOME}/share/PLI/VCS/LINUX64

include $(UVM_HOME)/examples/Makefile.vcs

VCS += -full64 \
	   +v2k \
	   -cpp /usr/local/gcc-4.8.5/bin/g++-4.8.5 \
	   -cc /usr/local/gcc-4.8.5/bin/gcc-4.8.5 \
	   -fsdb \
	   -lca -kdb


all: comp run

comp:
	$(VCS) +incdir+../src \
		-f flist.f \
		-top $(TOP)

run:
	$(SIMV) \
		+UVM_TESTNAME=$(TEST_CASE) \
		+DUMP_FSDB
	make check

check:
	@echo "Checking logs for UVM errors"
	@grep '\(UVM_ERROR\|UVM_FATAL\)' vcs.log | grep -v ':    0'; test $$? -eq 1

wave:
	verdi -elab simv.daidir/kdb \
		-nologo \
		-ssf top.fsdb &

