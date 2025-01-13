open Core
open Hit
open Ray
include Hittable_intf

module Make (T : Make_arg) : S with type t := T.t = struct
  include T
  let hit hittable ~ray ~ray_t =
    let open Option.Let_syntax in
    let%map ray_intersection = T.ray_intersection hittable ~ray ~ray_t in
    let point = Ray.at ray ray_intersection in
    Hit.create_from_ray ~outward_normal:(T.outward_normal hittable ~point) ~point ~distance:ray_intersection ~ray
end
