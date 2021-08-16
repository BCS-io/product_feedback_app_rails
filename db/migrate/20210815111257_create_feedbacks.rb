class CreateFeedbacks < ActiveRecord::Migration[6.1]
  def up
    create_table :feedbacks do |t|
      t.text :title, null: false
      t.integer :upvotes, null: false, default: 0
      t.text :description, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    execute <<-SQL.squish
      CREATE TYPE feedback_category AS ENUM ('enhancement', 'feature', 'bug', 'ui', 'ux');
      CREATE TYPE feedback_status AS ENUM ('suggestion', 'planned', 'in_progress', 'live');
    SQL

    add_column :feedbacks, :category, :feedback_category
    add_column :feedbacks, :status, :feedback_status

    add_index :feedbacks, :category
    add_index :feedbacks, :status
  end

  def down
    drop_table :feedbacks
    execute <<-SQL.squish
      DROP TYPE feedback_category;
      DROP TYPE feedback_status;
    SQL
  end
end
