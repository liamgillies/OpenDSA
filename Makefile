ifeq ($(OS),Windows_NT)
	SHELL=C:/Windows/System32/cmd.exe
endif
RM = rm -rf
CONFIG_SCRIPT = tools/configure.py
TARGET = build
LINT = eslint --no-color
CSSOLDLINTFLAGS = --quiet --errors=empty-rules,import,errors --warnings=duplicate-background-images,compatible-vendor-prefixes,display-property-grouping,fallback-colors,duplicate-properties,shorthand,gradients,font-sizes,floats,overqualified-elements,import,regex-selectors,rules-count,unqualified-attributes,vendor-prefix,zero-units
CSSLINTFLAGS = --quiet --ignore=ids,adjoining-classes
MINIMIZE = uglifyjs

.PHONY: all clean alllint csslint lint lintExe jsonlint min testLTI test TestLMS

all: alllint


allbooks: Everything test CS2 CS3 RecurTutor PL

clean:
	- $(RM) *~
	- $(RM) Books
	@# Remove minified JS and CSS files
	- $(RM) lib/*-min.*
	- $(RM) Doc/*~
	- $(RM) Scripts/*~
	- $(RM) config/*~


alllint: csslint lint jsonlint

csslint:
	@echo 'running csslint'
	@csslint $(CSSLINTFLAGS) AV/Background/*.css
	@csslint $(CSSLINTFLAGS) AV/Design/*.css

TODOcsslint:
	@csslint $(CSSLINTFLAGS) AV/List/*.css
	@csslint $(CSSLINTFLAGS) AV/Sorting/*.css
	@csslint $(CSSLINTFLAGS) AV/Hashing/*.css
	@csslint $(CSSLINTFLAGS) AV/Searching/*.css
	#@csslint $(CSSLINTFLAGS) AV/*.css
	@csslint $(CSSLINTFLAGS) Doc/*.css
	@csslint $(CSSLINTFLAGS) lib/*.css

lint: lintExe
	@echo 'running eslint'
	-@$(LINT) AV/Background/*.js
	-@$(LINT) AV/Design/*.js

TODOlintAV:
	@echo 'linting AVs'
	-@$(LINT) AV/Binary/*.js
	-@$(LINT) AV/General/*.js
	-@$(LINT) AV/List/*.js
	-@$(LINT) AV/Sorting/*.js
	-@$(LINT) AV/Hashing/*.js
	-@$(LINT) AV/Searching/*.js
	-@$(LINT) AV/Sorting/*.js

lintExe:
	@echo 'linting KA Exercises'
	-@$(LINT) Exercises/AlgAnal/*.js
	-@$(LINT) Exercises/Background/*.js
	-@$(LINT) Exercises/Binary/*.js
	-@$(LINT) Exercises/Design/*.js
	-@$(LINT) Exercises/General/*.js
	-@$(LINT) Exercises/Graph/*.js
	-@$(LINT) Exercises/Hashing/*.js
	-@$(LINT) Exercises/Indexing/*.js
	-@$(LINT) Exercises/List/*.js
	-@$(LINT) Exercises/RecurTutor/*.js
	-@$(LINT) Exercises/RecurTutor2/*.js
	-@$(LINT) Exercises/Sorting/*.js

TODO$(LINT)lib:
	@echo 'linting libraries'
	-@$(LINT) lib/odsaUtils.js
	-@$(LINT) lib/odsaAV.js
	-@$(LINT) lib/odsaMOD.js
	-@$(LINT) lib/gradebook.js
	-@$(LINT) lib/registerbook.js
	-@$(LINT) lib/createcourse.js
	-@$(LINT) lib/conceptMap.js

jsonlint:
	@jsonlint -q AV/Background/*.json
	@jsonlint -q AV/Design/*.json
	@jsonlint -q config/*.json
	@jsonlint -q config/Old/*.json

min: nomin
#lib/odsaUtils-min.js lib/site-min.css lib/odsaAV-min.js lib/odsaAV-min.css lib/odsaMOD-min.js lib/odsaMOD-min.css lib/gradebook-min.js lib/gradebook-min.css lib/registerbook-min.js

Plain: Everything CS2 CS3 PL

test_generated: Everything CS2 CS3 CS4104 FormalLang

Test: min
	python $(CONFIG_SCRIPT) config/Test.json --no-lms

CT: min
	python $(CONFIG_SCRIPT) config/CT.json --no-lms

Everything: min
	python tools/rst2json.py $@
	python $(CONFIG_SCRIPT) config/Everything_generated.json --no-lms

CS2: min
	python tools/rst2json.py $@
	python $(CONFIG_SCRIPT) config/CS2_generated.json --no-lms

CS2114: min
	python $(CONFIG_SCRIPT) config/CS2114.json --no-lms

CS3: min
	python tools/rst2json.py $@
	python $(CONFIG_SCRIPT) config/CS3_generated.json --no-lms

CSCI2101: min
	python tools/rst2json.py $@
	python $(CONFIG_SCRIPT) config/CSCI2101_generated.json --no-lms

CS327: min
	python tools/rst2json.py $@
	python $(CONFIG_SCRIPT) config/CS327_generated.json --no-lms

CS172: min
	python $(CONFIG_SCRIPT) config/CS172.json --no-lms

ECE252: min
	python $(CONFIG_SCRIPT) config/ECE252.json --no-lms

PL: min
	python $(CONFIG_SCRIPT) config/PL.json --no-lms

# Tom Naps has added this target while he works on re-packaging the PL book
# He will remove it and the corresponding config file when that re-packaging is complete
PL-naps: min
	python $(CONFIG_SCRIPT) config/PL-naps.json --no-lms

CS4104: min
	python tools/rst2json.py $@
	python $(CONFIG_SCRIPT) config/CS4104_generated.json --no-lms

NPTest: min
	python $(CONFIG_SCRIPT) config/NPTest.json --no-lms

Duncan: min
	python $(CONFIG_SCRIPT) config/Duncan.json --no-lms

FormalLang: min
	python $(CONFIG_SCRIPT) config/FormalLang.json --no-lms

FormalLangCanvas: min
	python tools/rst2json.py $@
	python $(CONFIG_SCRIPT) config/FormalLang_generated.json --no-lms

CS3slides: min
	python $(CONFIG_SCRIPT) -s config/CS3slides.json --no-lms

CS3SS17slides: min
	python $(CONFIG_SCRIPT) -s config/CS3SS17slides.json --no-lms

CS3notes: min
	python $(CONFIG_SCRIPT) config/CS3slides.json -b CS3notes --no-lms

testcmap: min
	python $(CONFIG_SCRIPT) config/testcmap.json --no-lms

CS150: min
	python $(CONFIG_SCRIPT) config/CS150.json --no-lms

CS260: min
	python $(CONFIG_SCRIPT) config/CS260.json --no-lms

CS240: min
	python $(CONFIG_SCRIPT) config/CS240.json --no-lms

CS271-UWO: min
	python $(CONFIG_SCRIPT) config/CS271-UWO.json --no-lms

CSCI204: min
	python $(CONFIG_SCRIPT) config/CSCI204.json --no-lms

CSCI115: min
	python $(CONFIG_SCRIPT) config/CSCI115.json --no-lms

COSC2436: min
	python $(CONFIG_SCRIPT) config/COSC2436.json --no-lms

COMP232: min
	python $(CONFIG_SCRIPT) config/COMP232.json --no-lms

SDAP13: min
	python $(CONFIG_SCRIPT) config/SDAP13.json --no-lms

simple_demo: min
	python $(CONFIG_SCRIPT) config/simple_demo.json --no-lms

cs342_uwosh: min
	python $(CONFIG_SCRIPT) config/cs342_uwosh.json --no-lms

PointersCPP: min
	python $(CONFIG_SCRIPT) config/PointersCPP.json --no-lms

PointersJava: min
	python $(CONFIG_SCRIPT) config/PointersJava.json --no-lms

PointersJavaX: min
	python tools/rst2json.py $@
	python $(CONFIG_SCRIPT) config/PointersJava_generated.json --no-lms

CS3_exs: min
	python $(CONFIG_SCRIPT) config/CS3_exs.json --no-lms

JFLAP: min
	python tools/rst2json.py $@
	python $(CONFIG_SCRIPT) config/JFLAP_generated.json --no-lms

nomin:
	@cp JSAV/build/JSAV.js JSAV/build/JSAV-min.js
	@cp lib/odsaUtils.js lib/odsaUtils-min.js
	@cp lib/odsaMOD.js lib/odsaMOD-min.js
	@cp lib/odsaAV.js lib/odsaAV-min.js
	@cp lib/odsaKA.js lib/odsaKA-min.js
	@cp lib/gradebook.js lib/gradebook-min.js
	@cp lib/registerbook.js lib/registerbook-min.js
	@cp lib/site.css lib/site-min.css
	@cat lib/normalize.css lib/odsaAV.css > lib/odsaAV-min.css
	@cp lib/odsaMOD.css lib/odsaMOD-min.css
	@cp lib/odsaStyle.css lib/odsaStyle-min.css
	@cp lib/odsaKA.css lib/odsaKA-min.css
	@cp lib/gradebook.css lib/gradebook-min.css

rst2json:
	python tools/rst2json.py

pull:
	git pull
	git submodule init
	git submodule update
	make -s -C JSAV
	make -s min
	make -C Doc

lib/odsaUtils-min.js: lib/odsaUtils.js
	@echo 'Minimizing lib/odsaUtils.js'
	@$(MINIMIZE) lib/odsaUtils.js --comments '/^!|@preserve|@license|@cc_on/i' > lib/odsaUtils-min.js

lib/site-min.css: lib/site.css
	@echo 'Minimizing lib/site.css'
	-@$(MINIMIZE) lib/site.css --comments '/^!|@preserve|@license|@cc_on/i' > lib/site-min.css

lib/odsaAV-min.js: lib/odsaAV.js
	@echo 'Minimizing lib/odsaAV.js'
	@$(MINIMIZE) lib/odsaAV.js --comments '/^!|@preserve|@license|@cc_on/i' > lib/odsaAV-min.js

lib/odsaKA-min.js: lib/odsaKA.js
	@echo 'Minimizing lib/odsaKA.js'
	@$(MINIMIZE) lib/odsaKA.js --comments '/^!|@preserve|@license|@cc_on/i' > lib/odsaKA-min.js

lib/odsaAV-min.css: lib/odsaAV.css
	@echo 'Minimizing lib/odsaAV.css'
	@$(MINIMIZE) lib/odsaAV.css --comments '/^!|@preserve|@license|@cc_on/i' > lib/odsaAV-min.css

lib/odsaKA-min.css: lib/odsaKA.css
	@echo 'Minimizing lib/odsaKA.css'
	@$(MINIMIZE) lib/odsaKA.css --comments '/^!|@preserve|@license|@cc_on/i' > lib/odsaKA-min.css

lib/odsaMOD-min.js: lib/odsaMOD.js
	@echo 'Minimizing lib/odsaMOD.js'
	@$(MINIMIZE) lib/odsaMOD.js --comments '/^!|@preserve|@license|@cc_on/i' > lib/odsaMOD-min.js

lib/odsaMOD-min.css: lib/odsaMOD.css
	@echo 'Minimizing lib/odsaMOD.css'
	@$(MINIMIZE) lib/odsaMOD.css --comments '/^!|@preserve|@license|@cc_on/i' > lib/odsaMOD-min.css

lib/gradebook-min.js: lib/gradebook.js
	@echo 'Minimizing lib/gradebook.js'
	@$(MINIMIZE) lib/gradebook.js --comments '/^!|@preserve|@license|@cc_on/i' > lib/gradebook-min.js

lib/gradebook-min.css: lib/gradebook.css
	@echo 'Minimizing lib/gradebook.css'
	@$(MINIMIZE) lib/gradebook.css --comments '/^!|@preserve|@license|@cc_on/i' > lib/gradebook-min.css

lib/registerbook-min.js: lib/registerbook.js
	@echo 'Minimizing lib/registerbook.js'
	@$(MINIMIZE) lib/registerbook.js --comments '/^!|@preserve|@license|@cc_on/i' > lib/registerbook-min.js

lib/createcourse-min.js: lib/createcourse.js
	@echo 'Minimizing lib/createcourse.js'
	@$(MINIMIZE) lib/createcourse.js --comments '/^!|@preserve|@license|@cc_on/i' > lib/createcourse-min.js
