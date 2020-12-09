package vanGraph.algorithms.graphs;
import hxd.snd.openal.Emulator.Source;
class PathFinder {

    static public function dijkstraPath(graph : Graph, source : Vert, target : Vert, weighted : Bool = false, includeSource : Bool = false) : Array<Vert> {
        // checks to make sure that both source and target exist within the graph
        if(!graph.get_verts().exists(source.get_id()) || !graph.get_verts().exists(target.get_id())) {
            // replace with an error
            return null;
        }
        // if source and target are same return target without calculation
        if(source == target){
            return [target];
        }

        // distance traveled in edges
        var epsilon : Int = 0;       
        // distance traveled according to weight  
        var cost : Float = 0;

        // current node. Begins on source;
        var cur : Vert = null;

        var q : Map<Int, Vert> = new Map<Int, Vert>();
        var dist : Map<Int, Float> = new Map<Int, Float>();
        var prev : Map<Int, Vert> = new Map<Int, Vert>();
        
        dist[source.get_id()] = 0;
        prev[source.get_id()] = null;

        for(vert in graph.get_verts()) {
            if(vert.get_id() != source.get_id())
            {
                 if(weighted){
                   dist[vert.get_id()] = Math.POSITIVE_INFINITY; 
                   prev[vert.get_id()] = null;
                }
                else{
                    dist[vert.get_id()] = Math.POSITIVE_INFINITY;
                    prev[vert.get_id()] = null;
                }
            }
            else {
                trace(vert);
            }
            q[vert.get_id()] = vert;

        }

        var path : Array<Vert> = new Array<Vert>();
        var i = 0;

        trace(q.toString());

        while(q.keys().hasNext()) {
            if(cur == target) {
                break;
            }
            var min : Dynamic = findMinimumDistance(q.keys(), dist);
            trace(dist[min.minimum]);
            cur = q[min.id];
            q.remove(cur.get_id());

            for(v in cur.get_neighbors()) {
                var alt : Float;    
                if(weighted) {
                    alt = costToEnter(cur, v) + dist[cur.get_id()]; 
                    if(alt < dist[v.get_id()]) {
                        dist[v.get_id()] = alt;
                        prev[v.get_id()] = cur;
                    }
                }
                else {
                    alt = 1 + dist[cur.get_id()];
                    if(alt < dist[v.get_id()]) {
                        trace("alt" + Std.string(v.get_id()));
                        dist[v.get_id()] = alt; 
                        prev[v.get_id()] = cur;
                    }
                }
            } 

            if(i > 10) {
                break;
            }

            i++;
        }

        trace("exit");

        if(prev[target.get_id()] == null) {
            trace("not found");
            return null;
        }
        
        cur = target;

        while(prev[cur.get_id()] != null) {
            path.push(cur);
            cur = prev[cur.get_id()];
        }


        trace(path);

        if(includeSource){
            path.push(source);
        }

        path.reverse();

        return path;

    }

    static private function findMinimumDistance(verts_ids : Iterator<Int>,distances : Map<Int, Float>) : Dynamic  {
        
        var min = Math.POSITIVE_INFINITY;
        var minID = null;
        
        for(id in verts_ids) {
            if(distances[id] < min) {
                min = distances[id];
                minID = id;
            }
        }

        return {id : minID, minimum : min};
    }

    static private function costToEnter(source : Vert, target : Vert) : Float{
        return source.get_edgeWeight(target) + source.get_weight(); 
    }
} 