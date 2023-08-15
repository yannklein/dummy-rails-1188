class CreateNovels < ActiveRecord::Migration[7.0]
  def change
    create_table :novels do |t|
      t.string :title

      t.timestamps
    end
  end
end
