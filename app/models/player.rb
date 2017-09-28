class Player < ApplicationRecord
  belongs_to :game

  # model association
  has_many :frames, dependent: :destroy, autosave: true

  after_create :init_frames

  def init_frames
  	10.times { 
  		|i| Frame.create!(number: i + 1, score: 0, tries: 2, pins: 0, player_id: id ) 
  		puts "You have initialized frame number #{i}!"
  	}
    
  end

  def roll(pins, frames)
  	@current_frame = nil

  	frames.each do |frame|
  		puts "#{frame.number}@tries:#{frame.tries}, pins:#{frame.pins}, score:#{frame.score} is spare? #{isSpare(frame)} is strike? #{isStrike(frame)}"
  		if frame.score == 0 && frame.tries > 0
  			@current_frame = frame
  			break
  		end
  	end

  	if @current_frame
  	  puts "Current frame ##{@current_frame.number}"
  	  puts "Roll #{(@current_frame.tries%2) + 1}"

      if @current_frame.number == 1
  	  	firstBall(@current_frame, pins)
  	  elsif @current_frame.number == 10
  	  else
  	  end
  	end
  end

###### FIRST BALL #######
  def firstBall(current_frame, pins)
  	if (pins + current_frame.pins) > 10
  		raise "Illegal roll! Administrator should reset frame"
  		return
  	end

    if (pins + current_frame.pins) == 10 && current_frame.tries == 2 #strike
  	  current_frame.score = 10
	elsif (pins + current_frame.pins) == 10 && current_frame.tries == 1 #spare
  	  current_frame.score = 10
	else
  	  current_frame.pins = current_frame.pins + pins
  	  if current_frame.tries == 1
  	  	current_frame.score = current_frame.pins
  	  end
  	  current_frame.tries -= 1
  	end
  end


####### SPARE & STRIKE #####
  def isSpare(frame)
  	return frame.tries == 1 && frame.pins == 10
  end

  def isStrike(frame)
  	return frame.tries == 2 && frame.pins == 10  	
  end

  def zeroizeAll(frames)
  	frames.each do |frame|
  		puts "Zeroize frame #{frame.number}"
  		frame.score = 0
  		frame.tries = 2
  		frame.pins = 0
  		puts "#{frame.number}@tries:#{frame.tries}, pins:#{frame.pins}, score:#{frame.score} is spare? #{isSpare(frame)} is strike? #{isStrike(frame)}"
  	end
  end

  def zeroize(frame)
  	puts "Zeroize frame #{frame.number}"
  	frame.score = 0
  		frame.tries = 2
  		frame.pins = 0
  		puts "#{frame.number}@tries:#{frame.tries}, pins:#{frame.pins}, score:#{frame.score} is spare? #{isSpare(frame)} is strike? #{isStrike(frame)}"
  end

  # validations
  validates_presence_of :name, :score
end
