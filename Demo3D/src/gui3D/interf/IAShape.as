/**
 * Created by Administrator on 2015/8/12.
 */
package gui3D.interf
{
	import flash.geom.Vector3D;

	public interface IAShape
	{
		function get signal():int;
		function set signal(value:int):void;

		function get type():int;

		function set type(value:int):void;

		function render(time:int):void;

		function stopListen():void;

		function startListen():void;

		function get position():Vector3D;

		function set position(value:Vector3D):void;

		function get width():Number;

		function set width(value:Number):void;

		function get height():Number;

		function set height(value:Number):void;

		function get depth():Number;

		function set depth(value:Number):void;

		function get radius():Number;

		function set radius(value:Number):void;

		function get rotationX():Number;

		function set rotationX(value:Number):void;

		function get rotationY():Number;

		function set rotationY(value:Number):void;

		function get rotationZ():Number;

		function set rotationZ(value:Number):void;

		function get scaleX():Number;

		function set scaleX(value:Number):void;

		function get scaleY():Number;

		function set scaleY(value:Number):void;

		function get scaleZ():Number;

		function set scaleZ(value:Number):void;

		function get alpha():Number;

		function set alpha(value:Number):void;

		function get color():uint;

		function set color(value:uint):void;

		function get x():Number;

		function get y():Number;

		function get z():Number;

		function destroy():void;
	}
}
