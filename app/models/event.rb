class Event < ActiveRecord::Base
  mount_uploader :event_image, EventImageUploader

  has_many :tickets, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  validates :name,       presence: true, length: { maximum: 50 }
  validates :place,      presence: true, length: { maximum: 100 }
  validates :content,    presence: true, length: { maximum: 2000 }
  validates :start_time, presence: true
  validates :end_time,   presence: true
  validate  :start_time_must_be_before_end_time

  default_scope -> { order(:start_time) }
  scope :will_open, -> { where(':now < end_time', now: Time.zone.now) }

  def self.ransackable_attributes(auth_object = nil)
    %w(name start_time)
  end

  def self.ransackable_association(auth_object = nil)
    []
  end

  def created_by?(user)
    return false unless user
    owner_id == user.id
  end

  private

    def start_time_must_be_before_end_time
      return unless start_time && end_time

      if start_time >= end_time
        errors.add :start_time, 'は終了時間よりも前に設定してください'
      end
    end
end
