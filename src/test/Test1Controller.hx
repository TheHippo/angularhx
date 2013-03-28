package test;

import angularhx.Http;
import angularhx.IAngularController;
import angularhx.IAngularScope;
import angularhx.Scope;

using StringTools;


class ControllerData implements IAngularScope  {

	public var name:String;

	public function new(defaultName:String) {
		this.name = defaultName;
		trace("set defaultName to " +  defaultName);
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
		http.get('test.json').success(function(data,status,headers, config) {
			trace("success: " + data);
		}).error(function(data, status, headers, config) {
			trace('error ${status}');
		});
		var data = new ControllerData('myDefaultName', scope);
	}
}

