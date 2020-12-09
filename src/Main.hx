import h2d.Bitmap;
import js.html.Path2D;
import h3d.Vector;
import vanGraph.objects.Vert;
import vanGraph.objects.Graph;
import vanGraph.artists.Painter;
import vanGraph.artists.Sketcher;
import vanGraph.tools.BasicShape;

class Main extends hxd.App {
    var time_to_edge_completion : Float = 3;
    var time_elapsed : Float = 0;
    var ready = false;
    var graph : Graph; 
    var path : Array<Vert>;
    var sketcher : Sketcher; 
    var location : h3d.Vector;
    override function init() {
        sketcher = new Sketcher(s2d);
        location = new h3d.Vector(900,500,0,0);
        sketcher.sketchCurvedShape(BasicShape.Heart, 20, 100);
        sketcher.drawCurrentSketch(location,0xff0000); 
        sketcher.sketchCurvedShape(BasicShape.Heart, 19, 100);
        sketcher.drawCurrentSketch(location,0x00ff00); 
        sketcher.sketchCurvedShape(BasicShape.Heart, 18, 100);       
        sketcher.drawCurrentSketch(location,0x0000ff); 
        sketcher.sketchCurvedShape(BasicShape.Heart, 17, 100);
        sketcher.drawCurrentSketch(location,0xff0000); 
        sketcher.sketchCurvedShape(BasicShape.Heart, 16, 100);
        sketcher.drawCurrentSketch(location,0x00ff00); 
        sketcher.sketchCurvedShape(BasicShape.Heart, 15, 100);       
        sketcher.drawCurrentSketch(location,0x0000ff); 
        sketcher.sketchCurvedShape(BasicShape.Heart, 14, 100);
        sketcher.drawCurrentSketch(location,0xff0000); 
        sketcher.sketchCurvedShape(BasicShape.Heart, 13, 100);
        sketcher.drawCurrentSketch(location,0x00ff00); 
        /* 
        var dummy_vert_list = new Array<Vert>();
        dummy_vert_list.push(new Vert(0,[1,2],0, new h3d.Vector(0,0,0,0)));
        var level = new Level(0, 0, dummy_vert_list);

        this.graph = new Graph(level);

        Painter.get_instance().set_scene(s2d);
        path = PathFinder.dijkstraPath(this.graph, this.graph.get_verts()[0], this.graph.get_verts()[10], false, true);
        Painter.get_instance().drawEdges(graph); 
        Painter.get_instance().drawVerts(this.graph);

        */
        hxd.Res.initEmbed();
        var tile = hxd.Res.wendy.toTile();
        tile = tile.center();
        var bmp : Bitmap = new Bitmap(tile, s2d);
        bmp.x = 900;
        bmp.y = 525;
    }

    override function update(dt:Float) {
        /*        
        if(time_elapsed < time_to_edge_completion && path.length > 1){
            Painter.get_instance().drawPathIncrementally(this.graph, path, time_elapsed, time_to_edge_completion);
        }
        else {
            time_elapsed = 0;
            path.remove(path[0]);
        }
        */
        var tim = Std.int(time_elapsed);
        if(tim % 2 == 0) {
            for(i in 0...8) {
                if(i%2 == 0) {    
                    sketcher.drawSketchByID(i,location,0xff0000); 
                }
                else {
                    sketcher.drawSketchByID(i,location,0xff00ff);
                }
            }
        }
        if(tim % 2 != 0) {
            for(i in 0...8) {
                 if(i%2 == 0) {    
                    sketcher.drawSketchByID(i,location,0xff00ff); 
                }
                else {
                    sketcher.drawSketchByID(i,location,0xff0000);
                }              
            }
        }

        time_elapsed += dt;
    }

    static function main() {
        new Main();
    }
    
}