class RenameRegistrationsToScheduleregs < ActiveRecord::Migration
    def self.up
        rename_table :registrations, :scheduleregs
    end
    def self.down
        rename_table :scheduleregs, :registrations
    end
end
