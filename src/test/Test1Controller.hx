package test;

import angularhx.IAngularController;
import angularhx.IAngularScope;

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
@inject('$scope')
class Test1Controller implements IAngularController {


	function new(scope:angularhx.Scope) {
		trace("new Test1Controller");

		var data = new ControllerData('myDefaultName', scope);
	}
}

