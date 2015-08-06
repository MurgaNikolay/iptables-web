class AddReportField < ActiveRecord::Migration
  def change
    add_column :nodes, :has_errors, :boolean
    add_column :nodes, :report, :text
  end
end
