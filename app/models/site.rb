class Site < ActiveRecord::Base
	def self.alphabetically
      self.order("location ASC")
  end
end
