require 'sequel'

DB = Sequel.sqlite("db/valkey.db")
class Key < Sequel::Model
  plugin :timestamps, update_on_create: true
  plugin :validation_helpers

  def validate
    super
    validates_presence %i[namespace key value]
    validates_unique %i[namespace key]
    validates_format(/\A[a-zA-Z0-9_]+\z/, :key, message: 'must be alphanumeric and underscores only')
    validates_min_length 1, :key
    validates_max_length 64, :key
    validates_min_length 1, :value
    validates_max_length 1024, :value
  end

  def self.find_by_namespace_and_key(namespace:, key:)
    where(namespace: namespace, key: key).first
  end

  def to_json
    {
      namespace: namespace,
      key: key,
      value: value,
      created_at: created_at,
      updated_at: updated_at
    }.to_json
  end

  def sha1
    Digest::SHA1.hexdigest("#{namespace}:#{key}:#{value}")
  end
end
