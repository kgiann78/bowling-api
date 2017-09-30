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
  	frames.each do |frame|
  		puts "#{frame.number}@tries:#{frame.tries}, pins:#{frame.pins}, score:#{frame.score} is spare? #{isSpare(frame)} is strike? #{isStrike(frame)}"
  		if frame.tries > 0 && !isStrike(frame) && !isSpare(frame)
  			return normalFrame(frames, frame.number - 1, pins) #frame.id, pins)# 
  		elsif frame.tries > 0 && frame.number == 10 && (isStrike(frame) || isSpare(frame))
  			return bonusFrame(frames, pins) 
  		end
  	end
  	raise "No more rolls left"
  end

  def normalFrame(frames, normal_frame_index, pins)
  	@current_frame = frames[normal_frame_index] #Frame.find(normal_frame_index)#
    
  	if @current_frame
  	  puts "Current frame ##{@current_frame.number}"
  	  puts "Roll #{(@current_frame.tries%2) + 1}"

	  if (pins + @current_frame.pins) > 10 || pins < 0
	    raise "Illegal roll! Administrator should reset frame"
	    return
	  else
	  	@current_frame.pins += pins
	  end

	  # current frame scoring

	  if isStrike(@current_frame)
	  	@current_frame.score = 10
	  else
	  	@current_frame.score = @current_frame.pins

	  	if !isSpare(@current_frame)
	  	  @current_frame.tries -= 1
	  	end
	  end

	  # check previous frames for spare or strike
	  addScoreToPreviousFrames(frames, @current_frame, pins)

	  # gother player's score
      return calcPlayerScore(frames)
	else
		raise "No more rolls left" 
  	end
  end

  def bonusFrame(frames, pins)
  	puts "THIS IS ONLY BONUS FRAME"
  	bonus_frame_index = 9
  	frames[bonus_frame_index].tries = 0
  	frames[bonus_frame_index].score += pins

    # check previous frames for spare or strike
	addScoreToPreviousFrames(frames, frames[bonus_frame_index], pins)

  	return calcPlayerScore(frames)
  end

  def addScoreToPreviousFrames(frames, current_frame, pins)
  	previous_frames = getPreviousFrames(frames, current_frame)

	if previous_frames[:frame1]
		if isSpare(previous_frames[:frame1])
			if (current_frame.tries >= 1 && !isSpare(current_frame))
			  previous_frames[:frame1].score += pins
			end
		elsif isStrike(previous_frames[:frame1])
			previous_frames[:frame1].score += pins
		end
	end

	if previous_frames[:frame2]
		if isStrike(previous_frames[:frame2])
			previous_frames[:frame2].score += pins
		end
	end
  end


  def getPreviousFrames(frames, current_frame)
  	previous_frames = { :frame1 => nil, :frame2 => nil }

  	previous_frame_1_index = current_frame.number - 2
	previous_frame_2_index = current_frame.number - 3

	if previous_frame_2_index >= 0
	  previous_frames[:frame2] = frames[previous_frame_2_index]
	  previous_frames[:frame1] = frames[previous_frame_1_index]
	elsif previous_frame_1_index >= 0
	  previous_frames[:frame1] = frames[previous_frame_1_index]
	end
	return previous_frames
  end

  def calcPlayerScore(frames)
  	players_score = 0
	frames.each do |frame|
	  players_score += frame.score
	end
	return players_score  	
  end

  ###### SPARES AND STRIKES #######

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
