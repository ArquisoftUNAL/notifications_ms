class Reminder
  include Mongoid::Document
  include Mongoid::Timestamps
  field :rem_init_date, type: String
  field :rem_description, type: String
  field :rem_active, type: Boolean
end
