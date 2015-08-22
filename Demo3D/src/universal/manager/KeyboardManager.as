/**
 * Created by Administrator on 2015/8/15.
 */
package universal.manager
{
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	import gui3D.Geometry3D;
	import gui3D.interf.IAShape;

	import guiFlex.ui.TopToolUI;

	import universal.pattern.event.GameDispatcher;
	import universal.pattern.event.GameEventConst;

	/**
	 * 处理按键事件
	 * */
	public class KeyboardManager
	{
		public function KeyboardManager()
		{
		}

		public function handlerKeyUpEvent(e:KeyboardEvent):void
		{
			var keyCode:uint = e.keyCode;
			if (keyCode == Keyboard.DELETE)
			{
				dealDelete(e);
			} else if (keyCode == Keyboard.SPACE)
			{
				dealBackSpace(e.shiftKey);
			} else if (keyCode == Keyboard.X)
			{
				dealX();
			} else if (keyCode == Keyboard.Y)
			{
				dealY();
			} else if (keyCode == Keyboard.Z)
			{
				dealZ();
			} else if (keyCode == Keyboard.A)
			{
				dealA();
			} else if (keyCode == Keyboard.H)
			{
				dealH();
			} else if (keyCode == Keyboard.N)
			{
				dealC();
			} else if (keyCode == Keyboard.ENTER)
			{
				dealEnter();
			}
		}

		private function dealDelete(e:KeyboardEvent):void
		{
			if (e.shiftKey)
			{
				GameDispatcher.dispatchEvent(GameEventConst.DELETE_SHAPE, {type: 2});
			} else
			{
				GameDispatcher.dispatchEvent(GameEventConst.DELETE_SHAPE, {type: 1});
			}
		}

		private function dealEnter():void
		{
			StageMouseManager.getInstance.setFocusStage();
		}

		private function dealC():void
		{
			TopToolUI.getInstance.createModel();
		}

		private function dealH():void
		{
			TopToolUI.getInstance.updateAuxiliaryVisible();
		}

		private function dealZ():void
		{
			TopToolUI.getInstance.setSelect(4);
		}

		private function dealY():void
		{
			TopToolUI.getInstance.setSelect(3);
		}

		private function dealX():void
		{
			TopToolUI.getInstance.setSelect(2);
		}

		private function dealA():void
		{
			TopToolUI.getInstance.setSelect(1);
		}

		/**处理按空格键*/
		private function dealBackSpace(isAllStop:Boolean):void
		{
			var vec:Vector.<IAShape> = Geometry3D.getInstance.shapeVec;
			var currentShape:IAShape = SelectBoxManager.getInstance.selectShape;
			if (isAllStop)
			{
				var timeId:uint = 0;
				var func:Function = function ():void
				{
					if (timeId > 0)
					{
						clearTimeout(timeId);
						timeId = 0;
					}
					for each(var element:IAShape in vec)
					{
						if (element.signal > 0)
						{
							timeId = setTimeout(func, 100);
							element.signal = 0;
							GameDispatcher.dispatchEvent(GameEventConst.UPDATE_PROPERTY, {item: currentShape});
							break;
						}
					}
				};
				func();
			} else
			{
				if (currentShape)
				{
					if (currentShape.signal > 0)
					{
						currentShape.signal = 0;
						GameDispatcher.dispatchEvent(GameEventConst.UPDATE_PROPERTY, {item: currentShape});
					} else
					{
						currentShape.signal = TopToolUI.getInstance.currentSelectRotationType;
					}
				}
			}
			StageMouseManager.getInstance.setFocusStage();
		}

		public function destroy():void
		{
			_instance = null;
		}

		private static var _instance:KeyboardManager = null;

		public static function get getInstance():KeyboardManager
		{
			if (_instance == null)
			{
				_instance = new KeyboardManager();
			}
			return _instance;
		}
	}
}
