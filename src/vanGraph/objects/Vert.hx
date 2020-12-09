package vanGraph.objects;
import h2d.Scene;
import hxd.Rand;
import vanGraph.objects.Graph;

class Vert extends h2d.Drawable {
    private var id(get, default) : Int;
    private var neighborIDs : Array<Int>;
    private var neighbors : Array<Vert> = new Array<Vert>();
    private var initColor(get, default) : Int;
    private var position(get, default) : h3d.Vector; 
    private var weight(get, default) : Float;
    private var edgeWeights(get, default) : Array<Float>; 
    public function new(id : Int, neighborIDs : Array<Int>, initColor : Int, position : h3d.Vector) {
        super(parent);
        this.id = id;
        this.initColor = initColor;
        this.neighborIDs = neighborIDs;
        this.position = position;
    }

    public function addNeighbors(graph : Graph) {
        for(neighborID in neighborIDs) {
            neighbors.push(graph.get_verts()[neighborID]);
        }
    }

    public function get_id() {
        return id;
    }

    public function get_neighbors() {
        return neighbors;
    }
    public function get_weight() {
        return weight;
    }
    public function get_edgeWeights() {
        return edgeWeights;
    }
    public function get_edgeWeight(neighbor : Vert){
        return edgeWeights[neighborIDs.indexOf(neighbor.get_id())];
    }

    public function get_initColor() {
        return initColor;
    }
    
    public function get_position() {
        return position;
    }

}