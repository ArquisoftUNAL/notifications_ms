class Notification
  include Mongoid::Document
  #include Mongoid::Timestamps

  field :noti_title, type: String
  field :noti_body, type: String
  field :noti_init_date, type: DateTime
  field :noti_type, type: String    
  field :noti_active, type: Boolean
  field :noti_should_email, type: Boolean
  field :noti_email, type: String
  
  field :usr_id, type: String
  field :page, type: Integer
  field :items_by_page, type: Integer

  validates :noti_title, uniqueness: false, presence: true
  validates :noti_body, uniqueness: false, presence: false
  validates :noti_init_date, uniqueness: false, presence: true
  validates :noti_type, uniqueness: false, presence: true
  validates :noti_active, uniqueness: false, presence: true
  validates :noti_should_email, uniqueness: false, presence: true
  validates :noti_email, uniqueness: false, presence: true

  validates :usr_id, uniqueness: false, presence: true
  validates :page, uniqueness: false, presence: false
  validates :items_by_page, uniqueness: false, presence: false
end
