package {
    import flash.display.Sprite;

    public class Game extends Sprite {
        public function Game() {
            super();
        }

        public function setSize(w:int, h:int):void {
            graphics.clear();
            graphics.beginFill(0x8888BB);
            graphics.drawRect(0, 0, w, h);
        }
    }
}

