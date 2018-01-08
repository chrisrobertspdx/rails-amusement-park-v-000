class User < ActiveRecord::Base
  #validate happiness and nausea are 1-5
  has_secure_password
  #validates :password, confirmation: true
  has_many :rides
  has_many :attractions, through: :rides
  def mood
      if self.happiness > self.nausea 
        "happy" 
      elsif self.happiness < self.nausea
        "sad"
      else
        "meh"
      end
  end
end
