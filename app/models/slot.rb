class Slot < ActiveRecord::Base
has_many :shifts, :dependent => :destroy
belongs_to :village
end
