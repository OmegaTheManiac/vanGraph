package vanGraph.objects;

class Graph {
    private var rnd : hxd.Rand;
    private var verts(get, default) : Map<Int, Vert> = new Map<Int, Vert>();
    private var edges:Array<Dynamic> = new Array<Dynamic>();

    public function new(vert_list : Array<Vert>) {
        for(i in 0...vert_list.length){
            verts[i] = vert_list[i];
        }
        get_edges();
        // generate a random seed each day.
        //var rand_seed = rnd.random(Date.now().getUTCDay());
        // here the vert manager spawns a level lisf if it is null
    }

    public function get_verts() {
        return verts;
    }

    private function refresh(rand_seed) {
        //should run daily. resets the seed and thus levels
    }

    public function get_edges() {
        
        // find unique edges to draw
        if(edges.length == 0) {

            for(vert in this.verts)
            {
                vert.addNeighbors(this);
                for(neighbor in vert.get_neighbors()){
                    if(!edges.contains([vert.get_id(), neighbor.get_id()]) && !edges.contains([neighbor.get_id(), vert.get_id()])) {
                        edges.push([vert.get_id(),neighbor.get_id()]);
                    }
                }
            }
        }
        return edges;
    }
}