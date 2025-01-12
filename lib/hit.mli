open Point3
open Ray
open Vec3

type face_direction =
  | Front
  | Back

module Hit : sig
  type t

  val create : point:Point3.t -> normal:Vec3.t -> distance:float -> face:face_direction -> t
  val create_from_ray : point:Point3.t -> outward_normal:Vec3.t -> distance:float -> ray:Ray.t -> t

  val point : t -> Point3.t
  val normal : t -> Vec3.t
  val distance : t -> float
end
