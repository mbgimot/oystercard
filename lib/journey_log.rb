require_relative "journey"

class JourneyLog
  attr_reader :current_journey

  def initialize(journey_class, oystercard)
    @current_journey = nil
    @oystercard = oystercard
    @journey_class = journey_class
    @journeys = []
  end


  def start_journey(entry_station)
    multiple_touch_in
    @current_journey = @journey_class.new
    @current_journey.start(entry_station)
  end

  def finish_journey(exit_station)
    multiple_touch_out
    @current_journey.finish(exit_station)
    save_current_journey
    @current_journey = nil
  end

  def journeys
    @journeys.dup
  end

private

  def multiple_touch_in
    save_current_journey if @current_journey
  end

  def save_current_journey
    @journeys << @current_journey
    @oystercard.deduct(@current_journey.fare)
  end


  def multiple_touch_out
    if @current_journey.nil?
      @current_journey = @journey_class.new
    end
  end

  def currentjourney
    @current_journey ||= @journey_class.new
  end
end
