open Point3
open Vec3

module Ray = struct
  type t = {origin: Point3.t; direction: Vec3.t}

  let create origin direction = {origin; direction}
  let origin a = a.origin
  let direction a = a.direction
  let at a k = Point3.add a.origin (Vec3.scale a.direction k)
end [@@deriving sexp_of]
