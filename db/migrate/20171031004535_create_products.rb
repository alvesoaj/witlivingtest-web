class CreateProducts < ActiveRecord::Migration[5.0]
    def change
        create_table :products do |t|
            t.string :name, null: false, default: ''
            t.float :price, null: false, default: 0.0
            t.integer :quantity, null: false, default: 0

            t.timestamps
        end
    end
end
