# Exercise 5 Part 1 (Exception Handling)

class MentalState
  def initialize(status); end

  # true if the external service is online, otherwise false
  def auditable?
    audit!
  rescue RuntimeError
    false
  else
    true
  end

  def audit!
    # Could fail if external service is offline
    raise RuntimeError unless risky_external_request
  end

  def do_work
    audit! if auditable?
  end
end

# hard to tell what's being asked here, but
# I'm choosing not to throw an exception on the caller
# because this is already being gracefully handled inside the class
def audit_sanity(bedtime_mental_state)
  raise RuntimeError unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else
    MorningMentalState.new(:not_ok)
  end
end

audit_sanity(bedtime_mental_state)



# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)

class BedtimeMentalState < MentalState; end

class MorningMentalState < MentalState; end

def audit_sanity(bedtime_mental_state)
  return nil unless bedtime_mental_state.auditable?

  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else
    MorningMentalState.new(:not_ok)
  end
end

new_state = audit_sanity(bedtime_mental_state)
new_state.do_work


# Exercise 5 Part 3 (Wrapping APIs)

require 'candy_service'

# machine = CandyMachine.new
machine = CandyServiceWrapper.new
machine.prepare

if machine.ready?
  machine.make!
else
  puts 'sadness'
end

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
