package {
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class Main extends Sprite {
        private var _game:Game;

        public function Main() {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            stage.addEventListener(Event.RESIZE, resizeHandler);

            init();
        }

        private function init():void {
            _game = new Game();
            _game.setSize(stage.stageWidth, stage.stageHeight);
            _game.addEventListener(MouseEvent.MOUSE_DOWN, clickHandler);
            addChild(_game);

            for (var i:int = 0; i < 10; i++) {
                createTarget(
                        (0.5 + Math.random()) * _game.width / 2,
                        (0.5 + Math.random()) * _game.height / 2
                );
            }
        }

        private function win():void {
            var tf:TextField = new TextField();
            tf.autoSize = TextFieldAutoSize.LEFT;
            tf.defaultTextFormat = new TextFormat(null, 25);
            tf.text = "CONGRATULATIONS!!!";
            tf.x = (width + tf.width) / 2;
            tf.y = (height + tf.height) / 2;
            addChild(tf);

            _game.removeEventListener(MouseEvent.MOUSE_DOWN, clickHandler);
        }

        private function clickHandler(event:MouseEvent):void {
            createTarget(event.stageX, event.stageY);
        }

        private function createTarget(x:Number, y:Number):void {
            var target:Target = new Target();
            target.x = x;
            target.y = y;
            target.addEventListener(Target.STRIKE, strikeHandler);
            _game.addChild(target);
        }

        private function strikeHandler(event:Event):void {
            var target:Target = Target(event.target);
            target.removeEventListener(Target.STRIKE, strikeHandler);
            _game.removeChild(target);

            if (_game.numChildren == 0) {
                win();
            }
        }

        private function resizeHandler(event:Event):void {
            _game.setSize(stage.stageWidth, stage.stageHeight);
        }
    }
}

