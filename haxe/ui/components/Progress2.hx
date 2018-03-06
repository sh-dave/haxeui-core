package haxe.ui.components;

import haxe.ui.animation.Animation;
import haxe.ui.animation.AnimationManager;
import haxe.ui.components.Range;
import haxe.ui.core.Component;
import haxe.ui.core.IDirectionalComponent;
import haxe.ui.core.ValueBehaviour;
import haxe.ui.util.Variant;

class Progress2 extends Range implements IDirectionalComponent {
    public function new() {
        super();
         _behaviourUpdateOrder = ["min", "max", "pos", "indeterminate"];
    }
    
    //***********************************************************************************************************
    // Public API
    //***********************************************************************************************************
    @:behaviour(IndeterminateBehaviour)   public var indeterminate:Bool;
    
    public var pos(get, set):Float;
    private function get_pos():Float {
        return end;
    }
    private function set_pos(value:Float):Float {
        end = value;
        return value;
    }
    
    //***********************************************************************************************************
    // Overrides
    //***********************************************************************************************************
    private override function get_cssName():String {
        return "progress";
    }
    
    private override function set_min(value:Float):Float {
        super.set_min(value);
        start = value;
        return value;
    }
    
    private override function get_value():Variant {
        return end;
    }
    
    private override function set_value(value:Variant):Variant {
        end = value;
        return value;
    }
}

//***********************************************************************************************************
// Default Behaviours
//***********************************************************************************************************
private class IndeterminateBehaviour extends ValueBehaviour {
    private var _animation:Animation;
    
    public function new(component:Component) {
        super(component, false);
    }
    
    public override function get():Variant {
        return _value;
    }
    
    public override function set(value:Variant) {
        if (value == _value) {
            return;
        }
        
        super.set(value);
        
        if (value == false) {
            _component.removeClass(":indeterminate");
        } else {
            _component.addClass(":indeterminate");
        }
        
    }
    
    public override function detatch() {
        super.detatch();
        _component.removeClass(":indeterminate");
    }
}