package printing
{
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	
	import mx.controls.CheckBox;
	import mx.controls.List;
	import mx.controls.listClasses.IListItemRenderer;
	
	/** 
	 *  List that uses checkboxes for multiple selection
	 */
	public class CheckBoxList extends List
	{
		public function CheckBoxList()
		{
			super();
		}
		
		
		// fake all mouse interaction as if it had the ctrl key down
		override protected function selectItem(item:IListItemRenderer,
											   shiftKey:Boolean, ctrlKey:Boolean,
											   transition:Boolean = true):Boolean
		{
			return super.selectItem(item, false, true, transition);
		}
		
		
		/**
		 *  @private
		 
		override public function set selectedIndices(indices:Array):void
		{
			// //trace("queueing indices");
			if (!collection || collection.length == 0)
			{
				_selectedIndices = indices;
				bSelectedIndicesChanged = true;
				bSelectionChanged = true;
				
				invalidateDisplayList();
				return;
			}
			
			commitSelectedIndices(indices);
		}*/

		
		// turn off selection indicator
		override protected function drawSelectionIndicator(
			indicator:Sprite, x:Number, y:Number,
			width:Number, height:Number, color:uint,
			itemRenderer:IListItemRenderer):void
		{
		}
		
		// whenever we draw the renderer, make sure we re-eval the checked state
		override protected function drawItem(item:IListItemRenderer,
											 selected:Boolean = false,
											 highlighted:Boolean = false,
											 caret:Boolean = false,
											 transition:Boolean = false):void
		{
			if(item)
			{
				CheckBox(item).invalidateProperties();
				super.drawItem(item, selected, highlighted, caret, transition);
			}
		}
		
		// fake all keyboard interaction as if it had the ctrl key down
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			// this is technically illegal, but works
			event.ctrlKey = true;
			event.shiftKey = false;
			super.keyDownHandler(event);
		}
	}
	
}