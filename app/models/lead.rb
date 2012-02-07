class Lead
  include Mongoid::Document
  include Mongoid::Timestamps

  field :assigned_to
  field :company_name
  field :source
  field :industry
  field :website
  field :status
  field :description
  
  #embeds_one :business_address, :as => :addressable
  
  references_one :contact, :as => :contactable
  referenced_in :campaign
  referenced_in :organisation, :inverse_of => :leads
  referenced_in :user, :inverse_of => :leads
  referenced_in :assignee, :class_name => "User", :foreign_key => :assigned_to, :inverse_of => :leads

  accepts_nested_attributes_for :contact

  validates :company_name, :source, :presence => true
  validates_associated :contact

  scope :for_campaign, lambda { |campaign| where('campaign_id = ?', campaign.id) }
  scope :created_by, lambda { |user| where('user_id = ?' , user.id) }
  scope :assigned_to, lambda { |user| where('assigned_to = ?' , user.id) }

  def name
    contact.full_name
  end

  def company
    "#{company_name}".strip
  end

  def email
    contact.email
  end
 
end