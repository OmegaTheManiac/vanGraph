package vanGraph.artists;
import h2d.Graphics;
import h2d.Scene;
import vanGraph.objects.Vert;
import vanGraph.objects.Graph;

class Painter {
    static private var instance(get, default) : Painter;
    private var s2d : h2d.Scene;

    private function new() {
    }

    static public function get_instance() : Painter {
        if(instance == null){
            instance = new Painter();
        }
        return instance;
    }

    public function set_scene(s2d : Scene) : Void {
        this.s2d = s2d;
    }

    public function drawVert(vert : Vert) : Void {
        //specify a color we want to draw with
        var customGraphics = new h2d.Graphics(this.s2d);
        customGraphics.beginFill(vert.get_initColor());
        //customGraphics.drawCircle(position.x, position.y, 25);
        customGraphics.drawCircle(vert.get_position().x, vert.get_position().y, 32);
        //End our fill
        customGraphics.endFill();
    }

    public function draw_edge_to_vert(source : Vert, target : Vert, color : Int = 0xffffff) : Void {
        var customGraphics = new h2d.Graphics(this.s2d);
        customGraphics.beginFill(color);
        customGraphics.lineStyle(10, color);
        customGraphics.moveTo(source.get_position().x, source.get_position().y);
        customGraphics.lineTo(target.get_position().x, target.get_position().y);
        customGraphics.endFill();            

    }

    public function draw_edge(source : Vert, target : h3d.Vector, color : Int = 0xffffff) : Void {
        var customGraphics = new h2d.Graphics(this.s2d);
        customGraphics.beginFill(color);
        customGraphics.lineStyle(10, color);
        customGraphics.moveTo(source.get_position().x, source.get_position().y);
        customGraphics.lineTo(target.x, target.y);
        customGraphics.endFill();            

    }

    public function drawVerts(graph : Graph) {
        for(vert in graph.get_verts()) {
            drawVert(vert);
        }
    }

    public function drawEdges(graph : Graph, color : Int = 0xffffff) {
        
        var vert_map = graph.get_verts();
       // draw edges

        for(edge in graph.get_edges()) {
            draw_edge_to_vert(vert_map[edge[0]],vert_map[edge[1]]);
    
        }

        // redraw verts to be on top of edges.
        drawVerts(graph);
    }

    public function drawEdges_incrementally(graph : Graph, time_elapsed : Float, time_till_complete : Float) {
        var vert_map = graph.get_verts();
        // draw edges
         var edges = graph.get_edges();
        
         trace(edges);

         for(edge in edges) {
             var source : Vert = vert_map[edge[0]];
             var target : Vert = vert_map[edge[1]];
             var lerp_x : Float = (target.get_position().x - source.get_position().x) * (time_elapsed/time_till_complete); 
             var lerp_y : Float = (target.get_position().y - source.get_position().y) * (time_elapsed/time_till_complete);
             var target_x : Float = source.get_position().x + lerp_x;  
             var target_y : Float = source.get_position().y + lerp_y;
            
             draw_edge(source, new h3d.Vector(target_x, target_y, 0, 0)); 
         }
        drawVerts(graph); 
    }

   public function drawPathIncrementally(graph : Graph, path : Array<Vert>, time_elapsed : Float, time_till_complete : Float) : Bool {
        
        if(path.length <= 1) {
            return true;
        }

        var source = path[0];
        var target = path[1];

        var lerp_x : Float = (target.get_position().x - source.get_position().x) * (time_elapsed/time_till_complete); 
        var lerp_y : Float = (target.get_position().y - source.get_position().y) * (time_elapsed/time_till_complete);
        var target_x : Float = source.get_position().x + lerp_x;  
        var target_y : Float = source.get_position().y + lerp_y;
       
        draw_edge(source, new h3d.Vector(target_x, target_y, 0, 0), source.get_initColor());
        trace("this ran"); 
        drawVerts(graph);
        
        return false;
    }

}