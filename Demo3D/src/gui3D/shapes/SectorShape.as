/**
 * Created by Administrator on 2015/8/19.
 */
package gui3D.shapes
{
	import flash.display.Sprite;

	public class SectorShape extends Sprite
	{
		private var _fillColor:uint;
		private var _lineColor:uint;
		private var _thickiness:Number;
		private var _lineAlpha:Number;
		private var _fillAlpha:Number;
		private var _currentAngle:Number = 0;

		public function SectorShape(fillColor:uint = 0, fillAlpha:Number = 0.5, thickness:Number = 1.0, lineColor:uint = 0, lineAlpha:Number = 1.0)
		{
			_fillColor = fillColor;
			_fillAlpha = fillAlpha;
			_thickiness = thickness;
			_lineColor = lineColor;
			_lineAlpha = lineAlpha;
		}

		/*
		 * x,y坐标位置
		 * r 内半径
		 * R 外半径
		 * angle 角度
		 * startA 开始角度
		 * */
		public function drawSector(x:Number, y:Number, r:Number, R:Number, angle:Number, startA:Number):void
		{
			_currentAngle = angle;
			this.graphics.clear();
			this.graphics.lineStyle(_thickiness, _lineColor, _lineAlpha, true);
			this.graphics.beginFill(_fillColor, _fillAlpha);

			if (Math.abs(angle) > 360)
			{
				angle = 360;
			}
			var n:Number = Math.ceil(Math.abs(angle) / 45);
			var angleA:Number = angle / n;
			angleA = angleA * Math.PI / 180;
			startA = startA * Math.PI / 180;
			var startB:Number = startA;
			//
			this.graphics.moveTo(x + r * Math.cos(startA), y + r * Math.sin(startA));
			this.graphics.lineTo(x + R * Math.cos(startA), y + R * Math.sin(startA));
			//
			for (var i:int = 1; i <= n; i++)
			{
				startA += angleA;
				var angleMid1:Number = startA - angleA / 2;
				var bx:Number = x + R / Math.cos(angleA / 2) * Math.cos(angleMid1);
				var by:Number = y + R / Math.cos(angleA / 2) * Math.sin(angleMid1);
				var cx:Number = x + R * Math.cos(startA);
				var cy:Number = y + R * Math.sin(startA);
				this.graphics.curveTo(bx, by, cx, cy);
			}
			//
			this.graphics.lineTo(x + r * Math.cos(startA), y + r * Math.sin(startA));
			//
			for (var j:int = n; j >= 1; j--)
			{
				startA -= angleA;
				var angleMid2:Number = startA + angleA / 2;
				var bx2:Number = x + r / Math.cos(angleA / 2) * Math.cos(angleMid2);
				var by2:Number = y + r / Math.cos(angleA / 2) * Math.sin(angleMid2);
				var cx2:Number = x + r * Math.cos(startA);
				var cy2:Number = y + r * Math.sin(startA);
				this.graphics.curveTo(bx2, by2, cx2, cy2);
			}
			//
			this.graphics.lineTo(x + r * Math.cos(startB), y + r * Math.sin(startB));
			this.graphics.endFill();
		}

		public function get currentAngle():Number
		{
			return _currentAngle;
		}

		public function hide():void
		{
			this.visible = false;
		}

		public function show():void
		{
			this.visible = true;
		}
	}
}
