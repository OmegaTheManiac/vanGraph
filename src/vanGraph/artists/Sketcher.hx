package vanGraph.artists;
import h3d.Vector;
import h2d.Scene;
import hxd.fmt.spine.Data.SkinnedVertice;
import vanGraph.tools.BasicShape;
import vanGraph.objects.Sketch;
class Sketcher extends Artist {

    private var currentSketch : Sketch;
    private var sketchDict : Map<Int,Sketch> = new Map<Int,Sketch>();
    private var nextSketchID : Int = 0;

    // create some form of enum for basic shapes
    public function sketchCurvedShape(shape : BasicShape, radius : Int, resolution : Int) : Sketch {
        var points = new Array<h3d.Vector>();
        var tau = Std.int((Math.PI * 2 )* resolution);
        var x : Float = 0;
        var y : Float = 0;

        if (shape == BasicShape.Circle) {

            for(a in 0...tau) {
                var r = radius;
                x = r * Math.cos(a);
                y = r * Math.sin(a);
         
                points.push(new h3d.Vector(x,y,0,0));
            }
        }
        else if (shape == BasicShape.Heart) {
            for (a in 0...tau) {
                var a2 = a * 0.01;
                var r = radius;
                x = r * 16 * Math.pow(Math.sin(a2), 3);
                y = -r * (13 * Math.cos(a2) - 5*Math.cos(2*a2) - 2*Math.cos(3 * a2) - Math.cos(4*a2));
                points.push(new h3d.Vector(x,y,0,0));
            }
        }
        
        this.currentSketch =  new Sketch(points);
        this.sketchDict[nextSketchID] = this.currentSketch;
        this.nextSketchID = this.nextSketchID + 1;
        return currentSketch;
    }

    public function drawCurrentSketch(location : h3d.Vector, color : Int) {
        var customGraphics = new h2d.Graphics(this.s2d);
        //customGraphics.beginFill(color);
        customGraphics.lineStyle(10, color);
       
        var points = this.currentSketch.points;

        customGraphics.moveTo(location.x + points[0].x, location.y + points[0].y);

        for(i in 1...points.length) {
            customGraphics.lineTo(points[i].x + location.x,points[i].y + location.y);
        }
        
        //customGraphics.endFill();            


    };

    public function drawSketchByID(id : Int, location : h3d.Vector, color : Int) {
        var customGraphics = new h2d.Graphics(this.s2d);
        //customGraphics.beginFill(color);
        customGraphics.lineStyle(10, color);
       
        var points = this.sketchDict[id].points;

        customGraphics.moveTo(location.x + points[0].x, location.y + points[0].y);

        for(i in 1...points.length) {
            customGraphics.lineTo(points[i].x + location.x,points[i].y + location.y);
        }
        
        //customGraphics.endFill();            


    };
}