class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|

    	t.string :name
    	t.string :id_steam

     	t.timestamps
    end
  end
end