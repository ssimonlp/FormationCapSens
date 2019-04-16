class AddAasmSateToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :aasm_state, :string
  end
end
