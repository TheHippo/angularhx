NODE_BIN			= $(shell which node)
NPM_BIN				= $(shell which npm)
NODE_MODULES		= ./node_modules/.bin/
BOWER_BIN			= $(NODE_MODULES)bower
JADE_BIN			= $(NODE_MODULES)jade
UGLIFY_BIN			= ../../$(NODE_MODULES)uglifyjs

COMPONENTS			= ./components/
ANGULAR_SRC			= $(COMPONENTS)angular/
BOOTSTRAP_SRC		= $(COMPONENTS)bootstrap/

WEB_ROOT			= ./www/

TMPL_SRC			= ./tmpl/

JADE_FLAGS			= --pretty --path $(TMPL_SRC) --out $(WEB_ROOT)

JS_IN				= test.js
UGLIFY_FLAGS		= --in-source-map $(JS_IN:.js=.js.map) --compress --mangle --output $(JS_IN:.js=.min.js) --source-map $(JS_IN:.js=.min.js.map)


all:

compress:
	cd $(WEB_ROOT)scripts/; $(UGLIFY_BIN) $(UGLIFY_FLAGS)

jade:
	$(JADE_BIN) $(JADE_FLAGS) tmpl

prepare: install_dependencies jade

install_dependencies:
	$(NPM_BIN) install
	$(BOWER_BIN) install
	-mkdir $(WEB_ROOT)css
	-mkdir $(WEB_ROOT)scripts
	-mkdir $(WEB_ROOT)img
	cp $(ANGULAR_SRC)*.js $(WEB_ROOT)scripts
	cd $(BOOTSTRAP_SRC); $(NPM_BIN) install
	cd $(BOOTSTRAP_SRC); make
	cp $(BOOTSTRAP_SRC)img/* $(WEB_ROOT)img/
	cp $(BOOTSTRAP_SRC)docs/assets/css/boot*.css $(WEB_ROOT)css

