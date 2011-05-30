class Rating < ActiveRecord::Base
  belongs_to :story

  validates_inclusion_of :rate, :in => [1, 2, 3, 4, 5],
    :message => "Complexity should be a value from 1 to 5"

end

