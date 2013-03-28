package angularhx.boot;

import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.Context;

using Lambda;

class AngularController {

	static var controllers = new Map<String,ClassType>();

	macro static function build():Array<Field> {
		var pos = Context.currentPos();
		var fields = Context.getBuildFields();
		var localClass = Context.getLocalClass().get();
		trace("Build Controller " + localClass.name);

		var controllerName = getControllerName(localClass);
		if (controllers.exists(controllerName)) {
			var other = controllers.get(controllerName);
			var otherPos = other.module + ': ' + other.pos;
			Context.error('Controller with this name ready exists! (' + otherPos + ')', localClass.pos);
		}
		controllers.set(controllerName, localClass);
		exposeClass(controllerName, localClass);

		var dependencies = getDependencies(localClass);

		fields.push(getDependenciesField(localClass, dependencies));

		return fields;
	}

	static function getDependencies(cls:ClassType):Array<String> {
		var ret = [];
		if (cls.meta.has('inject')) {
			for (m in cls.meta.get()) {
				if (m.name == 'inject') {
					for (p in m.params) {
						switch (p.expr) {
							case EConst(CString(s)):
								ret.push(s);
							default:
								Context.error('Injected services need to be indentified as a string', m.pos);
						}
					}
				}
			}
		}
		return ret;
	}

	static function getControllerName(cls:ClassType):String {
		if (!cls.meta.has('controllerName'))
			return cls.name;
		else {
			for (m in cls.meta.get()) {
				if (m.name == 'controllerName' && m.params.length == 1) {
					switch (m.params[0].expr) {
						case EConst(CString(s)):
							cls.meta.remove('controllerName');
							return s;
						default:
							Context.error('controllerName metadata requires string', m.pos);
					}
				}
			}
			Context.error('Wrong declaration of controllerName: @controllerName("controllerName")', cls.pos);
			return "We never reach this!";
		}
	}

	static function exposeClass(name:String, cls:ClassType) {
		if (cls.meta.has(':expose')) {
			Context.error('Class already exposed!', cls.pos);
		}
		cls.meta.add(':expose', [macro $v{name}], cls.pos);
	}

	static function getDependenciesField(cls:ClassType, dependencies:Array<String>):Field {
		var StringType = TPath({pack: [], name:"String", params:[], sub:null});
		var ArrayStringType = TPath({ pack : [], name : "Array", params : [TPType(StringType)], sub : null });
		var field = {
			pos: cls.pos,
			name: "$inject",
			meta: [],
			doc: null,
			access: [APublic, AStatic],
			kind:FVar(ArrayStringType, macro $v{dependencies})
		};
		return field;
	}

}