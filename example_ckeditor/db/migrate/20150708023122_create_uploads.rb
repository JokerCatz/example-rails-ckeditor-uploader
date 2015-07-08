class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.integer :type , :null => false #雙用，來做STI，讓檔案和資料夾同一model，不使用String，來源 #http://jokercatz.blogspot.tw/2015/02/rails-sti-type-be-int.html
      t.integer :parent_id #上層資料夾為何(自幹tree或使用gem : acts_as_tree，此處為自幹)
      t.string :name #雙用，圖片為檔名，資料夾為資料夾名
      t.string :image_fingerprint #paperclip打單一欄位上傳： #http://railsfun.tw/t/paperclip/64
      t.timestamps
    end
  end
end
