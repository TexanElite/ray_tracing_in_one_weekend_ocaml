open Hit
open Ray

module Hittables : sig
  type hittable_callback = ray:Ray.t -> ray_tmin:float -> ray_tmax:float -> Hit.t option
  type t

  val empty : t
  val add_exn: t -> hittable_callback -> t
  val hit_any : t -> ray:Ray.t -> ray_tmin:float -> ray_tmax:float -> Hit.t option
end
