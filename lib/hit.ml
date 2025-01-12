open Point3
open Ray
open Vec3

type face_direction =
  | Front
  | Back

module Hit = struct
  type t = {point: Point3.t; normal: Vec3.t; distance: float; face: face_direction }
  [@@deriving fields ~getters]

  let create ~point ~normal ~distance ~face = {point; normal; distance; face}

  let create_from_ray ~point ~outward_normal ~distance ~ray =
    let front_face = Vec3.dot (Ray.direction ray) outward_normal in
    let normal, face = match front_face < 0. with
      | true -> outward_normal, Front
      | false -> Vec3.(outward_normal * -1.), Back in
    create ~point ~normal ~distance ~face

end
