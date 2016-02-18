class LocationDecorator < Draper::Decorator
  delegate_all
  decorates :location

  def as_json( * )
    metadata
  end

  def metadata
    location_hash =  {
        state: state,
        x: x,
        y: y ,
        ship_kind: ship.kind.to_s
    }
  end
end