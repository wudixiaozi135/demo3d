/**
 * Created by Administrator on 2015/7/24 0024.
 */
package universal.pattern.event
{
	public class GameEventConst
	{
		/**移动拖拽物*/
		public static const MOVE_DRAG_ITEM:String = "move_drag_item";
		public static const DOWN_ITEM:String = "down_item";

		/*
		* {type:String} 1:xyz 2:xy 3:xy 4:yz
		* */
		public static const DRAG_SELECT_ITEM:String = "drag_select_item";
		/*
		* {value:boolean} true显示 false隐藏
		* */
		public static const HIDE_SHOW_AUXILIARYLINE:String = "hide_show_auxiliaryline";
		/*
		* {item:ObjectContainer3D}
		* */
		public static const UPDATE_PROPERTY:String = "update_position";
		/*
		* {type:int} 1立方体 2 圆柱体 3圆锥体 4球体
		* */
		public static const CREATE_SHAPE:String = "create_shape";
		/**
		 *{key:String,value:Number} key (x y z rotationX rotationY rotationZ scaleX scaleY scaleZ width heigth depth)
		 * */
		public static const CHANGE_PROPERTY:String = "change_position";
		/**
		 * {color:uint}
		 * */
		public static const CHANGE_COLOR:String = "CHANGE_COLOR";
		/**
		 * {width:Number,height:Number}舞台大小改变
		 * */
		public static const STAGE_RESIZE:String = "STAGE_RESIZE";

		/*
		* {type:int} 1删除单个 2删除全部
		* */
		public static const DELETE_SHAPE:String = "DELETE_SHAPE";

		/*
		* {type:int} 1 X轴 2 Y轴 3 Z轴
		* */
		public static const ROTATION_ANIMATE:String="rotation_animate";
	}
}
