# PHASE 2
def convert_to_int(str)
    Integer(str)
  rescue ArgumentError
    nil
end

# PHASE 3
FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee" 
    raise CoffeeError.new "I'll let you try again because I really like coffee"
  else
    raise StandardError 
  end 
end

def feed_me_a_fruit
    puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp

    reaction(maybe_fruit)
  rescue CoffeeError => e
    puts "#{e.message}"
    retry
  rescue StandardError => e
    puts "I don't like #{maybe_fruit}!"
  end

end 

class CoffeeError < StandardError
end

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    if yrs_known.class != Integer
      raise TypeError.new "Years known has to be an Integer"
    elsif yrs_known < 5
      raise ArgumentError.new "We have to know each other for more than 5 years to be BFFs"
    else
      @yrs_known = yrs_known
    end
    if name.class != String || fav_pastime.class != String
      raise TypeError.new "You need to enter a String for this argument"
    elsif name.length <= 0 || fav_pastime.length <= 0
      raise ArgumentError.new "You have to enter your name and favourite pastime."
    else
      @name = name
      @fav_pastime = fav_pastime
    end
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


