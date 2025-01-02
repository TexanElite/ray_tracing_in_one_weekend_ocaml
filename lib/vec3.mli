module Vec3 : sig
  type t [@@deriving sexp_of]

  val create : float -> float -> float -> t

  val x : t -> float
  val y : t -> float
  val z : t -> float

  val add : t -> t -> t
  val sub : t -> t -> t
  val scale : t -> float -> t
  val scale_inv : t -> float -> t
  val neg : t -> t
  val dot : t -> t -> float
  val mag_squared : t -> float
  val mag : t -> float
  val unit : t -> t

  val (+) : t -> t -> t
  val (-) : t -> t -> t
  val ( * ) : t -> float -> t
  val (/) : t -> float -> t
  val ( *. ) : t -> t -> float
end

