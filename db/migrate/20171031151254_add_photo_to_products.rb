class AddPhotoToProducts < ActiveRecord::Migration[5.0]
    def change
        add_column :products, :photo, :string, null: true
    end
end
