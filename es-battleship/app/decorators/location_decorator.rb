class LocationDecorator < Draper::Decorator
  delegate_all
  decorates :location

  def as_json( * )
    metadata
  end

  def metadata
    location_hash =  {
        x: x,
        y: y ,
        isHit: self.is_hit?,
        ship_kind: ship.nil? ? "" : ship.kind.to_s
    }
  end
end