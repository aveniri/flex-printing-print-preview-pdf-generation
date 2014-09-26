package printing
{
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import mx.controls.CheckBox;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.listClasses.AdvancedListBase;
	import mx.controls.listClasses.ListBase;
	
	/** 
	 *  The Renderer.
	 */
	public class CheckBoxRenderer extends CheckBox
	{
		
		public function CheckBoxRenderer()
		{
			focusEnabled = false;
			
			callLater( function():void{
				owner.addEventListener("refreshChBoxProperties", function():void{
					invalidateProperties();
				});
			});
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			invalidateProperties();
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			if (owner is AdvancedListBase)
				selected = AdvancedListBase(owner).isItemSelected(data);
			else if (owner is ListBase)
				selected = ListBase(owner).isItemSelected(data);
		}
		
		/* eat keyboard events, the underlying list will handle them */
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
		}
		
		/* eat keyboard events, the underlying list will handle them */
		override protected function keyUpHandler(event:KeyboardEvent):void
		{
		}
		
		/* eat mouse events, the underlying list will handle them */
		override protected function clickHandler(event:MouseEvent):void
		{			
		}
				
		/* center the checkbox if we're in a datagrid */
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
			
			if (listData is DataGridListData || listData is AdvancedDataGridListData)
			{
				var n:int = numChildren;
				for (var i:int = 0; i < n; i++)
				{
					var c:DisplayObject = getChildAt(i);
					if (!(c is TextField))
					{
						c.x = int((w - c.width) / 2);
						c.y = int((h - c.height) / 2);
					}
				}
			}
		}
		
	}
	
}