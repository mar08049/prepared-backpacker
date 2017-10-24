class User < ActiveRecord::Base
  has_many :gear
  has_secure_password

  def slug
    username.downcase.split.join("-")
  end

  def self.find_by_slug(slug)
    self.all.detect {|s| s.slug == slug}
  end
end
