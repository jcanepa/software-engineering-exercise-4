# Exercise 5 Part 1 (Exception Handling)

class MentalState
  def initialize(status); end

  # true if the external service is online, otherwise false
  def auditable?
    begin
      audit!
    rescue RuntimeError
      false
    else
      true
    end
  end

  def audit!
    # Could fail if external service is offline
    raise RuntimeError unless risky_external_request()
  end

  def do_work
    # Amazing stuff...
  end
end

# I'm choosing not to throw an exception within this caller
# because this is already being gracefully handled inside the class
def audit_sanity(bedtime_mental_state)
  bedtime_mental_state.auditable?
    ? MorningMentalState.new(:ok)
    : MorningMentalState.new(:not_ok)
end

audit_sanity(bedtime_mental_state)



# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)

class BedtimeMentalState < MentalState; end

class MorningMentalState < MentalState; end

class NullMentalState < MentalState
  def initialize(status); end
  def auditable?; end
  def audit!; end
  def do_work; end
end

def audit_sanity(bedtime_mental_state)
  NullMentalState.new unless bedtime_mental_state.auditable?

  bedtime_mental_state.auditable?
    ? MorningMentalState.new(:ok)
    : MorningMentalState.new(:not_ok)
end

audit_sanity(
  bedtime_mental_state).do_work


# Exercise 5 Part 3 (Wrapping APIs)

# main.rb
require 'candy_service_wrapper'

# machine = CandyMachine.new
machine = CandyServiceWrapper.new
machine.prepare

if machine.ready?
  machine.make!
else
  puts 'sadness'
end

# candy_service_wrapper.rb
class CandyServiceWrapper
  @machine

  def initialize:
    @machine = CandyMachine.new
  end

  def prepare:
    @machine.prepare
  end

  def ready?
    return @machine.ready?
  end

  def make!
    return @machine.make!
  end
end
