class Notification
  include Mongoid::Document
  #include Mongoid::Timestamps

  field :not_id, type: String
  field :not_init_date, type: DateTime
  field :not_description, type: String
  field :not_active, type: Boolean

  validates :not_id, uniqueness: true, presence: true
  validates :not_init_date, uniqueness: false, presence: true
  validates :not_description, uniqueness: false, presence: false
  validates :not_active, uniqueness: false, presence: true
end
