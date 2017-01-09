require_relative 'oystercard'
class Station

  def touch_in(oystercard)
    oystercard.in_journey = true
  end

  def touch_out(oystercard)
    oystercard.in_journey = false
  end

end
