class Abduction < ActiveRecord::Base
  belongs_to :martian
  belongs_to :earthling
  validate :abduction_count_within_limit, :on => :create

  def abduction_count_within_limit
    if self.martian.abductions(:reload).count >= 3
      errors.add(:base, "Exceeded abduction limit")
    end
  end
end
