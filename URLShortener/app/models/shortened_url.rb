class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true
  #validates :long_url, presence: true, uniqueness: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"

  has_many :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: "Visit"

  has_many :visitors,
    through: :visits,
    source: :visitors

  def self.random_code
    short_url = nil
    loop do
      short_url = SecureRandom.urlsafe_base64(12)
      break unless ShortenedUrl.exists?(short_url: short_url)
    end

    short_url
  end

  def self.this_is_kinda_create!(user, long_url)
    #debugger
    short_url = ShortenedUrl.random_code

    ShortenedUrl.create!(user_id: user.id, long_url: long_url, short_url: short_url)
  end

  def num_clicks
    Visit.all.select { |v| v.shortened_url_id == self.id }.count
  end

  def num_uniques
    Visit.all.distinct.select { |v| v.shortened_url_id == self.id }.count
  end

  def num_recent(recent_in_mins)
    Visit.all.distinct.where(created_at: (Time.now - recent_in_mins * 60)..Time.now ).select { |v| v.shortened_url_id == self.id }.count
  end
end
