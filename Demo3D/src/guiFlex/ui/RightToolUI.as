/**
 * Created by Administrator on 2015/8/13.
 */
package guiFlex.ui
{
	import constants.ShapeType;
	import constants.StringConst;

	import fl.controls.ColorPicker;
	import fl.events.ColorPickerEvent;

	import flash.display.DisplayObjectContainer;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	import gui3D.interf.IAShape;

	import guiFlex.ui.component.StepperLabel;

	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.layouts.VerticalLayout;

	import universal.manager.SelectBoxManager;
	import universal.pattern.event.GameDispatcher;
	import universal.pattern.event.GameEvent;
	import universal.pattern.event.GameEventConst;

	public class RightToolUI extends Group
	{
		private var _main:DisplayObjectContainer;
		private var _container:Group;
		private var _layout:VerticalLayout;

		//位置
		private var _titlePosition:Label;
		private var _positionX:StepperLabel;
		private var _positionY:StepperLabel;
		private var _positionZ:StepperLabel;


		//角度
		private var _titleRotation:Label;
		private var _rotationX:StepperLabel;
		private var _rotationY:StepperLabel;
		private var _rotationZ:StepperLabel;


		//缩放
		private var _titleScale:Label;
		private var _scaleX:StepperLabel;
		private var _scaleY:StepperLabel;
		private var _scaleZ:StepperLabel;


		//三纬
		private var _titleDimension:Label;
		private var _dimensionW:StepperLabel;
		private var _dimensionH:StepperLabel;
		private var _dimensionD:StepperLabel;

		//半径
		private var _titleRadius:Label;
		private var _radius:StepperLabel;

		//颜色
		private var _colorTitle:Label;
		private var _colorPicker:ColorPicker;

		public function RightToolUI()
		{
			super();
			width = 100;
			mouseEnabled = false;
			_container = new Group();
			_container.mouseEnabled = false;
			addElement(_container);

			_layout = new VerticalLayout();
			_layout.gap = 10;
			_container.layout = _layout;

			_titlePosition = new Label();
			_titlePosition.htmlText = StringConst.TITLE_POSITION;
			_container.addElement(_titlePosition);
			_titlePosition.mouseEnabled = false;

			_positionX = new StepperLabel("X:");
			_container.addElement(_positionX);
			_positionX.changeValueHandler = function (value:Number):void
			{
				GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "x", value: value});
			};

			_positionY = new StepperLabel("Y:");
			_container.addElement(_positionY);
			_positionY.changeValueHandler = function (value:Number):void
			{
				GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "y", value: value});
			};

			_positionZ = new StepperLabel("Z:");
			_container.addElement(_positionZ);
			_positionZ.changeValueHandler = function (value:Number):void
			{
				GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "z", value: value});
			};

			_titleRotation = new Label();
			_titleRotation.htmlText = StringConst.TITLE_ROTATION;
			_container.addElement(_titleRotation);
			_titleRotation.mouseEnabled = false;

			_rotationX = new StepperLabel("X:");
			_container.addElement(_rotationX);
			_rotationX.changeValueHandler = function (value:Number):void
			{
				GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "rotationX", value: value});
			};

			_rotationY = new StepperLabel("Y:");
			_container.addElement(_rotationY);
			_rotationY.changeValueHandler = function (value:Number):void
			{
				GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "rotationY", value: value});
			};

			_rotationZ = new StepperLabel("Z:");
			_container.addElement(_rotationZ);
			_rotationZ.changeValueHandler = function (value:Number):void
			{
				GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "rotationZ", value: value});
			};

			_titleScale = new Label();
			_titleScale.htmlText = StringConst.TITLE_SCALE;
			_container.addElement(_titleScale);
			_titleScale.mouseEnabled = false;

			_scaleX = new StepperLabel("X:", .1);
			_container.addElement(_scaleX);
			_scaleX.changeValueHandler = function (value:Number):void
			{
				GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "scaleX", value: value});
			};

			_scaleY = new StepperLabel("Y:", .1);
			_container.addElement(_scaleY);
			_scaleY.changeValueHandler = function (value:Number):void
			{
				GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "scaleY", value: value});
			};

			_scaleZ = new StepperLabel("Z:", .1);
			_container.addElement(_scaleZ);
			_scaleZ.changeValueHandler = function (value:Number):void
			{
				GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "scaleZ", value: value});
			};

			_titleDimension = new Label();
			_titleDimension.htmlText = StringConst.TITLE_DIMENSION;
			_container.addElement(_titleDimension);
			_titleDimension.mouseEnabled = false;

			_dimensionW = new StepperLabel("W:");
			_container.addElement(_dimensionW);
			_dimensionW.changeValueHandler = function (value:Number):void
			{
				var shape:IAShape = SelectBoxManager.getInstance.selectShape;
				if (shape)
				{
					if (shape.type == ShapeType.CUBE_TYPE)
					{
						GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "width", value: value});
					}
				}
			};

			_dimensionH = new StepperLabel("H:");
			_container.addElement(_dimensionH);
			_dimensionH.changeValueHandler = function (value:Number):void
			{
				var shape:IAShape = SelectBoxManager.getInstance.selectShape;
				if (shape)
				{
					if (shape.type == ShapeType.CUBE_TYPE)
					{
						GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "height", value: value});
					}
				}
			};

			_dimensionD = new StepperLabel("D:");
			_container.addElement(_dimensionD);
			_dimensionD.changeValueHandler = function (value:Number):void
			{
				var shape:IAShape = SelectBoxManager.getInstance.selectShape;
				if (shape)
				{
					if (shape.type == ShapeType.CUBE_TYPE)
					{
						GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "depth", value: value});
					}
				}
			};

			_titleRadius = new Label();
			_titleRadius.htmlText = StringConst.TITLE_RADIUS;
			_titleRadius.mouseEnabled = false;
			_container.addElement(_titleRadius);

			_radius = new StepperLabel("R:");
			_container.addElement(_radius);
			_radius.changeValueHandler = function (value:Number):void
			{
				var shape:IAShape = SelectBoxManager.getInstance.selectShape;
				if (shape)
				{
					if (shape.type != ShapeType.CUBE_TYPE)
					{
						GameDispatcher.dispatchEvent(GameEventConst.CHANGE_PROPERTY, {key: "radius", value: value});
					}
				}
			};

			_colorTitle = new Label();
			_colorTitle.htmlText = StringConst.TITLE_COLOR;
			_colorTitle.mouseEnabled = false;
			_container.addElement(_colorTitle);

			addEvent();
		}

		private function onChangeColorEvt(event:ColorPickerEvent):void
		{
			//更新颜色
			GameDispatcher.dispatchEvent(GameEventConst.CHANGE_COLOR, {color: event.color});
			if (_main && _main.stage && _main.stage.focus)
			{
				_main.stage.focus = _main.stage;
			}
		}

		private function addEvent():void
		{
			GameDispatcher.addEventListener(GameEventConst.UPDATE_PROPERTY, handlerUpdateProperty);
			GameDispatcher.addEventListener(GameEventConst.STAGE_RESIZE, handlerStageRize);
		}

		private function handlerUpdateProperty(event:GameEvent):void
		{
			var object:IAShape = event.param.item;
			_positionX.value = parseFloat(object.x.toFixed(2));
			_positionY.value = parseFloat(object.y.toFixed(2));
			_positionZ.value = parseFloat(object.z.toFixed(2));

			_scaleX.value = parseFloat(object.scaleX.toFixed(2));
			_scaleY.value = parseFloat(object.scaleY.toFixed(2));
			_scaleZ.value = parseFloat(object.scaleZ.toFixed(2));

			_rotationX.value = parseFloat(object.rotationX.toFixed(2)) % 360;
			_rotationY.value = parseFloat(object.rotationY.toFixed(2)) % 360;
			_rotationZ.value = parseFloat(object.rotationZ.toFixed(2)) % 360;

			_dimensionW.value = parseFloat(object.width.toFixed(2));
			_dimensionH.value = parseFloat(object.height.toFixed(2));
			_dimensionD.value = parseFloat(object.depth.toFixed(2));

			_radius.value = parseFloat(object.radius.toFixed(2));
		}

		public function resetData():void
		{
			_positionX.value = _positionY.value = _positionZ.value = 0.0;
			_scaleX.value = _scaleY.value = _scaleZ.value = 1.0;
			_rotationX.value = _rotationY.value = _rotationZ.value = 0.0;
			_dimensionW.value = _dimensionH.value = _dimensionD.value = 0.0;
			_radius.value = 0.0;
		}

		public function setMain(main:DisplayObjectContainer):void
		{
			validateNow(false);

			_main = main;
			_colorPicker = new ColorPicker();
			_colorPicker.selectedColor = 0xcccccc;
			if (_main)
			{
				var timeId:uint = setTimeout(function ():void
				{
					_main.addChild(_colorPicker);
					clearTimeout(timeId);
				}, 100);
			}

			_colorPicker.move(main.stage.stageWidth - width + _layout.gap, getBounds(_container).height + _layout.gap - 5);
			_colorPicker.setSize(15, 15);
			_colorPicker.addEventListener(ColorPickerEvent.CHANGE, onChangeColorEvt, false, 0, true);
		}

		private function handlerStageRize(event:GameEvent):void
		{
			var stageW:Number = event.param.width;
			if (_colorPicker)
			{
				_colorPicker.move(stageW - width + _layout.gap, getBounds(_container).height + _layout.gap - 5);
			}
		}

		public function destroy():void
		{
			GameDispatcher.removeEventListener(GameEventConst.UPDATE_PROPERTY, handlerUpdateProperty);
			GameDispatcher.removeEventListener(GameEventConst.STAGE_RESIZE, handlerStageRize);
			_colorTitle && (_colorTitle = null);
			if (_colorPicker && _colorPicker.parent)
			{
				_colorPicker.parent.removeChild(_colorPicker);
				_colorPicker.removeEventListener(ColorPickerEvent.CHANGE, onChangeColorEvt);
				_colorPicker = null;
			}
			_main && (_main = null);

			if (_layout)
			{
				_layout = null;
			}
			if (_container)
			{
				_container.removeAllElements();
				_container = null;
			}
			_titlePosition && (_titlePosition = null);
			if (_positionX)
			{
				_positionX.destroy();
				_positionX = null;
			}
			if (_positionY)
			{
				_positionY.destroy();
				_positionY = null;
			}
			if (_positionZ)
			{
				_positionZ.destroy();
				_positionZ = null;
			}
			_titleRotation && (_titleRotation = null);
			if (_rotationX)
			{
				_rotationX.destroy();
				_rotationX = null;
			}
			if (_rotationY)
			{
				_rotationY.destroy();
				_rotationY = null;
			}
			if (_rotationZ)
			{
				_rotationZ.destroy();
				_rotationZ = null;
			}
			_titleScale && (_titleScale = null);
			if (_scaleX)
			{
				_scaleX.destroy();
				_scaleX = null;
			}
			if (_scaleY)
			{
				_scaleY.destroy();
				_scaleY = null;
			}
			if (_scaleZ)
			{
				_scaleZ.destroy();
				_scaleZ = null;
			}
			_titleDimension && (_titleDimension = null);
			if (_dimensionD)
			{
				_dimensionD.destroy();
				_dimensionD = null;
			}
			if (_dimensionH)
			{
				_dimensionH.destroy();
				_dimensionH = null;
			}
			if (_dimensionW)
			{
				_dimensionW.destroy();
				_dimensionW = null;
			}
			_titleRadius && (_titleRadius = null);
			if (_radius)
			{
				_radius.destroy();
				_radius = null;
			}
			_instance = null;
		}

		private static var _instance:RightToolUI = null;

		public static function get getInstance():RightToolUI
		{
			if (_instance == null)
			{
				_instance = new RightToolUI();
			}
			return _instance;
		}

	}
}
