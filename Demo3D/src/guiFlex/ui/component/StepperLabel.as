/**
 * Created by Administrator on 2015/8/13.
 */
package guiFlex.ui.component
{
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	import org.flexlite.domUI.components.Group;
	import org.flexlite.domUI.components.Label;
	import org.flexlite.domUI.components.TextInput;
	import org.flexlite.domUI.layouts.VerticalLayout;

	public class StepperLabel extends Group
	{
		private var _container:Group;
		private var _titleLabel:Label;
		private var _title:String;
		private var _upBtn:UpBtn;
		private var _downBtn:DownBtn;
		private var _btnContainer:Group;
		private var _btnLayout:VerticalLayout;
		private var _input:TextInput;
		private var _value:Number = 0.0;
		private var _step:Number = 0;
		/**
		 * 当值发生变化时回调函数 argument:  value:Number
		 * */
		public var changeValueHandler:Function;
		/*
		 * @param step 步进
		 * @param title 标题
		 * @param titleColor 标题颜色
		 * */
		public function StepperLabel(title:String = "", step:Number = 1.0, titleColor:uint = 0xaaaaaa)
		{
			super();
			_title = title;
			_step = step;

			_container = new Group();
			addElement(_container);

			_btnContainer = new Group();
			_btnLayout = new VerticalLayout();
			_btnLayout.gap = 10;
			_btnContainer.layout = _btnLayout;

			_upBtn = new UpBtn();
			_btnContainer.addElement(_upBtn);

			_downBtn = new DownBtn();
			_btnContainer.addElement(_downBtn);

			if (_title && _title.length > 0)
			{
				_titleLabel = new Label();
				_titleLabel.textColor = titleColor;
				_titleLabel.text = _title;
				_container.addElement(_titleLabel);
				_titleLabel.x = 0;
			}

			_input = new TextInput();
			_input.height = 18;
			_input.width = 50;
			_input.text = "0";
			_container.addElement(_input);
			_container.addElement(_btnContainer);

			var offX:Number = 0;
			if (_titleLabel)
			{
				offX = 15;
			}
			_input.x = offX;
			_btnContainer.x = _input.x + _input.width + 5;
			_input.addEventListener(FocusEvent.FOCUS_OUT, onLoseFocus);
			_input.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			_upBtn.clickHandler = UpHandler;
			_upBtn.downHandler = UpHandler;

			_downBtn.clickHandler = DownHandler;
			_downBtn.downHandler = DownHandler;
		}

		private function onKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.ENTER || event.keyCode == Keyboard.SPACE)
			{
				if (stage)
				{
					if (stage.focus != stage)
					{
						stage.focus = stage;
					}
				}
				onLoseFocus();
			}
		}

		private function DownHandler():void
		{
			_value -= _step;
			update(_value);
			changeValueHandler && changeValueHandler(_value);
		}

		private function UpHandler():void
		{
			_value += _step;
			update(_value);
			changeValueHandler && changeValueHandler(_value);
		}

		public function update(value:Number = 0):void
		{
			_value = value;
			_input.text = _value.toFixed(1);
		}

		private function onLoseFocus(ev:FocusEvent = null):void
		{
			var num:Number = parseFloat(_input.text);
			if (isNaN(num))
			{
				num = 0;
			}
			value = num;
			changeValueHandler && changeValueHandler(_value);
		}

		public function get value():Number
		{
			return _value;
		}

		public function set value(value:Number):void
		{
			_value = value;
			update(_value);
		}

		public function destroy():void
		{
			if (_container)
			{
				_container.removeAllElements();
				_container = null;
			}

			if (_btnContainer)
			{
				_btnContainer.removeAllElements();
				_btnContainer = null;
			}

			_titleLabel && (_titleLabel = null);
			_btnLayout && (_btnLayout = null);
			if (_input)
			{
				_input.removeEventListener(FocusEvent.FOCUS_OUT, onLoseFocus);
				_input.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
				_input = null;
			}

			if (_upBtn)
			{
				_upBtn.destroy();
				_upBtn = null;
			}
			if (_downBtn)
			{
				_downBtn.destroy();
				_downBtn = null;
			}
			_title = null;
		}
	}
}

import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.geom.Point;
import flash.utils.clearTimeout;
import flash.utils.getTimer;
import flash.utils.setTimeout;

import org.flexlite.domUI.components.Group;
import org.flexlite.domUI.core.UIComponent;

class UpBtn extends Group
{
	private var _bg:UIComponent;
	private var _btn:UIComponent;
	private var _vertices:Vector.<Number>;
	public var clickHandler:Function;
	public var downHandler:Function;
	private var _currentTime:uint = 0;
	private var _during:int = 100;
	private var _position:Point;
	private var _timeId:uint = 0;

	public function UpBtn()
	{
		_position = new Point();
		_bg = new UIComponent();
		_bg.graphics.beginFill(0x161515);
		_bg.graphics.drawRoundRectComplex(0, 0, 12, 8, 2, 2, 0, 0);
		_bg.graphics.endFill();
		addElement(_bg);

		_vertices = new Vector.<Number>();
		_vertices.push(6, 2);
		_vertices.push(9, 6);
		_vertices.push(4, 6);

		_btn = new UIComponent();
		_btn.graphics.beginFill(0xaaaaaa);
		_btn.graphics.drawTriangles(_vertices);
		_btn.graphics.endFill();
		addElement(_btn);
		addEventListener(MouseEvent.ROLL_OVER, onRollHandler, false, 0, true);
		addEventListener(MouseEvent.ROLL_OUT, onRollHandler, false, 0, true);
		addEventListener(MouseEvent.CLICK, onClickHandler, false, 0, true);
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler, false, 0, true);
	}

	private function onMouseDownHandler(event:MouseEvent):void
	{
		_position.x = event.stageX;
		_position.y = event.stageY;
		_timeId = setTimeout(function ():void
		{
			if (_timeId)
			{
				addEventListener(Event.ENTER_FRAME, onRender, false, 0, true);
			}
		}, 500);
		addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
	}

	private function onMouseUpHandler(event:MouseEvent = null):void
	{
		removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
		removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
		removeEventListener(Event.ENTER_FRAME, onRender);
		if (_timeId)
		{
			clearTimeout(_timeId);
			_timeId = 0;
		}
	}

	private function onMouseMoveHandler(event:MouseEvent):void
	{
		if (_position.x != event.stageX || _position.y != event.stageY)
		{
			onMouseUpHandler();
			if (_timeId)
			{
				clearTimeout(_timeId);
				_timeId = 0;
			}
		}
	}

	private function onRender(event:Event):void
	{
		if (getTimer() - _currentTime > _during)
		{
			downHandler && downHandler();
			_currentTime = getTimer();
		}
	}

	private function onClickHandler(event:MouseEvent):void
	{
		if (clickHandler != null)
		{
			clickHandler();
		}
	}

	private function onRollHandler(event:MouseEvent):void
	{
		if (event.type == MouseEvent.ROLL_OVER)
		{
			_bg.filters = [new GlowFilter(0xffffff, 1, 4, 4, 1, 1, true)];
		} else
		{
			_bg.filters = null;
		}
	}

	public function destroy():void
	{
		if (_vertices)
		{
			_vertices.length = 0;
			_vertices = null;
		}
		removeEventListener(MouseEvent.ROLL_OVER, onRollHandler);
		removeEventListener(MouseEvent.ROLL_OUT, onRollHandler);
		removeEventListener(MouseEvent.CLICK, onClickHandler);
		removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
		onMouseUpHandler();
		removeAllElements();
		_bg = null;
		_btn = null;
		clickHandler = null;
	}
}

class DownBtn extends Group
{
	private var _bg:UIComponent;
	private var _btn:UIComponent;
	private var _vertices:Vector.<Number>;
	public var clickHandler:Function;
	public var downHandler:Function;
	private var _currentTime:uint = 0;
	private var _during:int = 100;
	private var _position:Point;
	private var _timeId:uint = 0;

	public function DownBtn()
	{
		_position = new Point();
		_bg = new UIComponent();
		_bg.graphics.beginFill(0x161515);
		_bg.graphics.drawRoundRectComplex(0, 0, 12, 8, 0, 0, 2, 2);
		_bg.graphics.endFill();
		addElement(_bg);

		_vertices = new Vector.<Number>();
		_vertices.push(4, 2);
		_vertices.push(9, 2);
		_vertices.push(6, 6);

		_btn = new UIComponent();
		_btn.graphics.beginFill(0xaaaaaa);
		_btn.graphics.drawTriangles(_vertices);
		_btn.graphics.endFill();
		addElement(_btn);
		addEventListener(MouseEvent.ROLL_OVER, onRollHandler, false, 0, true);
		addEventListener(MouseEvent.ROLL_OUT, onRollHandler, false, 0, true);
		addEventListener(MouseEvent.CLICK, onClickHandler, false, 0, true);
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler, false, 0, true);
	}

	private function onMouseDownHandler(event:MouseEvent):void
	{
		_position.x = event.stageX;
		_position.y = event.stageY;
		_timeId = setTimeout(function ():void
		{
			if (_timeId)
			{
				addEventListener(Event.ENTER_FRAME, onRender, false, 0, true);
			}
		}, 500);
		addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
	}

	private function onMouseUpHandler(event:MouseEvent = null):void
	{
		removeEventListener(MouseEvent.MOUSE_UP, onMouseUpHandler);
		removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMoveHandler);
		removeEventListener(Event.ENTER_FRAME, onRender);
		if (_timeId)
		{
			clearTimeout(_timeId);
			_timeId = 0;
		}
	}

	private function onMouseMoveHandler(event:MouseEvent):void
	{
		if (_position.x != event.stageX || _position.y != event.stageY)
		{
			onMouseUpHandler();
			if (_timeId)
			{
				clearTimeout(_timeId);
				_timeId = 0;
			}
		}
	}

	private function onRender(event:Event):void
	{
		if (getTimer() - _currentTime > _during)
		{
			downHandler && downHandler();
			_currentTime = getTimer();
		}
	}

	private function onClickHandler(event:MouseEvent):void
	{
		if (clickHandler != null)
		{
			clickHandler();
		}
	}

	private function onRollHandler(event:MouseEvent):void
	{
		if (event.type == MouseEvent.ROLL_OVER)
		{
			_bg.filters = [new GlowFilter(0xffffff, 1, 4, 4, 1, 1, true)];
		} else
		{
			_bg.filters = null;
		}
	}

	public function destroy():void
	{
		if (_vertices)
		{
			_vertices.length = 0;
			_vertices = null;
		}
		removeEventListener(MouseEvent.ROLL_OVER, onRollHandler);
		removeEventListener(MouseEvent.ROLL_OUT, onRollHandler);
		removeEventListener(MouseEvent.CLICK, onClickHandler);
		removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDownHandler);
		onMouseUpHandler();
		removeAllElements();
		_bg = null;
		_btn = null;
		clickHandler = null;
	}
}