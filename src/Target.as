package {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    public class Target extends Sprite {
        public static const STRIKE:String = "strike";

        private var _speed:Number;
        private var _direction:Number;

        public function Target() {
            super();
            _speed = Math.random();
            _direction = 2 * Math.PI * Math.random();
            addEventListener(Event.ENTER_FRAME, enterFrameHandler);
            addEventListener(MouseEvent.MOUSE_DOWN, clickHandler)
            draw();
        }

        private function draw():void {
            graphics.clear();
            graphics.beginFill(0xAA2222);
            graphics.drawCircle(0, 0, 10);
        }

        private function bound(value:Number, bottomBound:Number, topBound:Number):Number {
            if (value <= bottomBound) {
                return bottomBound;
            }

            if (value >= topBound) {
                return topBound;
            }

            return value;
        }

        private function enterFrameHandler(event:Event):void {
            var newX:Number = x + _speed * Math.cos(_direction);
            x = bound(newX, 10, parent.width - 10);

            var newY:Number = y + _speed * Math.sin(_direction);
            y = bound(newY, 10, parent.height - 10);

            var newSpeed:Number = _speed + Math.random() - 0.5;
            _speed = bound(newSpeed, 0, 10);

            _direction += Math.random();
        }

        private function clickHandler(event:MouseEvent):void {
            removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
            removeEventListener(MouseEvent.MOUSE_DOWN, clickHandler);
            dispatchEvent(new Event(STRIKE));
        }

    }
}

