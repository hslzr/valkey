require "sequel"

DB = Sequel.connect("sqlite://db/valkey.db")

puts "Checking if keys table exists..."
unless DB.table_exists?(:keys)
  puts "Creating keys table..."
  DB.create_table :keys do
    primary_key :id
    String :namespace, null: false
    String :key, null: false
    String :value, null: false
    DateTime :created_at
    DateTime :updated_at
  end
  puts "  Keys table created."
end

require "./valkey_app"

run ValkeyApp
