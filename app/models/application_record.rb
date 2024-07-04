class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.my_puts(message)
    puts("\e[32m**** #{message} ****\e[0m")
  end
end
