# angular.hx

Haxe bindings for angular.js

## Implemented


### Controller

Create controllers by implementing `angularhx.IAngularController`.

```Haxe
@controllerName('TestCtrl')
@inject('$scope', '$http')
class TestController implements IAngularController {

	function new(scope:Scope, http:Http) {
		...
	}
}
```

* `@controllerName` is mandatory, it defines the name of the controller from the HTML perspective. If omitted the class name will be used.
* `@inject` is mandatory, list services by their names which will be injected into the controller. The injection will be safe for JavaScript minification.
* The services will be injected in the same order as in the `@inject` meta data.

**Note**: It is up to you ensure the correct types of the injected services!

### Scope

To be more typesafe and more Haxe-ish you could create classes around local scopes. Therefore create a class and extend `angularhx.IAngularScope`.

```Haxe
class ControllerData implements IAngularScope  {

	private var name:String;
	private var readOnly:Bool;

	public function new(defaultName:String) {
		setName(defaultName);
	}

	public function setName(name:Null<String>) {
		this.name = name;
		this.readOnly = name == null;
	}
}


/// In your controller

@inject('$scope')
class TestController implements IAngularController {

	function new(scope:Scope) {
		var scopeData = new ControllerData("defaultName", scope);
	}
}
```

* Every property and method is accessible from HTML
* In HTML classes are flat (there is no difference between static and non static properties)

**Note**: When creating a scope instance you need to add an additional parameter (the scope you got from angular) to the contructor!

### HTTP service

The are binding for the `$http` service. Example:

```Haxe
http.get('test.json').success(function(data) {
	trace("success: " + data);
	// do something with data
}).error(function(data, statusCode) {
	trace('error ${statusCode}');
});
```


## TODO

* create wrappers for creating own services
* create wrappers for creating own filters



## Development

To prepare you local checkout for development you need [**node.js**](http://nodejs.org/) installed.

	$ make prepare

