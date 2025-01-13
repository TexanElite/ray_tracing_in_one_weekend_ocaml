open Core
open Hit
open Ray

module Interval = Interval_lib.Interval

module Hittables = struct
  type hittable_callback = ray:Ray.t -> ray_t:Interval.Float.t -> Hit.t option
  type t = {
    entries: (int, hittable_callback, Int.comparator_witness) Map.t;
    counter: int
  } [@@deriving fields ~getters]

  let empty = {entries = Int.Map.empty; counter = 0}

  let add_exn t data = let entries = Map.add_exn (entries t) ~key:(counter t) ~data in
    {entries; counter = counter t + 1}

  let hit_any t ~ray ~ray_t =
    entries t |> Map.data |>
    List.fold ~f:(
      fun (ray_t, best_hit) hittable_callback -> match hittable_callback ~ray ~ray_t with
        | Some hit -> Interval.create (Interval.lbound_exn ray_t) (Hit.distance hit), Some hit
        | None -> (ray_t, best_hit)
    ) ~init:(ray_t, None) |> snd
end
