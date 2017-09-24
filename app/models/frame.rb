class Frame < ApplicationRecord
  belongs_to :player

  @pins = 10
  @spare = false
  @strike = false
  @score = 0

  after_initialize do |frame|
  	if frame.number < 10
  		frame.tries = 2
  	else
  		frame.tries = 3
  	end
  	frame.pins = 10
    puts "You have initialized an object!"
  end

  # validations
  validates_presence_of :number

  def self.isSpare
  	return @spare
  end

  def self.isStrike
  	return @strike
  end

  def self.roll(dropped_pins, frame)
  	pins = frame.pins
  	tries = frame.tries
  	score = frame.score

  	if dropped_pins > 10 || dropped_pins < 0 || (pins + dropped_pins > 10) || tries == 0
  		return { :tries => tries, :score => score }
  	else
  		@pins = @pins - dropped_pins

  		if @pins == 0
  			if @tries == 2
  				@strike = true
  			elsif @tries == 1
  				@spare = true
  			end
  		else
  			@tries = @tries - 1
  			@score = @score + dropped_pins
  			if @tries == 0
  			  score = @score
  			end
  		end
  		return { :tries => tries, :score => score }
  	end
  end
end
