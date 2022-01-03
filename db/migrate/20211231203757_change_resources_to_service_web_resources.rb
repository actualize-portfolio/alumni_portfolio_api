# frozen_string_literal: true

class ChangeResourcesToServiceWebResources < ActiveRecord::Migration[6.1]
  def change
    rename_table :resources, :service_web_resources

    rename_column :locations, :resource_id, :service_web_resource_id
  end
end
