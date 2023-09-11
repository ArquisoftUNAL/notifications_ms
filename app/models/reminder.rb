class Reminder
  include Mongoid::Document
  #include Mongoid::Timestamps

  field :rem_id, type: String
  field :rem_init_date, type: DateTime
  field :rem_description, type: String
  field :rem_active, type: Boolean

  validates :rem_id, uniqueness: true, presence: true
  validates :rem_init_date, uniqueness: false, presence: true
  validates :rem_description, uniqueness: false, presence: false
  validates :rem_active, uniqueness: false, presence: true
end
