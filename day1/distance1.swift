func distance(ax: Int, ay: Int,
            bx: Int, by Int) -> Float {
                //
                let dx = Float(ax-bx)
                let dy = Float(ay-by)
                return sqrt(dx*dx + dy*dy)
            }

            distance(ax:10, ay:10, bx:15, by:15)