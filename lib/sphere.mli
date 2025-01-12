open Point3

module Sphere : sig
  include Hittable.S

  val center : t -> Point3.t
  val radius : t -> float
  val create : center:Point3.t -> radius:float -> t
end
