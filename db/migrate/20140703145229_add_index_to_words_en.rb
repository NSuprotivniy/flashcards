class AddIndexToWordsEn < ActiveRecord::Migration
  def change

  	add_index :words, :en, unique: true
  end
end
