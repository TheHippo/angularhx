package test;

using StringTools;


// class Extender {

// 	public var name:String;

// 	public function toLower() {
// 		trace("Extender");
// 		this.name = this.name.toLowerCase();
// 	}
// }


class ControllerData implements angularhx.IAngularScope  {

	public var name:String;

	public function new(defaultName:String) {
		this.name = defaultName;
		trace("set defaultName to " +  defaultName);
	}

	public function update() {
		trace("ControllerData");
		this.name = this.name.toUpperCase();
	}
}

@controllerName('TestCtrl')
@inject('$scope')
class Test1Controller implements angularhx.IAngularController {


	function new(scope:angularhx.Scope) {
		trace("new Test1Controller");

		var data = new ControllerData('myDefaultName', scope);
	}
}

