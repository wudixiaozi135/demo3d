/**
 * Created by Administrator on 2015/8/14.
 */
package gui3D.shapes
{
	import away3d.containers.ObjectContainer3D;

	import flash.geom.Vector3D;

	import gui3D.interf.IAShape;

	import universal.pattern.event.GameDispatcher;
	import universal.pattern.event.GameEvent;
	import universal.pattern.event.GameEventConst;

	public class AShapeBase extends ObjectContainer3D implements IAShape
	{
		///默认属性
		protected var _width:Number = 200;
		protected var _height:Number = 200;
		protected var _depth:Number = 200;
		protected var _radius:Number = 100;
		protected var _alpha:Number = 1.0;
		protected var _color:uint = 0xcccccc;
		protected var _position:Vector3D;
		protected var _rotationSpeed:Number = 10;
		protected var _signal:int = 0;
		protected var _type:int = 0;

		public function AShapeBase()
		{
			_position = new Vector3D();
		}

		/**
		 * ShapeType定义
		 * */
		public function get type():int
		{
			return _type;
		}

		public function set type(value:int):void
		{
			_type = value;
		}

		public function get signal():int
		{
			return _signal;
		}

		public function set signal(value:int):void
		{
			_signal = value;
		}

		public function render(time:int):void
		{
			if (_signal == -1)
			{
				if (rotationX != 0 || rotationY != 0 || rotationZ != 0)
				{
					rotationX = rotationY = rotationZ = 0;
					GameDispatcher.dispatchEvent(GameEventConst.UPDATE_PROPERTY, {item: this});
				}
				return;
			}
			if (_signal == 1)
			{
				pitch(_rotationSpeed);
				rotationY = rotationZ = 0;
			} else if (_signal == 2)
			{
				rotationX = rotationZ = 0;
				yaw(_rotationSpeed);
			} else if (_signal == 3)
			{
				rotationX = rotationY = 0;
				roll(_rotationSpeed);
			}
		}

		/**
		 * 停止监听数据
		 * */
		public function stopListen():void
		{
			GameDispatcher.removeEventListener(GameEventConst.CHANGE_PROPERTY, changeProperty);
			GameDispatcher.removeEventListener(GameEventConst.CHANGE_COLOR, changeColor);
			GameDispatcher.removeEventListener(GameEventConst.ROTATION_ANIMATE, rotationAnimate);
		}

		/**
		 * 开始监听数据
		 * */
		public function startListen():void
		{
			stopListen();
			GameDispatcher.addEventListener(GameEventConst.CHANGE_PROPERTY, changeProperty, false, 0, true);
			GameDispatcher.addEventListener(GameEventConst.CHANGE_COLOR, changeColor, false, 0, true);
			GameDispatcher.addEventListener(GameEventConst.ROTATION_ANIMATE, rotationAnimate, false, 0, true);
		}

		private function changeProperty(event:GameEvent):void
		{
			var obj:Object = event.param;
			var key:String = obj.key;
			this[key] = obj.value;
			if (key.indexOf("rotation") != -1)
			{
				return;
			}
			GameDispatcher.dispatchEvent(GameEventConst.UPDATE_PROPERTY, {item: this});
		}

		private function changeColor(event:GameEvent):void
		{
			color = event.param.color;
		}

		private function rotationAnimate(event:GameEvent):void
		{
			signal = event.param.type;
		}

		public function get width():Number
		{
			return _width;
		}

		public function set width(value:Number):void
		{
			_width = value;
		}

		public function get height():Number
		{
			return _height;
		}

		public function set height(value:Number):void
		{
			_height = value;
		}

		public function get depth():Number
		{
			return _depth;
		}

		public function set depth(value:Number):void
		{
			_depth = value;
		}

		public function get radius():Number
		{
			return _radius;
		}

		public function set radius(value:Number):void
		{
			_radius = value;
		}

		public function get alpha():Number
		{
			return _alpha;
		}

		public function set alpha(value:Number):void
		{
			_alpha = value;
		}

		public function get color():uint
		{
			return _color;
		}

		public function set color(value:uint):void
		{
			_color = value;
		}

		override public function get position():Vector3D
		{
			if (_position.x != x)
			{
				_position.x = x;
			}
			if (_position.y != y)
			{
				_position.y = y;
			}
			if (_position.z != z)
			{
				_position.z = z;
			}
			return _position;
		}

		override public function set position(value:Vector3D):void
		{
			_position = value;
			x = _position.x;
			y = _position.y;
			z = _position.z;
		}

		public function destroy():void
		{
			stopListen();
			_position && (_position = null);
			signal = 0;
		}
	}
}
