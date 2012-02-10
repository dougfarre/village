class Shift < ActiveRecord::Base
belongs_to :slot
has_one :volunteer
end
