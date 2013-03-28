package test;

import angularhx.Http;
import angularhx.IAngularController;
import angularhx.IAngularScope;
import angularhx.Scope;

using StringTools;


class ControllerData implements IAngularScope  {

	private var name:String;
	private var readOnly:Bool;

	public function new() {
		this.readOnly = true;
	}

	public function setName(name:Null<String>) {
		this.name = name;
		this.readOnly = name == null;
	}

	public function change() {
		trace("Changed value to: " + this.name);
	}

	public function update() {
		trace("ControllerData");
		this.name = this.name.toUpperCase();
	}
}

@controllerName('TestCtrl')
@inject('$scope', '$http')
class Test1Controller implements IAngularController {


	function new(scope:Scope, http:Http) {
		trace("new Test1Controller");
		var scopeData = new ControllerData(scope);
		http.get('test.json').success(function(data) {
			trace("success: " + data.defaultName);
			scopeData.setName(data.defaultName);
		}).error(function(data, status) {
			trace('error ${status}');
		});
	}
}

