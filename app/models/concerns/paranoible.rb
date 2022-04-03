# My little Paranoia
module Paranoible
  extend ActiveSupport::Concern

  def self.included(klass)
    klass.instance_eval do
      default_scope -> { where(deleted_at: nil) }
      scope :with_deleted, -> { unscoped }
    end
  end

  def destroy(force: false)
    return super() if force

    update_column(:deleted_at, Time.current)
  end

  def restore
    update_column(:deleted_at, nil)
  end

  def deleted?
    deleted_at.present?
  end
end
