package vanGraph.objects;
import h3d.Vector;
// maybe mark extern
class Sketch {


    public var points : Array<h3d.Vector> = new Array<h3d.Vector>();
    public var scale : Float = 1;


    public function new(points : Array<h3d.Vector>) {
       this.points = points;
    }

    

}
